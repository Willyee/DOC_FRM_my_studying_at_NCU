function ret = my_naive_dft(inp)

size_inp = size(inp);
%% check input
% check inp is 1D
assert(length(size_inp) == 2);
assert(size_inp(1) == 1 || size_inp(2) == 1)


%% dft
ret = zeros(size_inp);
N = length(inp);
W = @(x) exp(-(2i*pi)*x/N);

for i = 1:N
    X_i = 0;
    for j = 1:N
        X_i = X_i + inp(j)*W((i-1)*(j-1));
    end
    ret(i) = X_i;
end

return;