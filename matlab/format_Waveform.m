function [datasets] = format_Waveform(waveform, sample_size, label_num, awgn_levels)

datasets = [];

slice_size = size(waveform, 1)/size(awgn_levels, 2);

for i = 1:size(awgn_levels,2)
    temp_waveform = awgn(waveform((i-1)*slice_size + 1 : i*slice_size), awgn_levels(i));
    
    temp_waveform = reshape(temp_waveform, [], sample_size);
    
    wav_real = real(temp_waveform);
    wav_imag = imag(temp_waveform);
    
    dataset.snr = awgn_levels(i);
    dataset.waveform = cat(3, wav_real, wav_imag);
    dataset.label = label_num;
%     dataset.labels = ones(size(dataset.waveform, 1), 1) * label_num;

    datasets = cat(1, datasets, dataset);
end


end

