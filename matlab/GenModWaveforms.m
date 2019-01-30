% Training dataset creation

% Set random seed
rng(69)

% Common params
data_size = 1024*32; % Number of symbols
example_size = 128; % Number of I/Q samples per training example
nsamp = 8;    % Number of samples per symbol
Fs = 1024;    % Sample rate (Hz)

awgn_levels = [30 35]; % Power-of-2 SNR levels here

all_datasets = generateDatasets(data_size, example_size, nsamp, Fs, awgn_levels);

% Validation dataset creation

% Set random seed
rng(1337)

all_datasets_val = generateDatasets(1024, example_size, nsamp, Fs, [20 25]);

% -------------- This is for MATLAB only --------------

[train_data, train_labels] = formatForMatlab(all_datasets);

[val_data, val_labels] = formatForMatlab(all_datasets_val);
