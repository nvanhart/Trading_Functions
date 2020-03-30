function prob = LongTermSuccess(successRate,initialCap,objCap)
% Use to determine probability of success
% A function to determine probability of reaching an objective capital
% given starting capital and success rate of strategy
% Need to adjust to add in time, risk:reward aspect. Currently fixed at 1:1
%%
p = successRate;
q = 1-p; %failure
i = initialCap;
n = objCap;
prob = (1-(q/p)^i)/(1-(q/p)^n);
