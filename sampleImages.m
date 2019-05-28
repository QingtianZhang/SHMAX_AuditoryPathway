function X = sampleImages(sampleSize, baseSize, dataDir)
    % INPUT variables:
    % sampleSize            total number of patches to take
    % patchSize             patch width in pixels
    %
    % OUTPUT variables:
    % X                  the patches as column vectors

    files = dir(fullfile(dataDir, 'x_*.mat') );
    n = min(length(files), 5000);
    samplePerImage = sampleSize / n;
    X = zeros(baseSize.^2, sampleSize);

    for i = 1:n
        load(fullfile(dataDir, files(i).name), 'x');
        xx = floor(rand(samplePerImage, 1) * (size(x, 1) - baseSize));
        yy = floor(rand(samplePerImage, 1) * (size(x, 2) - baseSize));
        for j = 1:samplePerImage
            X(:, (i-1)*samplePerImage+j) = reshape(x(xx(j):xx(j)+baseSize-1, yy(j):yy(j)+baseSize-1), [baseSize.^2, 1]);
        end
    end
end
