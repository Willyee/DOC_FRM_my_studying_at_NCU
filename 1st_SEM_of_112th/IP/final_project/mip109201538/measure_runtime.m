% Input:
%   fun - function handle of the function to be measured
%   x   - an array of cells, each cell is an input
%
% Output:
%   ave_time - run time averaged over cells of x
%   std_time - standard deviation of run times over cell of x 
function [ave_time, std_time] = measure_runtime(fun, x);

n = length(x);

t = zeros(n, 1);

for i = 1: n
  t(i) = timeit(@() fun(x{i}));
end

ave_time = mean(t);
std_time = std(t);

return;
