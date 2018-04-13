function [T, Dura, F, Band] = getSTRFFeatures(strf)
%%
% Get four features from the STRF: 
% Best Time, Duration, Center Frequency, Bandwith
% 1. Do the SVD on the STRF.
% 2. Get the two unitary vectors corresponding to the first singular value.
% 3. Get the peak and bandwidth with 90% power.
%
% input:
%   strf: a m*m matrix: The strf of a units
% output:
%   T: the best temporal modulation frequency
%   Dura: the response duration
%   F: the center frequency
%   Band: the spectral bandwith

s = size(strf, 1);
[u, ~, v] = svd(strf);

[T, ind] = max(u(1, :));
Dura = 0;
while norm(u(1, max(1, ind-Dura):min(ind+Dura, s))) < 0.9 * norm(u(1, :))
    Dura = Dura + 1;
end
Dura = Dura * 2;

[F, ind] = max(v(:, 1));
Band = 0;
while norm(v(1, max(1, ind-Band):min(ind+Band, s))) < 0.9 * norm(v(1, :))
    Band = Band + 1;
end
Band = Band * 2;

end