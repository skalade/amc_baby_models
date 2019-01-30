layers = [
    imageInputLayer([sample_size 2 1])

    convolution2dLayer([8 2],8,'Padding',0)
%     batchNormalizationLayer
    reluLayer
%     dropoutLayer(0.5)

    convolution2dLayer([16 1],4,'Padding',0)
%     batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(128)
%     batchNormalizationLayer
    reluLayer
%     dropoutLayer(0.5)

    fullyConnectedLayer(6)
    softmaxLayer
    classificationLayer];

options = trainingOptions('adam', ...
    'MaxEpochs',20, ...
    'Verbose',true, ...
    'Plots','training-progress', ...
    'Shuffle', 'every-epoch');

net = trainNetwork(train_data, train_labels, layers, options);