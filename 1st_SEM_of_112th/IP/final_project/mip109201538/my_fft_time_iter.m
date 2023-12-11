function ret = my_fft_time_iter(inp)
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

    %% sort
    pre_inp = inp;
    for i = 1:num_of_factor_2
        cur_inp = zeros(size(pre_inp,1)/2,size(pre_inp,2)*2);
        for j = 1:size(pre_inp,2)
            cur_inp(:,j*2-1) = pre_inp(1:2:end,j);
            cur_inp(:,j*2) = pre_inp(2:2:end,j);
        end
        pre_inp = cur_inp;
    end
    % example:
    % input = (1:12)'
    % ouput = [ 1  3  2  4;
    %           5  7  6  8;
    %           9 11 10 12]

    %% 1D dft of part
    for i = 1:2^num_of_factor_2
        cur_inp(:,i) = my_naive_dft(pre_inp(:,i));
    end

    %% fft
    W_x = @(x,n) exp(-(2i*pi)*(x-1)/n);
    pre_inp = cur_inp;

    for i = 1:num_of_factor_2
        n = size(pre_inp,1)*2;
        cur_inp = zeros(n,size(pre_inp,2)/2);
        W = W_x(1:n,n);
        for j = 1:2^(num_of_factor_2-i)

            for k = 1:n/2
                cur_inp(k, j) = pre_inp(k,j*2-1)+W(k)*pre_inp(k,j*2);
                cur_inp(n/2+k, j) = pre_inp(k,j*2-1)+W(n/2+k)*pre_inp(k,j*2);
            end
        end
        pre_inp = cur_inp;
    end

    if is_row
        ret = cur_inp.';
    else
        ret = cur_inp;
    end
end
return;
