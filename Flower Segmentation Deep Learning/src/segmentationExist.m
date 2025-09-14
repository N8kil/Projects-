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
%%
%shuffling the order of images.
augImds = shuffle(augImds);
%%
imageSize = [256 256 3];
numClasses = 2;

% Importing the U-Net architecture 
lgraph = unetLayers(imageSize, numClasses)

%%
% Choosing thr training options
    options = trainingOptions('adam', ...
    'InitialLearnRate', 1e-3, ...
    'MaxEpochs', 10, ...
    'MiniBatchSize', 64, ...
    'Plots', 'training-progress');

%%
net = trainNetwork(augImds,lgraph,options);
%%
save('segmentexistnet.mat', 'net')
%%
addpath('C:\Users\nikhi\Desktop\MSc DS\6-Computer Vision\project\data_for_moodle\Codee');
load segmentexistnet.mat
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







