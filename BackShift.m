function y = BackShift(lagPeriod,priceSeries)
% Lags a price array by defined lag period 
% Can calculate daily returns, where lagPeriod = 1 day, priceSeries = close
%
% Example: dailyRet = (final - initial) / initial 
%          dailyRet = (close-backshift(1,close))./backshift(1,close)
%          afterHourRet = (open - backshift(1,close)) ./ backshift(1,close)
% 
%%
y = [NaN(lagPeriod,size(priceSeries,2)); priceSeries(1:end-lagPeriod,:)];
end

