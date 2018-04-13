function index = getActiveUnits(responses, silenceIndex)
%%
% Get the active units from the responses
%
% input:
%   responses: a m*n*k cell: the output of a layer in the SHMAX model
%   silenceIndex: an index vector that indicate which frame is the silence
%   frame, the length of silenceIndex must be equal to n
% output:
%   index: a boolean index with the length of k that indicate the active
%   units
%
% The active units whose responses to randomly selected time frames were 
% statistically larger than their response to silence (p<0.001)

index = zeros(1, size(responses, 3));

for i = 1:length(index)
    r = randperm(size(responses, 2));
    x = responses(:, r(1:length(silenceIndex)), i);
    y = responses(:, silenceIndex, i);
    index(i) = ttest(x(:), y(:), 1e-3);
end

index(isnan(index)) = 0;
end