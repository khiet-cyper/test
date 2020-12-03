cd D:\A_MY_SUBJECT\project\prethesis\data;
load('yseg.mat');
load('TrainFea.mat');
y=double(yseg);
y=y';
C = 0.1;
model = svmTrain(TrainFea(1:22000,:), y(1:22000,:), C, @linearKernel);

p = svmPredict(model, TrainFea);

fprintf('Test Accuracy: %f\n', mean(double(p == y) * 100));