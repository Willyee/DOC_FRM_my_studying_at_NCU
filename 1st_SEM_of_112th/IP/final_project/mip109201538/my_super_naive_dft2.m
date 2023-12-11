function ret = my_super_naive_dft2(inp)

size_inp = size(inp);
%% check input
% check inp is 2D
assert(length(size_inp) == 2);

%% dft
N = size_inp(1);
M = size_inp(2);

ret = zeros(N,M);
for i = 1:N
    for j = 1:M
        for k = 1:N
            for l = 1:M
                ret(i,j) = ret(i,j) + inp(k,l)*exp(-(2i*pi)*( ((i-1)*(k-1)/N) + ...
                                                              ((j-1)*(l-1)/M) ));
            end
        end
    end
end






