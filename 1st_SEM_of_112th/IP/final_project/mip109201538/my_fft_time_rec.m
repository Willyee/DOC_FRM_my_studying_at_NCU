function ret = my_fft_time_rec(inp)

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
    inp_even = inp(1:2:end);
    inp_odd  = inp(2:2:end);
    dft_of_inp_even = my_fft_time_rec(inp_even);
    dft_of_inp_odd  = my_fft_time_rec(inp_odd);
    for i = 1: length(inp_odd)
        ret(i) = dft_of_inp_even(i) + dft_of_inp_odd(i)*W(i-1);
        ret(i+N/2) = dft_of_inp_even(i) + dft_of_inp_odd(i)*W(N/2+i-1);
    end
end
return;