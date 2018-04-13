function S = getLifeSparse(responses)
%%
% Get the lifetime sparseness of each unit
%
% input:
%   responses: a m*n*k cell: the output of a layer in the SHMAX model
% output:
%   S: the lifetime sparseness of each units according to the formula:
%   S = 1 - (E(r))^2 / E(r^2)

S = zeros(1, size(responses, 3));
for i = 1:length(S)
    r = responses(:, :, i);
    r = r(:);
    S(i) = 1 - ( (mean(r).^2) / (mean(r.^2)) );
end