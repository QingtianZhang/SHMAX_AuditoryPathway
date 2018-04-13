function SHMAX_C(skipPooling, poolSize, stride, dataDir, resultDir)
% SHMAX: C layer, 2d data
    fprintf('Calculating responses...\n');
    if ~skipPooling
        files = dir([dataDir, filesep, 'w_*.mat']);
        for i = 1:length(files)
            w = 0;
            load(fullfile(dataDir, files(i).name), 'w');
            y = zeros(size(w) - [1, 1, 0]);
            for j = 1:size(w, 3)
                y(:, :, j) = col2im(max(im2col(w(:, :, j), [poolSize, poolSize]), [], 1), [poolSize, poolSize], size(w(:, :, j)), 'sliding');
            end
            y = y(1:stride:end, 1:stride:end, :);
            if ~exist(resultDir, 'dir')
                mkdir(resultDir);
            end
            save([resultDir, filesep, 'y_', num2str(i), '.mat'], 'y');
        end
    end
end