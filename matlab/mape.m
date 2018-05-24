%% Load data
[dataPath slicePath resultPath] = getPath;
load([resultPath 'subjectIDandStatusandTask.mat'], 'subjectIDandStatusandTask');
load([resultPath 'filterUsefulResults.mat'], 'filterGtTable', 'filterDataTable', 'filterAnnotTable');
load([resultPath 'subjectsCF.mat'], 'subjectsYesCF', 'subjectsNoCF');

%% Mean absolute percentage error of each subject

%define the type of list with subject numbers 
Type=subjectsYesCF;

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
