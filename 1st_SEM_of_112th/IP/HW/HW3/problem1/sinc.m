function output = sinc(x)
x_equal_zero = x~=0;

output = ones(size(x));
for i = 1:length(x)
    if x_equal_zero(i)
        output(i) = sin(x(i)*pi)/(x(i)*pi);
    end
end
        
