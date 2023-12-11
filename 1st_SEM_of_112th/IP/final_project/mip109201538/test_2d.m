clear
close all

n = [1, 8, 56, 64]%, 93, 112, 255, 256];

% do_ff2 = n;
% do_super_naive = [1, 8, 64, 256];
% do_naive = n;
% do_my_fft = n;

t_fft2 = nan(size(n));
t_super_naive = nan(size(n));
t_naive_dft2 = nan(size(n));
t_fft2_time = nan(size(n));
t_fft2_freq = nan(size(n));

num_test = 5;


for k = 1: length(n)

    disp('Input size:');
    disp(n(k));

    x = cell(1, num_test);
    for i = 1: num_test
        x{1, i} = rand(n(k)) + j * rand(n(k));
    end

    disp('Testing 2-D DFT algorithms');

    disp('fft');
    [t_fft2(k), s] = measure_runtime(@ifft2, x);
    ref = fft2(x{1});

    if n(k) < 56
        disp('super naive')
        [t_super_naive(k), s] = measure_runtime(@my_super_naive_dft2, x);
        super_naive = my_super_naive_dft2(x{1});
    end

    disp('naive')
    [t_naive_dft2(k), s] = measure_runtime(@my_naive_dft2, x);
    naive_dft2 = my_naive_dft2(x{1});

    disp('fft2 decimation in time');
    [t_fft2_time(k), s] = measure_runtime(@my_fft2_time, x);
    fft2_time = my_fft2_time(x{1});

    disp('fft2 decimation in freq');
    [t_fft2_freq(k), s] = measure_runtime(@my_fft2_freq, x);
    fft2_freq = my_fft2_freq(x{1});

    if n(k) < 56
        check_error(ref, super_naive);
    end

    check_error(ref, naive_dft2);
    check_error(ref, fft2_time);
    check_error(ref, fft2_freq);

end

loglog(n, t_fft2, '-', 'LineWidth', 3);
hold on
loglog(n, t_super_naive, '-', 'LineWidth', 3);
loglog(n, t_naive_dft2, '-', 'LineWidth', 3);
loglog(n, t_fft2_time, '-', 'LineWidth', 3);
loglog(n, t_fft2_freq, '-', 'LineWidth', 3);
xlabel('input size N');
ylabel('runtime (s)');

legend('fft2', 'super naive', 'naive dft2', 'fft2 time', 'fft2 freq');
title('2D DFT');
