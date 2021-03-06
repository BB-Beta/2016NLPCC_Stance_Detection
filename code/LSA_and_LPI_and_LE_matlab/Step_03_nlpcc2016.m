function Step_03_nlpcc2016(method, topic, parameters, hasTestData)

dataStr = ['./../../data/RefineData/Step02_vsm/vsm_train_labeled_',topic];
load(dataStr);
evalStr = ['fea = vsm_train_labeled_',topic,';'];
eval(evalStr)
dataStr = ['./../../data/RefineData/Step02_vsm/vsm_train_unlabeled_',topic];
load(dataStr);
evalStr = ['fea = [fea;vsm_train_unlabeled_',topic,'];'];
eval(evalStr)
if hasTestData
    dataStr = ['./../../data/RefineData/Step02_vsm/vsm_test_unlabeled_',topic];
    load(dataStr);
    evalStr = ['fea = [fea;vsm_test_unlabeled_',topic,'];'];
    eval(evalStr)
end

nLowVec = parameters.nLowVec;
%% init parameters
options = [];
options.NeighborMode = 'KNN';
options.Metric = 'Euclidean';
options.WeightMode = 'HeatKernel';
options.t = 1;
options.bSelfConnected = 0;
options.k = 15;

%%
if (strcmp(method,'LSA'))
    disp('Here is baseline method: LSA!');
    fea=tf_idf(fea);
    fea = normalize(fea);
    disp(['nLowVec is:',num2str(nLowVec)]);
    Y = LSA(fea,nLowVec);
    resultStr = ['./../../data/RefineData/Step03_lsa_lpi_le/fea_lsa_',topic];
    save(resultStr, 'Y', '-ascii');
    disp('LSA feature is ok!');    
    
elseif (strcmp(method,'Spectral_LE'))
    disp('Here is baseline method: Spectral_LE!');
    fea=tf_idf(fea);
    fea = normalize(fea);
    disp(['nLowVec is:',num2str(nLowVec)]);    
    Y = LapEig(fea,options,nLowVec);
    resultStr = ['./../../data/RefineData/Step03_lsa_lpi_le/fea_le_',topic];
    save(resultStr, 'Y', '-ascii');    
    disp('LE feature is ok!');  
    
elseif (strcmp(method,'LPI'))
    disp('Here is baseline method: LPI!');
    fea=tf_idf(fea);
    fea = normalize(fea);
    W = constructW(fea,options);
    options.PCARatio = 1;
    options.ReducedDim=nLowVec;
    [eigvector, ~] = lpp(W, options, fea);
    disp(['nLowVec is:',num2str(nLowVec)]);
    Y = fea*eigvector;
    resultStr = ['./../../data/RefineData/Step03_lsa_lpi_le/fea_lpi_',topic];
    save(resultStr, 'Y', '-ascii');
    disp('LPI feature is ok!');      

else
    error(['You input a invalid method:',method,'!'])
end