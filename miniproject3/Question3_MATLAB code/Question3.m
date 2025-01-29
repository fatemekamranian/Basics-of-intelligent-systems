clc;
clear;
close all;

%% Load Dataset
data = load('ballbeam.dat'); 

angle = data(:, 1);    
position = data(:, 2);

inputs = angle;  
outputs = position;

% number of samples
num_samples = length(inputs);

% train test split
train_size = 4*num_samples/5;  
test_size = num_samples/5;   

x_train = inputs(1:train_size);  
y_train = outputs(1:train_size); 

x_test = inputs(train_size+1:end);  
y_test = outputs(train_size+1:end); 

train_data = [x_train y_train];
test_data = [x_test y_test];

%% Design ANFIS
nMFs = 5;
InputMF = 'gaussmf';
OutputMF = 'linear';

fis = genfis1(train_data, nMFs, InputMF, OutputMF);

Epochs = 10;
ErrorGoal = 0.01;
InitialStepSize = 0.01;
StepSizeDecreaseRate = 0.9;
StepSizeIncreaseRate = 1.1; 
TrainOptions = [Epochs ...
                ErrorGoal ...
                InitialStepSize ... 
                StepSizeDecreaseRate ...
                StepSizeIncreaseRate];

fis = anfis(train_data, fis, TrainOptions);

%% Apply ANFIS to Train Data 
train_output = evalfis(x_train, fis);
%train_errors = y_train - train_output; 
%train_mse = mean(train_errors(:).^2);
%train_rmse = sqrt(train_mse);
%train_error_mean = mean(train_error);
%train_error_std = std(train_errors);

figure; 
PlotResult(y_train, train_output, 'Train Data');

%% Test Data
test_output = evalfis(x_test, fis);

figure; 
PlotResult(y_test, test_output, 'Test Data');
