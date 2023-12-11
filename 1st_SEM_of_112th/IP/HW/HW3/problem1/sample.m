function x_p = sample(x, N)
% Sample every N-th point from input signal. The x_p should be of the same
% size as input, and is set to zero at indices not divisible by N.

% Make sure input is 1-D array.
s = size(x);
assert(length(s) <= 2);
assert(s(1) == 1 || s(2) == 1);

assert(1 <= N);

x_p = zeros(size(x));

% Fill in details to sample x into x_p.

x_len = length(x);

x_p(N:N:x_len) = x(N:N:x_len);
return;
