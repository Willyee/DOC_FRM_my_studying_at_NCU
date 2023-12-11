function ret = Fibonacci_seq_iterative(n)

assert(n>=1)

if n<=2
    ret = 1;
else
    init = [1;1];
    final = mpower([1 1; ...
                    1 0], n-2)*init;
end
ret = final(1);
return;


