function [all_datasets] = generateDatasets(data_size, example_size, nsamp, Fs, awgn_levels)

% -------------- FSK2 --------------

% M = 2;        % Modulation order
% freqsep = 256;  % Frequency separation (Hz)
% 
% x = randi([0 M-1], data_size, 1);
% 
% fsk2 = fskmod(x, M, freqsep, nsamp, Fs);

% -------------- FSK4 --------------

M = 4;        % Modulation order
freqsep = 256;  % Frequency separation (Hz)

x = randi([0 M-1], data_size, 1);

fsk4 = fskmod(x, M, freqsep, nsamp, Fs);

% -------------- GMSK --------------

M = 2;

x = randi([0 M-1], data_size, 1);

gmsk_mod = comm.GMSKModulator('BitInput', true);

gmsk = gmsk_mod(x);

% -------------- BPSK --------------

M = 2;        % Modulation order

x = randi([0 M-1], data_size, 1);

qam2_symbols = qammod(x, M, 'UnitAveragePower', true);

txfilter = comm.RaisedCosineTransmitFilter;

qam2 = txfilter(qam2_symbols);

release(txfilter); % because switching from real to complex in QPSK

% -------------- QPSK --------------

M = 4;        % Modulation order

x = randi([0 M-1], data_size, 1);

qam4_symbols = qammod(x, M, 'UnitAveragePower', true);

qam4 = txfilter(qam4_symbols);

% -------------- 8-PSK --------------

M = 8;

x = randi([0 M-1], data_size, 1);

psk8_symbols = pskmod(x, M);

psk8 = txfilter(psk8_symbols);

% -------------- QAM-16 --------------

M = 16;

x = randi([0 M-1], data_size, 1);

qam16_symbols = qammod(x, M, 'UnitAveragePower', true);

qam16 = txfilter(qam16_symbols);

% -------------- Formatting --------------

[fsk4_datasets] = format_Waveform(fsk4, example_size, 1, awgn_levels);
[gmsk_datasets] = format_Waveform(gmsk, example_size, 2, awgn_levels);
[bpsk_datasets] = format_Waveform(qam2, example_size, 3, awgn_levels);
[qam4_datasets] = format_Waveform(qam4, example_size, 4, awgn_levels);
[psk8_datasets] = format_Waveform(psk8, example_size, 5, awgn_levels);
[qam16_datasets] = format_Waveform(qam16, example_size, 6, awgn_levels);

% Concat things - this we can save to file
% all_datasets = cat(1, fsk4_datasets, gmsk_datasets, bpsk_datasets, qam4_datasets, psk8_datasets, qam16_datasets);
all_datasets = cat(1, fsk4_datasets, gmsk_datasets, bpsk_datasets, qam4_datasets, psk8_datasets, qam16_datasets);

end

