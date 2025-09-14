close all;
clear;
%%
% Defining the paths of the two folders
image_folder_path = 'C:\Users\nikhi\Desktop\MSc DS\6-Computer Vision\project\data_for_moodle\images_256'; % Folder containing flower images
label_folder_path = 'C:\Users\nikhi\Desktop\MSc DS\6-Computer Vision\project\data_for_moodle\labels_256'; % Folder containing label images
output_folder_path = 'C:\Users\nikhi\Desktop\MSc DS\6-Computer Vision\project\data_for_moodle\images'; % Path of the new folder to create

% Get a list of file names in each folder to compare the segmentation maps
% with input flowers.
image_files = dir(fullfile(image_folder_path, '*.jpg'));
label_files = dir(fullfile(label_folder_path, '*.png'));

% Extracting file names from the directory structures
image_file_names = {image_files.name};
label_file_names = {label_files.name};

% Iterate over image files and Check if the corresponding segmentation map
% exists in the label folder and finally Copy the image file to the output folder
for i = 1:length(image_files)
    [~, file_name, ~] = fileparts(image_files(i).name);
    if ismember([file_name '.png'], label_file_names)
        copyfile(fullfile(image_folder_path, image_files(i).name), fullfile(output_folder_path, image_files(i).name));
    end
end
%%
imDir = 'C:\Users\nikhi\Desktop\MSc DS\6-Computer Vision\project\data_for_moodle\images';
pxDir = 'C:\Users\nikhi\Desktop\MSc DS\6-Computer Vision\project\data_for_moodle\labels_256';

% Custom read function to apply Gaussian filter to remove the noise in the
% input
customReadFcn = @(filename) imresize(imgaussfilt(imread(filename), 2), [256 256]);


imds = imageDatastore(imDir, 'ReadFcn', customReadFcn);

%groundtruth labels
classNames = ["flower","background"];
pixelLabelID   = [1, 3]; 
pxds = pixelLabelDatastore(pxDir,classNames,pixelLabelID);

%%
inputSize = [256 256 3];
%Data augmentation to increase the data size used in the training process.
imageAugmenter = imageDataAugmenter( ...
    'RandRotation',[-2 2], ...
    'RandScale',[0.9 1.1],...
    'RandXTranslation',[-10 10], ...
    'RandYTranslation',[-10 10]);


augImds = pixelLabelImageDatastore(imds, pxds, ...
    'DataAugmentation', imageAugmenter, ...
    'OutputSize', inputSize);

augImds.NumObservations
augImds = shuffle(augImds);

%%
inputSize = [256 256 3];

%Input layer
imgLayer = imageInputLayer(inputSize)

% Downsampling 
downsamplingLayers = [
    convolution2dLayer(3, 64, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    convolution2dLayer(3, 64, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2, 'Stride', 2)
    
    convolution2dLayer(3, 128, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    convolution2dLayer(3, 128, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2, 'Stride', 2)
    
    convolution2dLayer(3, 256, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    convolution2dLayer(3, 256, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2, 'Stride', 2)
];


% Upsampling
upsamplingLayers = [
    transposedConv2dLayer(4, 256, 'Stride', 2, 'Cropping', 1)
    batchNormalizationLayer
    reluLayer
    
    transposedConv2dLayer(4, 128, 'Stride', 2, 'Cropping', 1)
    batchNormalizationLayer
    reluLayer
    
    transposedConv2dLayer(4, 64, 'Stride', 2, 'Cropping', 1)
    batchNormalizationLayer
    reluLayer
];


numClasses = 2;
% Fully Connected layer.
finalLayers = [
    convolution2dLayer(1, numClasses)
    softmaxLayer
    pixelClassificationLayer
];

% Stacking the layers.
net = [
    imgLayer    
    downsamplingLayers
    upsamplingLayers
    finalLayers
    ]

% Choosing thr training options
opts = trainingOptions('adam', ...
    'InitialLearnRate', 1e-3, ...
    'MaxEpochs', 10, ...
    'MiniBatchSize', 128, ...
    'Plots', 'training-progress');

%%
% Train the network
net = trainNetwork(augImds,net,opts);

%%
save('segmentationown.mat', 'net') %filename, variable
%can load with 'load segmentownnet.mat'
%%
addpath('C:\Users\nikhi\Desktop\MSc DS\6-Computer Vision\project\data_for_moodle\Codee');
load segmentationOwn.mat

%%
% Testing the flower segmentation on input images
addpath('C:\Users\nikhi\Desktop\MSc DS\6-Computer Vision\project\data_for_moodle\images_256');
testImage = imread('image_0001.jpg');  
C = semanticseg(testImage, net);
B = labeloverlay(testImage, C, 'Colormap', [0 1 0; 0 0 1], 'Transparency',0.4);
figure;
imshow(B);
title('Segmented Image');
%%
% Evaluating the method using Confusion matrix and Intersection over Union.
pxdsResults = semanticseg(imds,net);
metrics = evaluateSemanticSegmentation(pxdsResults,pxds)

figure
cm = confusionchart(metrics.ConfusionMatrix.Variables, ...
  classNames, Normalization='row-normalized');

cm.Title = 'Normalized Confusion Matrix (%)';

imageIoU = metrics.ImageMetrics.MeanIoU;
figure
histogram(imageIoU)
title('Image Mean IoU')
