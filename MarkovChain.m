function [mcN] = MarkovChain(timeSeries,step)
% Assigns states using Renko Plot (adds block if price(n+1) > price(n)).
% Calculates number of unique states, then creates Markov Chain transition
% matrix for states. 
%
% Required Input: time series, number of steps
% Ex: AAPL_MC = MarkovChain(AAPL.close,1)
%
% To add: State criteria, most probably transition given current state,
% full transition matrix for current state (real time result).
%

%% Section 1: Convert to renko
r = Renko(timeSeries);
offset = min(r); %NEED TO SET MIN = 1 to fill matrix, then create table w proper labels for trans mat
if offset < 0
    offset = -1*offset + 1;
    tr = r + offset; %adds offset
else
    offset = -1*offset +1; 
    tr = r - offset;
end

numStates = length(unique(r));
transMat = zeros(numStates); %creates n by n matrix, where n = number of unique states

for i = 1:(length(tr)-1) %counts transition numbers
    row = tr(i);
    column = tr(i+1);
    transMat(row,column) = transMat(row,column)+1;
end

rowSum = zeros(length(transMat),1); %counts row sums
for ii = 1:length(rowSum)
    rowSum(ii) = sum(transMat(ii,:));
end

mc = transMat./rowSum; %occurence to probability matrix
mcN = mc^step; %N step transition matrix

states = sort(unique(r)); %creates sorted list of all states in transition matrix
rowName = "i" + strrep(string(states),'-','_'); %i-j notation
colName = "j" + strrep(string(states),'-','_');

mcN = array2table(mcN,'VariableNames',colName,'RowNames',rowName); %tabulates results w proper state name


