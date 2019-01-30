function [train_data, train_labels] = formatForMatlab(datasets)

% Put all waveforms together
train_data = zeros(size(datasets, 1)*size(datasets(1).waveform,1), size(datasets(1).waveform, 2), 2);
for i = 1:size(datasets,1)
    train_data((i-1)*size(datasets(i).waveform,1)+1:(i)*size(datasets(i).waveform,1),:,:) = datasets(i).waveform;
end

% Labels
train_labels = zeros(size(train_data, 1), 1);
for i = 1:size(datasets,1)
    label_slice = ones(size(datasets(i).waveform, 1), 1) * datasets(i).label;
    train_labels((i-1)*size(datasets(i).waveform,1)+1:(i)*size(datasets(i).waveform,1)) = label_slice;
end

% Weird permutations needed for matlab NN toolbox...

% Rework train data
train_data = permute(train_data, [2 3 1]);

train_data = reshape(train_data, [128, 2, 1, size(train_data,3)]);

% Make labels categorical
train_labels = categorical(train_labels);

end

