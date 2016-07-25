%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NLPCC2016 �������ɭ��,SVM,Kernel-SVM��AdaBoostM2������������ѡ��������ں�
% ΢���û�������� -- 2016/07/02
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;
warning off;
addpath(genpath([pwd '/']));
%% ������
topics = {'iphonese', 'bianpao', 'fankong', 'ertai', 'jinmo'};
features = {'Para2vec', 'LDA', 'LSA', 'LE', 'LPI', 'VSM_chi2_tf', 'VSM_chi2_tfidf', 'LSA_chi2', 'LE_chi2', 'LPI_chi2', 'opinion_fea'};
hasTestData = true;
parameters.cross_valid = 4;
parameters.hasLoadedData = 1; %��һ���ܲ�������ʱ���ǵ����¼������ݡ�
parameters.ensemble_models = {'RF', 'SVM', 'SVM_Kernel', 'Ensemble'};
% parameters.method = 'Ensemble'; % RF(Random Forest), SVM, SVM_Kernel, Ensemble
% parameters.eval_mode = 'leave_out'; % single, leave_out, all_fea, top_fea
% parameters.top_fea_k = 5;
% parameters.leave_out_depth = 4;
%%
parameters.ensemble_method = 'SVM';
for topic_i = 1:length(topics)
        rand('state',0)
        randn('state',0)    
        topic = topics{topic_i};
        disp (['Current topic is:', topic]);
        if strcmp(topic, 'iphonese')
            parameters.labeled_num = 600;
            parameters.unlabeled_num = 600;
            parameters.test_num = 3000;           
        elseif strcmp(topic, 'bianpao')         
            parameters.labeled_num = 600;
            parameters.unlabeled_num = 600;
            parameters.test_num = 3000;
        elseif strcmp(topic, 'fankong')      
            parameters.labeled_num = 600;
            parameters.unlabeled_num = 600;
            parameters.test_num = 3000;
        elseif strcmp(topic, 'ertai')       
            parameters.labeled_num = 600;
            parameters.unlabeled_num = 599;
            parameters.test_num = 3000;
        elseif strcmp(topic, 'jinmo')
            parameters.labeled_num = 586;
            parameters.unlabeled_num = 600;
            parameters.test_num = 3000;
        else
            disp(['Error, wrong topic: ', tpoic]);
        end
        [ensemble_ACC{topic_i}] = TaskA_Ensemble_models(topic, features, parameters, hasTestData);        
end

