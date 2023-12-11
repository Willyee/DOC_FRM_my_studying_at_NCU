function ret=Fibonacci_seq(n)

assert(n>=1)

if n <=2
    ret = 1;
else
    ret = Fibonacci_seq(n-1)+Fibonacci_seq(n-2);
end
return;