function [som,grid] = lab_som2d (trainingData, neuronCountW, neuronCountH, trainingSteps, startLearningRate, startRadius)
% som = lab_som2d (trainingData, neuronCountW, neuronCountH, trainingSteps, startLearningRate, startRadius)
% -- Purpose: Trains a 2D SOM, which consists of a grid of
%             (neuronCountH * neuronCountW) neurons.
%             
% -- <trainingData> data to train the SOM with
% -- <som> returns the neuron weights after training
% -- <grid> returns the location of the neurons in the grid
% -- <neuronCountW> number of neurons along width
% -- <neuronCountH> number of neurons along height
% -- <trainingSteps> number of training steps 
% -- <startLearningRate> initial learning rate
% -- <startRadius> initial radius used to specify the initial neighbourhood size
%

% TODO:
% The student will need to copy their code from lab_som() and
% update it so that it uses a 2D grid of neurons, rather than a 
% 1D line of neurons.
% 
% Your function will still return the a weight matrix 'som' with
% the same format as described in lab_som().
%
% However, it will additionally return a vector 'grid' that will
% state where each neuron is located in the 2D SOM grid. 
% 
% grid(n, :) contains the grid location of neuron 'n'
%
% For example, if grid = [[1,1];[1,2];[2,1];[2,2]] then:
% 
%   - som(1,:) are the weights for the neuron at position x=1,y=1 in the grid
%   - som(2,:) are the weights for the neuron at position x=2,y=1 in the grid
%   - som(3,:) are the weights for the neuron at position x=1,y=2 in the grid 
%   - som(4,:) are the weights for the neuron at position x=2,y=2 in the grid
%
% It is important to return the grid in the correct format so that
% lab_vis2d() can render the SOM correctly

[examples,dimensions] = size(trainingData);
%Ind2sub comand
neuronCount = neuronCountW*neuronCountH;
[grid(:,1),grid(:,2)] = ind2sub([neuronCountW,neuronCountH],1:neuronCount);

som = rand(neuronCount,dimensions);

tau1 = trainingSteps;
tau2 = trainingSteps / log(startRadius);
% i = 1;
lRate = startLearningRate;
nSize = startRadius;
for iteration = 1 : trainingSteps    
%     if(i > examples)
%         i = 1;
%     end
    i = randi([1 examples],1);
    distance = dist(som,trainingData(i,:)');
    bestNode = find(distance == min(distance),1);
    [gridIndex(:,1),gridIndex(:,2)] = ind2sub([neuronCountW,neuronCountH],bestNode);
    % Revert
    [indicesToUpdate,D] = rangesearch(grid,gridIndex,round(nSize));
    indicesToUpdate = indicesToUpdate{1};
    D = ceil(D{1});
    
    for n = 1 : length(indicesToUpdate)  
        index = indicesToUpdate(n);
        nominator = D(n)^2;
        denominator = 2 * (nSize^2);
        nKernel = exp( -1 * ( nominator / denominator ) );
        som(index,:) = som(index,:) + lRate * nKernel * ( trainingData(i,:) - som(index,:) );
    end
    lRate = startLearningRate * exp( -1 * (iteration / tau1) );
    nSize = startRadius * exp ( -1 * ( iteration / tau2) );
%     i = (i + 1);
end
        

