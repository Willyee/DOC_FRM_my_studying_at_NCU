function ret = my_bitrevorder(inp)

assert(size(inp,1)==1 && size(inp,2)==1)

isaninteger = @(x) isfinite(x) & x==floor(x);
assert(isaninteger(inp))

n = 2^inp;
ret = zeros(1,n);
order = 0:(n-1);
bit_order = dec2bin(order);


for i = 1:n
    tmp = bit_order(i,:);
    ret(i) = bin2dec(tmp(end:-1:1));
end
