function ret = factor_by_recursive(n)

disp(sprintf("Doing %d!:",n));
assert(1<=n);

if n ==1
    ret = 1;
else
    ret = n*factor_by_recursive(n-1);
end
disp(sprintf("Doing %d!=%d",n,ret));
return;
