function [output] = OverUnderRatio(timeSeries)
% Calculates the percent of time over the defined period during which time
% is increasing. Takes dp/dt, integrates positive area, integrates negative
% area, divides area > 0 and below curve by total area under/over curve.
% See visual digram here:
% https://www.mathworks.com/matlabcentral/answers/289404-area-under-and-above-curve
% 
% Used to estimate current trend direction (mins/hours/days). Can identify
% entry points by using larger period (weeks/months/years) trends in mean
% reversion type strategies (e.g. locate instrument spent predominantly in
% a state of price increase, buy when price is decling. What is avg time?
% what constitutes large time? >70% ? >90%?
%
%% Section 1: Differentiate, calculate areas
dpdt = diff(timeSeries);
dpdt = vertcat(0,dpdt);
posA = sum(dpdt(dpdt > 0)); %area above 0 and below curve - time price increasing (RoC > 0)
negA = sum(dpdt(dpdt < 0)); %area below 0 and above curve - time price declining (RoC < 0)

%% Section 2: Calculate %
ratio = posA / (posA + abs(negA));
output = ratio;