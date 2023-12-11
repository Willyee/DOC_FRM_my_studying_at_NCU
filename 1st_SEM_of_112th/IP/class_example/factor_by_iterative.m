function ret = factor_by_iterative(n)

assert(1<=n);

ret = 1;

for i = 1:n
    ret = ret*i;
end

return;
