function ret = my_fft2_freq(inp)
size_inp = size(inp);
%% check input
% check inp is 2D
assert(length(size_inp) == 2);

%% fft
N = size_inp(1);
M = size_inp(2);

pre_inp = inp;
cur_inp = zeros(N,M);
for i = 1:N
    cur_inp(i,:) = my_fft_freq_iter(pre_inp(i,:));
end
pre_inp = cur_inp;

cur_inp = zeros(N,M);
for i = 1:M
    cur_inp(:,i) = my_fft_freq_iter(pre_inp(:,i));
end

ret = cur_inp;

return;