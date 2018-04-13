function base = SHMAX_3dS(skipTraining, skipInference, nBase, baseSize, sampleSize, stride, paramSC, dataDir, resultDir)
% SHMAX: S layer, 3d data
    % Learn bases
    fprintf('Learning bases...\n');
    tic;
    if skipTraining
        load([resultDir, filesep, 'base_', num2str(nBase), '_', num2str(sampleSize), '_', num2str(baseSize), '.mat'], 'base');
    else
        sample = sample3dImages(sampleSize, baseSize, dataDir);
        base = mexTrainDL(sample, paramSC);
        if ~exist(resultDir, 'dir')
            mkdir(resultDir);
        end
        save([resultDir, filesep, 'base_', num2str(nBase), '_', num2str(sampleSize), '_', num2str(baseSize), '.mat'], 'base');
    end
    toc;

    % Inference++++++++
    fprintf('Calculating responses...\n');
    tic;
    if ~skipInference
        files = dir([dataDir, filesep, 'y_*.mat']);
        for i = 1:length(files)
            y = 0;
            load(fullfile(dataDir, files(i).name), 'y');
            
%             for j = 1:size(y, 3)
%                 Y((j-1)*baseSize.^2+1 : j*baseSize.^2, :) = im2col(y(:, :, j), [baseSize, baseSize]);
%             end
%             ww = mexLasso(Y, base, paramSC);
%             w = zeros([[size(y, 1), size(y, 2)] - baseSize + 1, nBase]);
%             for j = 1:nBase
%                 w(:, :, j) = col2im(full(ww(j, :)), [baseSize, baseSize], [size(y, 1), size(y, 2)], 'sliding');
%             end
            
            w = zeros([size(y, 1) - baseSize + 1, size(y, 2) - baseSize + 1, nBase]);
            for j = 1:nBase
                w(:, :, j) = convn(y, reshape(base(:, j), baseSize, baseSize, size(y, 3)), 'valid');
            end
            
            w = w(1:stride:end, 1:stride:end, :);
            save([resultDir, filesep, 'w_', num2str(i), '.mat'], 'w');
        end
    end
    toc;
end