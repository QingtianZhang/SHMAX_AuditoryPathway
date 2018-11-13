function PSI = getPSI(responses)
%%
% Get the PSIs of the id layer
% Steps:
% For each units:
% 1. Estimate the distribution of responses of each phoneme.
% 2. Do the Wilcox rand-sum test of a phoneme pair.
% 3. Sum the ranksum results
%
% input:
%   responses: a m*n cell: the distribution of the responses to every
%   phoneme of every units
% output:
%   PSI: the PSI matrix with size (m, n)

% m is the number of phonemes
% n is the number of units
[m, n] = size(responses);

PSI = zeros(m, n);
for i = 1:m
    for j = 1:n
        for k = [1:i-1, i+1:m]
            [~, H] = ranksum(responses{i, j}, responses{k, j}, 'alpha', 0.1, 'tail', 'right');
            PSI(i, j) = PSI(i, j) + H;
        end
    end
end
