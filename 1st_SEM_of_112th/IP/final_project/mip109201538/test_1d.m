clear
close all

n = [1, 8, 64, 256, 301, 4032, 5120];

t_fft = nan(size(n));
t_naive = nan(size(n));
t_fft_time_rec = nan(size(n));
t_fft_time_iter = nan(size(n));
t_fft_freq_rec = nan(size(n));
t_fft_freq_iter = nan(size(n));

num_test = 10;

for k = 1: length(n)

    disp('Input size:');
    disp(n(k));

    rng shuffle;
    % create the test of random complex number
    test_cases = cell(1, num_test);
    for i = 1: num_test
        test_cases{1, i} = rand(n(k), 1) + j * rand(n(k), 1);

        % random column or row
        if randi(2) == 1
            test_cases{1, i} = test_cases{1, i}.';
        end
    end

    disp('Testing DFT algorithms');

    disp('FFT');
    [t_fft(k), s] = measure_runtime(@fft, test_cases);
    % pick the frist data to measure error
    ref = fft(test_cases{1});

    disp('naive DFT');
    if n(k) < 4032
        [t_naive(k), s] = measure_runtime(@my_naive_dft, test_cases);
        naive = my_naive_dft(test_cases{1});
    end

    disp('my recursive fft decimation in time');
    [t_fft_time_rec(k), s] = measure_runtime(@my_fft_time_rec, test_cases);
    fft_time_rec = my_fft_time_rec(test_cases{1});

    disp('my iterative fft decimation in time');
    [t_fft_time_iter(k), s] = measure_runtime(@my_fft_time_iter, test_cases);
    fft_time_iter = my_fft_time_iter(test_cases{1});

    disp('my recursive fft decimation in frequency');
    [t_fft_freq_rec(k), s] = measure_runtime(@my_fft_freq_rec, test_cases);
    fft_freq_rec = my_fft_freq_rec(test_cases{1});

    disp('my iterative fft decimation in frequency');
    [t_fft_freq_iter(k), s] = measure_runtime(@my_fft_freq_iter, test_cases);
    fft_freq_iter = my_fft_freq_iter(test_cases{1});


    if n(k) < 4032
        check_error(ref, naive);
    end
    check_error(ref, fft_time_rec);
    check_error(ref, fft_time_iter);
    check_error(ref, fft_freq_rec);
    check_error(ref, fft_freq_iter);

end

loglog(n, t_fft, '-', 'LineWidth', 3);
hold on
loglog(n, t_naive, '-', 'LineWidth', 3);
loglog(n, t_fft_time_rec, '-', 'LineWidth', 3);
loglog(n, t_fft_time_iter, '-', 'LineWidth', 3);
loglog(n, t_fft_freq_rec, '-', 'LineWidth', 3);
loglog(n, t_fft_freq_iter, '-', 'LineWidth', 3);
xlabel('input size N');
ylabel('runtime (s)');

legend('fft', 'naive', 'time-rec', 'time-iter', 'freq-rec', 'freq-iter');
