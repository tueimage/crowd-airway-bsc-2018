%% Load data
[dataPath slicePath resultPath] = getPath;
load([resultPath 'subjectIDandStatusandTask.mat'], 'subjectIDandStatusandTask');
load([resultPath 'filterUsefulResults.mat'], 'filterGtTable', 'filterDataTable', 'filterAnnotTable');
load([resultPath 'subjectsCF.mat'], 'subjectsYesCF', 'subjectsNoCF');

%% Mean absolute percentage error of each subject

%define the type of list with subject numbers 
Type=subjectsNoCF;

%list that will contain the subject number with corresponding MAPE
subjectIDandMAPE=zeros(length(Type),2);
for i=1:length(Type)
    subjectID=Type(i);
    indexSubject=find(cell2mat(subjectIDandStatusandTask(:,1)) == subjectID);
    tasksSubject=cell2mat(subjectIDandStatusandTask(indexSubject,3));
    indexTable=find(ismember(filterDataTable(:,1),tasksSubject));
    
    pred=filterAnnotTable(indexTable,1); %inner area predicted by the KW
    act=filterGtTable(indexTable,1); %inner area Wieying
    
    %Mean absolute percentage error
    MAPE=mean((abs(act-pred))./(abs(act)))*100;
    
    subjectIDandMAPE(i,1)=subjectID;
    subjectIDandMAPE(i,2)=MAPE;
end

%% MAPE visualized by box per subject, which shows the deviation of the MAPE of each task
%list that will contain the subject number with corresponding MAPE
MAPEperTaskEachSubject=[];
for n=1:length(subjectIDandStatusandTask)
    subjectID=cell2mat(subjectIDandStatusandTask(n,1))
    
    indexSubject=find(cell2mat(subjectIDandStatusandTask(:,1)) == subjectID);
    tasksSubject=cell2mat(subjectIDandStatusandTask(indexSubject,3));
    subjectTasksandMAPE=zeros(length(tasksSubject),2);
    
    for i=1:length(tasksSubject)
        indexTable=find(ismember(filterDataTable(:,1),tasksSubject(i)));
        pred=filterAnnotTable(indexTable,2); %inner area predicted by the KW
        act=filterGtTable(indexTable,2); %inner area Wieying
        
        %Mean absolute percentage error
        MAPE=mean((abs(act-pred))./(abs(act)))*100;
        
        subjectTasksandMAPE(i,1)=subjectID;
        subjectTasksandMAPE(i,2)=MAPE;
        subjectTasksandMAPE(i,3)=tasksSubject(i);
    end
    MAPEperTaskEachSubject=[MAPEperTaskEachSubject;subjectTasksandMAPE];
end

 figure; boxplot(MAPEperTaskEachSubject(:,2), MAPEperTaskEachSubject(:,1))
 