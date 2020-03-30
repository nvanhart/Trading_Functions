function RW = RandomWalkV1(dimensions,probability)
%  Random Walk - used to test if strategy is significant
%  Input: RW(1,.5) = 1 dimension, 50% (even) liklihood of going up
%         RW(2, 0.7) = 2 dimensions, 70% liklihood of going up
%%
N = 5000; % Length of the x-axis, also known as the length of the random walks.
M = 500; % The amount of random walks.
x_t(1) = 0;
y_t(1) = 0;
z_t(1) = 0;

if dimensions == 1
 for m=1:M
    for n = 1:N % Looping all values of N into x_t(n).
        %A = sign(randn); % Generates either +1/-1 depending on the SIGN of RAND.
        u = rand;
        if u < probability
            A = 1;
        else
            A = -1;
        end
        x_t(n+1) = x_t(n) + A;
    end
    plot(x_t);
    hold on
 end
 
elseif dimensions == 2 %2D

for m=1:M
  for n = 1:N % Looping all values of N into x_t(n).
    A = sign(randn); % Generates either +1/-1 depending on the SIGN of RAND.
    x_t(n+1) = x_t(n) + A;
    A = sign(randn); % Generates either +1/-1 depending on the SIGN of RAND.
    y_t(n+1) = y_t(n) + A;
  end
  plot(x_t, y_t);
  hold on
end
axis square;

elseif dimensions == 3 %3D
    
for m=1:M
  for n = 1:N % Looping all values of N into x_t(n).
    A = sign(randn); % Generates either +1/-1 depending on the SIGN of RAND.
    x_t(n+1) = x_t(n) + A;
    A = sign(randn); % Generates either +1/-1 depending on the SIGN of RAND.
    y_t(n+1) = y_t(n) + A;
    A = sign(randn); % Generates either +1/-1 depending on the SIGN of RAND.
    z_t(n+1) = z_t(n) + A;
  end
  plot3(x_t, y_t, z_t);
  hold on
end

end