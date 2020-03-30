function [mcN] = BinaryMC(timeSeries,step)
% Calculates the two state, binary Markov Chain transition matrix from a
% time series. Transforms time series into a Binary Renko plot (see Binary
% Renko), then calculates the two state probabilities. Can specify number
% of steps. 
%
% Ex: AAPL_MC = BinaryMC(AAPL.close,1)
%% Section 1: Convert to renko
stateVector = RenkoBinary(timeSeries); %reduces to 2 states
SS = 0; %counters for MC matrix [ab/cd], where a = 0-0, b = 0-1, c = 1-0, d = 1-1
SL = 0; %SL = short to long 1 step
LS = 0; %LS = long to short 1 step
LL = 0; %LL = long to long 1 step

%% Section 2: Create chain
for h = 2:length(stateVector) %first renko will not have lookback
    if stateVector(h) == 0
        if stateVector(h-1) == 0
            SS = SS + 1; %pi(0-0), MC(1,1)
        else
            LS = LS + 1; %pi(1-0), MC(2,1)
        end
     elseif stateVector(h-1) == 1
         LL = LL + 1; %pi(1-1), MC(2,2)
     else
         SL = SL + 1; %pi(0-1), MC(1,2)
     end
end
    
a = SS / (SS+SL); %probabilities calculated from number of occurences. rows sum to 1
b = SL / (SS+SL);
c = LS / (LS+LL);
d = LL / (LS+LL);
mc = [a b;c d]; %1 step transition matrix
mcN = mc^step; %N step transition matrix
ac = mcN(:,1);
bd = mcN(:,2);
mcN = table(ac, bd, 'VariableNames', {'short','long'}, 'RowNames', {'short','long'});
