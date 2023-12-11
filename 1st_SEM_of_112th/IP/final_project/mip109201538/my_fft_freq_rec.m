function ret = my_fft_freq_rec(inp)
size_inp = size(inp);
%% check inp
% check inp is 1D
assert(length(size_inp) == 2);
assert(size_inp(1) == 1 || size_inp(2) == 1)

%% fft
N = length(inp);
W = @(x) exp(-(2i*pi)*x/N);

if  mod(N,2)
    ret = my_naive_dft(inp);
else
    ret = zeros(size_inp);
    inp_frist = zeros(size(inp(1:N/2)));
    inp_last  = zeros(size(inp(1:N/2)));
    for i = 1: N/2
        inp_frist(i) = inp(i) + inp(i+N/2);
        inp_last(i) = (inp(i) - inp(i+N/2)) * W(i-1);
    end
    dft_of_inp_frist = my_fft_freq_rec(inp_frist);
    dft_of_inp_last  = my_fft_freq_rec(inp_last);
    
    ret(1:2:end) = dft_of_inp_frist;
    ret(2:2:end) = dft_of_inp_last;
end
return;