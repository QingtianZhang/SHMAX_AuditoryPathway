function X = sample3dImages(sampleSize, baseSize, dataDir)
    % INPUT variables:
    % sampleSize            total number of patches to take
    % patchSize             patch width in pixels
    %
    % OUTPUT variables:
    % X                  the patches as column vectors

    files = dir(fullfile(dataDir, 'y_*.mat') );
    n = min(length(files), 5000);
    samplePerImage = sampleSize / n;
    load(fullfile(dataDir, files(1).name), 'y');
    X = zeros(baseSize.^2 * size(y, 3), sampleSize);

    for i = 1:n
        load(fullfile(dataDir, files(i).name), 'y');
        xx = 1 + floor(rand(samplePerImage, 1) * (size(y, 1) - baseSize));
        yy = 1 + floor(rand(samplePerImage, 1) * (size(y, 2) - baseSize));
        for j = 1:samplePerImage
            X(:, (i-1)*samplePerImage+j) = reshape(y(xx:xx+baseSize-1, yy:yy+baseSize-1, :), [baseSize.^2 * size(y, 3), 1]);
        end
    end
end
