function [renko] = RenkoBinary(price)
%Description: Creates a renko chart from price series
%
%Inputs:      price = vector
%                  
%% Section 1

renko = zeros(size(price)); %creates empty vector to fill with renko blocks
renko(1) = 0; %assigns first block as zero
for i = 2:length(price) 
    if price(i) > price(i-1) %if closing price today is higher than closing price yesterday
        renko(i) = 1; %adds block
    else
        renko(i) = 0; %removes block
    end
end

end