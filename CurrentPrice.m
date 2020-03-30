function [cp] = CurrentPrice(ticker)
% Provides the current price (adjClose) to the nearest minute
%
% Inputs: 
% tickers: (Yahoo!-formatted) ticker symbols
%
% Example:
% cp = CurrentPrice('AAPL'), CurrentPrice('USDZAR=X')
%% section 1: collect data

ct = datetime('now','Timezone','-05:00','Format','d-MMM-y HH:mm:ss');
P1 = posixtime(ct-0.1); %converts to Unix time 
P2 = posixtime(ct); %converts to Unix time current time

%weboption constructor.
opts = weboptions();

%URL query
formatSpec = 'https://query1.finance.yahoo.com/v8/finance/chart/%s?interval=1m&period1=%.0f&period2=%.0f';
%https://sites.google.com/site/matlabnote0722/home/formatspec 
%a site for formatting numbers in various ways
url1 = sprintf(formatSpec,ticker,P1,P2);
data = webread(url1,opts);
dates    = (datetime(data.chart.result.timestamp,'ConvertFrom','posixtime','Timezone','-05:00'));
close    = (data.chart.result.indicators.quote.close);

%% section 2: output data
cp = close(end); %last closing price (most current price)

end
