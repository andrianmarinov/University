function som = lab_som (trainingData, neuronCount, trainingSteps, startLearningRate, startRadius)
% som = lab_som (trainingData, neuronCount, trainingSteps, startLearningRate, startRadius)
% -- Purpose: Trains a 1D SOM i.e. A SOM where the neurons are arranged
%             in a single line. 
%             
% -- <trainingData> data to train the SOM with
% -- <som> returns the neuron weights after training
% -- <neuronCount> number of neurons 
% -- <trainingSteps> number of training steps 
% -- <startLearningRate> initial learning rate
% -- <startRadius> initial radius used to specify the initial neighbourhood size

% TODO:
% The student will need to complete this function so that it returns
% a matrix 'som' containing the weights of the trained SOM.
% The weight matrix should be arranged as follows, where
% N is the number of features and M is the number of neurons:
%
% Neuron1_Weight1 Neuron1_Weight2 ... Neuron1_WeightN
% Neuron2_Weight1 Neuron2_Weight2 ... Neuron2_WeightN
% ...
% NeuronM_Weight1 NeuronM_Weight2 ... NeuronM_WeightN
%
% It is important that this format is maintained as it is what
% lab_vis(...) expects.
%
% Some points that you need to consider are:
%   - How should you randomise the weight matrix at the start?
%   - How do you decay both the learning rate and radius over time?
%   - How does updating the weights of a neuron effect those nearby?
%   - How do you calculate the distance of two neurons when they are
%     arranged on a single line?

% trainingData = data;
% neuronCount = 30;
% trainingSteps = 1500;
% startLearningRate = 0.1;
% startRadius = 15;


% Find the number of examples and features
[examples,dimensions] = size(trainingData);

% Initialize the intial weight vectors
som = rand(neuronCount,dimensions);
[neurons,~] = size(som);


% tau1 used to update the learning rate
tau1 = trainingSteps;
% tau2 used to update neighbourhood size
tau2 = trainingSteps / log(startRadius);
% i = 1;
lRate = startLearningRate;
nSize = startRadius;

% For every iteration pick a random example
% Find the weight closest to the example
% Update the neighbours of the best example to be similar to it
% Update learning rate and neighbourhood size
for iteration = 1 : trainingSteps    
%     if(i > examples)
%         i = 1;
%     end
    i = randi([1 examples],1);
    distance = dist(som,trainingData(i,:)');
    bestNode = find(distance == min(distance),1);

    % Find which indices to update
    indicesToUpdate = bestNode - round(nSize) : bestNode + round(nSize);
    indicesToUpdate(indicesToUpdate > neurons) = [];
    indicesToUpdate(indicesToUpdate <= 0) = [];

    for n = 1 : length(indicesToUpdate)  
        index = indicesToUpdate(n);
        nominator = abs(bestNode - index)^2;
        denominator = 2 * (nSize^2);
        nKernel = exp( -1 * ( nominator / denominator ) );
        som(index,:) = som(index,:) + lRate * nKernel * ( trainingData(i,:) - som(index,:) );
    end
    lRate = startLearningRate * exp( -1 * (iteration / tau1) );
    nSize = startRadius * exp ( -1 * ( iteration / tau2) );
%     i = (i + 1);
end
        
    
    
    




