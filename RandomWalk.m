function RW = RandomWalk(dimensions,probability,RR)
%  Random Walk - used to test if strategy is significant
%  
%  RW simulates random walk with an RR:1 risk:reward ratio. For each step or
%  trade, 1 unit is gained or lost.
%  
%  Input: RW(1, .5, 1) = 1D, 50% (even) liklihood of going up, risking 1 unit to gain 1
%         RW(2, 0.7, 2) = 2D, 70% liklihood of going up, risking 2 units to gain 1
%         RW(1, .65, 1.5) = 65% success rate, RR = 1.5 (SL = .5/.3, PT = 1.33/1.2) OPTIMAL, 95% win
%         following 250 trades
%
%  CONCLUSIONS: AIM FOR 70% SUCCESS RATE W 1.5 OR BETTER RR. 
%%
N = 250; %number of the random walk steps/trades/wagers.
M = 150; %number of trials (graph lines)
x_t(1) = 0;
y_t(1) = 0;
z_t(1) = 0;

w = 0; %count for winners

if dimensions == 1
 for m = 1:M
    for i = 1:N % Looping all values of N into x_t(n).
        u = rand; %random number between 0-1 (even probabilities)
        if u < probability %probality function
            A = 1;
        else
            A = -1*RR; %multiplied by risk - always risking X to get 1 reward
        end
        y_t(i+1) = y_t(i) + A;
    end
    plot(y_t);
    hold on
    xlabel('Step/Trade Number')
    ylabel('Initial Unit Multiplier')
    title_raw = '%d Random Walk Simulations (%s%% success, %s:1 Risk:Reward)';
    p = string(probability*100);
    rr = string(RR);
    title(sprintf(title_raw,M,p,rr))
    if y_t(end) > 0
       w = w + 1;
    end
 end
 w/M

elseif dimensions == 2 %2D

for m=1:M
  for i = 1:N % Looping all values of N into x_t(n).
    %A = sign(randn); % Generates either +1/-1 depending on the SIGN of RAND.
    u = rand;
        if u < probability
            A = 1;
        else
            A = -1;
        end
    x_t(i+1) = x_t(i) + A;
    %A = sign(randn); % Generates either +1/-1 depending on the SIGN of RAND.
    y_t(i+1) = y_t(i) + A;
  end
  plot(x_t, y_t);
  hold on
end
axis square;

elseif dimensions == 3 %3D
    
for m=1:M
  for i = 1:N % Looping all values of N into x_t(n).
    A = sign(randn); % Generates either +1/-1 depending on the SIGN of RAND.
    x_t(i+1) = x_t(i) + A;
    A = sign(randn); % Generates either +1/-1 depending on the SIGN of RAND.
    y_t(i+1) = y_t(i) + A;
    A = sign(randn); % Generates either +1/-1 depending on the SIGN of RAND.
    z_t(i+1) = z_t(i) + A;
  end
  plot3(x_t, y_t, z_t);
  hold on
end

end