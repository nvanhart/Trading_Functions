function [avgPrice] = AveragePrice(prevAvg,numPrevShares,priceNewShares,numNewShares) 
% Description: Updates average price per share
%
%
avgPrice = ((prevAvg * numPrevShares) + (numNewShares * priceNewShares)) / (numNewShares + numPrevShares);