function base = SHMAX_2dS(skipTraining, skipInference, nBase, baseSize, sampleSize, stride, paramSC, dataDir, resultDir)
% SHMAX: S layer, 2d data
    % Learn bases
    fprintf('Learning bases...\n');
    tic;
    if skipTraining
        load([resultDir, filesep, 'base_', num2str(nBase), '_', num2str(sampleSize), '_', num2str(baseSize), '.mat'], 'base');
    else
        sample = sampleImages(sampleSize, baseSize, dataDir);
        base = mexTrainDL(sample, paramSC);
        if ~exist(resultDir, 'dir')
            mkdir(resultDir);
        end
        save([resultDir, filesep, 'base_', num2str(nBase), '_', num2str(sampleSize), '_', num2str(baseSize), '.mat'], 'base');
    end
    toc;

    % Inference
    fprintf('Calculating responses...\n');
    tic;
    if ~skipInference
        files = dir([dataDir, filesep, 'x_*.mat']);
        for i = 1:length(files)
            load(fullfile(dataDir, files(i).name), 'x');
%             X = im2col(x, [baseSize, baseSize]);
%             ww = mexLasso(X, base, paramSC);            
%             w = zeros([size(x) - baseSize + 1, nBase]);
%             for j = 1:nBase
%                 w(:, :, j) = col2im(full(ww(j, :)), [baseSize, baseSize], size(x), 'sliding');
%             end
            
            w = zeros([size(x) - baseSize + 1, nBase]);
            for j = 1:nBase
                w(:, :, j) = conv2(x, reshape(base(:, j), baseSize, baseSize), 'valid');
            end
            
            w = w(1:stride:end, 1:stride:end, :);
            save([resultDir, filesep, 'w_', num2str(i), '.mat'], 'w');
        end
    end
    toc;
end