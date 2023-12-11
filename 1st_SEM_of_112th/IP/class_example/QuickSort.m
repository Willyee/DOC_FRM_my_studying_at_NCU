function ret = quickSort(x)

if length(x) == 0
    ret = [];

elseif length(x) == 1
    ret = x;

else
    p = median(x);
    x1 = x(x < p);
    x2 = x(x == p);
    x3 = x(x > p);

    y1 = quickSort(x1);
    y2 = quickSort(x3);
    ret = [y1 x2 y2];
end
return;