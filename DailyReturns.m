function Returns = DailyReturns(priceSeries,varargin)
% A function to generate array of daily returns in %
%
% Ex: daily = DailyRet(uwt.close)
%     weekly = DailyRet(uwt_weekly.close,uwt_weekly.date)

%% Section 1: Calc returns
Returns = (priceSeries-BackShift(1,priceSeries))./BackShift(1,priceSeries)*100;

%% Section 2: Plot
if nargin > 1
    plot(varargin{:},Returns)
end
