function check_error(ref, x)

assert(length(size(x)) == length(size(ref)));

for k = 1: length(size(x))
  assert(size(x, k) == size(ref, k));
end

er = abs(ref - x) ./ abs(ref);
er = er(:);

assert(max(er) < 1e-6);
