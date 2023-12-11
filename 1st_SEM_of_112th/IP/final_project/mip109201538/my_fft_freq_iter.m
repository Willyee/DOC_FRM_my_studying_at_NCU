function ret = my_fft_freq_iter(inp)
size_inp = size(inp);

%% check input
% check inp is 1D real vector
assert(length(size_inp) == 2);
assert(size_inp(1) == 1 || size_inp(2) == 1);

%% calculus 2nd power

inp_length_2_bin = dec2bin(length(inp),'1');
num_of_factor_2 = 0;
for i = inp_length_2_bin(end:-1:1)
    if i == '1'
        break
    end
    num_of_factor_2 = num_of_factor_2 +1;
end
if num_of_factor_2 == 0
    ret = my_naive_dft(inp);
else
    %% fix input is column
    is_row = 0;
    if size_inp(1) == 1
        inp=inp.';
        is_row = 1;
    end

    %% fft
    pre_inp = inp;
    for i = 1:num_of_factor_2
        [n,m] = size(pre_inp);
        cur_inp = zeros((n/2), (m*2));
        W = @(x) exp(-(2i*pi)*x/n);
        for j = 1:m
            for k = 1:n/2
                cur_inp(k,j*2-1) = pre_inp(k,j) + pre_inp(n/2+k,j);
                cur_inp(k,j*2) = (pre_inp(k,j) - pre_inp(n/2+k,j)) * W(k-1);
            end
        end
        pre_inp = cur_inp;
    end
    
    %% part 4 dft
    for i = 1:2^num_of_factor_2
        cur_inp(:,i) = my_naive_dft(pre_inp(:,i));
    end
    pre_inp = cur_inp;

    %% sort by bit-reversed
    cur_inp = pre_inp(:,my_bitrevorder(num_of_factor_2)+1);
    %% sort all
    [n,m] = size(cur_inp);
    ret = zeros(size_inp);

    for i = 1:n
        ret(m*(i-1)+1:m*i) = cur_inp(i,:);
    end

end
return;