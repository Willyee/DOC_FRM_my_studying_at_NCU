
clear;
close all;

N = 100;

display_interval = 1. / N;

duration_in_second = 10;

frequency = 0.3;

%Create the original signal x(t)
x = sin(2 * pi * [display_interval: display_interval: duration_in_second] * frequency);

%Sample x(t) to obtain x_p(t), except it doesn't really have Dirac deltas
x_p = sample(x, N);

%Attempt to recover x(t) from x_p(t) using sinc function. The recovered signal
%is x_hat
[t, x_hat] = recover(x_p, N);

plot(t, x, t, x_hat, t, x_p);

legend('original', 'recovered', 'sampled');
