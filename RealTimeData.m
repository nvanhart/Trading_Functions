function [rt] = RealTimeData(symbol, granularity, lookback, prePost)
% Yahoo Query for price/volume series 
%
% Inputs: 
% symbol        = (Yahoo!-formatted) ticker symbols
% granularity   = 1m | 2m, 5m, 15m, 30m, 60m, 90m, 1d, 5d, 1mo, 3mo, 
%                 6mo, 1y, 2y, 5y, 10y, ytd, max
%
% historicRange = valid historical ranges:
%                 1m-2m: 1d, 5d; 5m-max: 1d - max
%
% prePost       = true to include pre/post market data
%
% EXAMPLE: 
% rt = RealTimeData('AAPL','1m','5d','true'); 1 minute for past 5 days
% rt.close = RealTimeData('cron','3mo','1y','false');
% 
%% section 1: collect data
opts = weboptions('TimeOut',15);
formatSpec = 'https://query1.finance.yahoo.com/v8/finance/chart/%s?includePrePost=%s&interval=%s&range=%s';
  %https://sites.google.com/site/matlabnote0722/home/formatspec: a site for formatting numbers in various ways
url1 = sprintf(formatSpec,symbol,prePost,granularity,lookback)
data = webread(url1,opts); %outputs data as structure; uses dot indexing below to extract vectors

dates    = (datetime(data.chart.result.timestamp,'ConvertFrom','posixtime','Timezone','-04:00'));
high     = (data.chart.result.indicators.quote.high);
low      = (data.chart.result.indicators.quote.low);
vol      = (data.chart.result.indicators.quote.volume);
open     = (data.chart.result.indicators.quote.open);
close    = (data.chart.result.indicators.quote.close);

%% section 2: output data
rt = (table(dates,open,high,low,close,vol));

end
