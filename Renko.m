function [renko] = Renko(price,varargin)
%Description: Creates a renko chart from price series
%
%Inputs:      price = vector
%                  
%% Section 1: Assemble Chain
renko = zeros(size(price)); %creates empty vector to fill with renko blocks
count = 0; 
renko(1) = 0; %assigns first block as zero
for i = 2:length(price) 
    if price(i) > price(i-1)
        count = count + 1; %adds block
        renko(i) = count;
    else
        count = count - 1; %removes block
        renko(i) = count;
    end
end

%% Section 2: Plot results
if nargin > 1
    x = (1:length(renko))';
    s10 = SMA(renko,10);
    s30 = SMA(renko,30);
    plot(x,renko,x,s30,x,s10)
end
end
