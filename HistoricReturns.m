function [t1] = HistoricReturns(ticker, startDate, endDate, frequency)
% Framework replaced by RealTimeData. Includes daily rate of return output.
%
% Inputs: 
% tickers: (Yahoo!-formatted) ticker symbols
% startDate, endDate: year-month-day
% frequency data period: [1d, 5d, 1wk, 1mo, 3mo]
%                       this is the frequency of data
%
% Outputs:
% dates open high low close adjclose vol
%
% EXAMPLE:
% data = HistoricReturns('^GSPC','2010-01-01','2018-09-27','3mo');

hD1 = datetime(startDate); %converts to start date time 
hP1 = posixtime(hD1); %converts to Unix time
hD2 = datetime(endDate); %converts to end date time 
P2 = posixtime(hD2); %converts to Unix time

%weboption constructor. Need to ask what this does.
opts = weboptions();

%URL query
formatSpec = 'https://query1.finance.yahoo.com/v8/finance/chart/%s?interval=%s&period1=%d&period2=%d';
url1 = sprintf(formatSpec,ticker,frequency,hP1,P2);
data = webread(url1,opts);

%NOTE!! Original code used flipud (e.g. flipud(data.chart...))
%This messed up SMA calculation; would start at present time rather than
%time 0. Need to ask someone on this.

%Get data. Timezone is in EST, is abritrary for periods > 1d
hDates    = (datetime(data.chart.result.timestamp,'ConvertFrom','posixtime','Timezone','-04:00'));
hHigh     = (data.chart.result.indicators.quote.high);
hLow      = (data.chart.result.indicators.quote.low);
hVol      = (data.chart.result.indicators.quote.volume);
hOpen     = (data.chart.result.indicators.quote.open);
hClose    = (data.chart.result.indicators.quote.close);
hAdjClose = (data.chart.result.indicators.adjclose.adjclose);

%Manipulate data.
hDailyRet = 100*(hAdjClose-BackShift(1,hAdjClose))./BackShift(1,hAdjClose); 
hOHLC = [hOpen+hHigh+hLow+hAdjClose]/4;
hPrevDayClose = BackShift(1,hAdjClose);

%calculate returns on $1000 investment
hTotalRet = zeros(size(hDates));
shares = 1000 / hOpen(1);
for i = 1:length(hDates) 
    hTotalRet(i) = shares * hAdjClose(i);
end

%Create table.
t1 = (table(hDates,hOpen,hHigh,hLow,hAdjClose,hPrevDayClose,hOHLC,hDailyRet,hTotalRet));

end