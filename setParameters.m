% set directory
dataDir = 'cochleogram';

% parameters of layers
param.sS =  [0,    0,     0,     0,     0,     0];      % skip S layers
param.sC =  [0,    0,     0,     0,     0,     0];      % skip C layers
param.sT =  [0,    0,     0,     0,     0,     0];      % skip Training
param.sI =  [0,    0,     0,     0,     0,     0];      % skip Inference
param.sP =  [0,    0,     0,     0,     0,     0];      % skip Pooling

param.Bn =  [1e2,  2e2,   4e2,   5e2,   5e2,   5e2];    % Bases number
param.Bs =  [10,   10,    10,    10,    10,    10];     % Bases size

param.Sn =  [1e4,  2e4,   4e4,   5e4,   5e4,   5e4];	% Samples number

param.s1 =  [2,    2,     1,     1,     1,     1];      % S layers stride
param.s2 =  [1,    1,     1,     1,     1,     1];      % C layers stridd

param.Pr =  [2,    2,     2,     2,     2,     2];      % Pooling ratio
% parameters of sparse coding algorithm
param.SC = struct('K', num2cell(param.Bn), 'lambda', 1e0, 'iter', 5e3, 'mode', 1);

