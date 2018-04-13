%% Set parameters
setParameters;

%% Layer 1
fprintf('\n\n***  S1 layer  ***...\n');
if ~param.sS(1)
%     tic;
    SHMAX_2dS(param.sT(1), param.sI(1), param.Bn(1), param.Bs(1), param.Sn(1), param.s1(1), param.SC(1), dataDir, 'S1Result');
%     toc;
end

fprintf('\n***  C1 layer  ***...\n');
if ~param.sC(1)
    tic;
    SHMAX_C(param.sP(1), param.Pr(1), param.s2(1), 'S1Result', 'C1Result');
    toc;
end

 %% Layer 2-6
 for i = 2:6
    fprintf(['\n\n***  S', num2str(i), ' layer  ***...\n']);
    if ~param.sS(i)
%         tic;
        SHMAX_3dS(param.sT(i), param.sI(i), param.Bn(i), param.Bs(i), param.Sn(i), param.s1(i), param.SC(i), ['C', num2str(i-1), 'Result'], ['S', num2str(i), 'Result']);
%         toc;
    end
    fprintf(['\n***  C', num2str(i), ' layer  ***...\n']);
    if ~param.sC(i)
        tic;
        SHMAX_C(param.sP(i), param.Pr(i), param.s2(i), ['S', num2str(i), 'Result'], ['C', num2str(i), 'Result']);
        toc;
    end
 end
 
 clear i;
