function [t, x_hat] = recover(x_p, N);
% Recover the original 1-D signal from the input 1-D sampled signal using sinc
% function.
% 
% Output t, representing time, should be of the same size as input. Its i-th
% element will be i / N
% 
% Output x_hat should be the recovered signal with the same length as t

N = double(N);

% Make sure input is 1-D array.
s = size(x_p);

assert(length(s) <= 2);
assert(s(1) == 1 || s(2) == 1);

assert(1 <= N);

display_interval = 1 / N;
duration_in_second = length(x_p) * display_interval;

t = display_interval : display_interval: duration_in_second;

x_hat = zeros(size(t));

% Fill in detail to attempt to recover x as x_hat from x_p

for i = 1:length(x_hat)
    x_hat = x_hat + x_p(i).*sinc(t-i*display_interval);
end
return;
