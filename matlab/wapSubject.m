%% Load data
[dataPath slicePath resultPath] = getPath;
load([resultPath 'indexResultsTask.mat'], 'indexResultsTask'); %contains all annotation data per task
load([resultPath 'subjectIDandStatusandTask.mat'], 'subjectIDandStatusandTask'); %contains all tasks and status per subject
load([resultPath 'filterUsefulResults.mat'], 'filterGtTable', 'filterDataTable', 'filterAnnotTable');
load([resultPath 'subjectsCF.mat'], 'subjectsYesCF', 'subjectsNoCF');
%% Adding wall area percentage (WAP) of the experts to groundtruth table per task
load([resultPath 'annotationSummary_allSubjects.mat'], 'gtTablePerTask');

for i=1:length(gtTablePerTask)
    gtTablePerTask(i,5)=((gtTablePerTask(i,2)-gtTablePerTask(i,1))/gtTablePerTask(i,2))*100; %WAP by Wieying
    gtTablePerTask(i,6)=((gtTablePerTask(i,4)-gtTablePerTask(i,3))/gtTablePerTask(i,4))*100; %WAP by Adria
end
save([resultPath 'gtTablePerTask.mat'], 'gtTablePerTask');

%% SubjectsNoCF
whichTypeofSubject= subjectsNoCF; 
indexSubject=[];
wapKWNo=[];
wapExpertNo=[];
for i=1:length(subjectIDandStatusandTask)
    if ismember(cell2mat(subjectIDandStatusandTask(i,1)),whichTypeofSubject)
        indexSubject=[indexSubject; i];
    end
end
for j=1:length(indexSubject)
    index=indexSubject(j)
    tasksOfSubject= cell2mat(subjectIDandStatusandTask(index,3));
    WAPPerTaskKW=[];
    WAPPerTaskExpert=[];      
    for i=1:length(tasksOfSubject)
        task=tasksOfSubject(i);
        WAPPerTaskKW=[WAPPerTaskKW; mean(cell2mat(indexResultsTask(task,4)))]; %the mean value of all annotated WAPs is used as WAP value for a task
        WAPPerTaskExpert=[WAPPerTaskExpert; gtTablePerTask(task,5)]; %only the WAP value of Wieying is used
    end
    % Average WAP of one subject determined by the KW's and the expert (Wieying)
    subjectWAPKW=mean(WAPPerTaskKW);
    subjectWAPExpert=mean(WAPPerTaskExpert);
    wapKWNo=[wapKWNo;subjectWAPKW];
    wapExpertNo=[wapExpertNo; subjectWAPExpert];
end
%%
whichTypeofSubject= subjectsYesCF; 
indexSubject=[];
wapKWYes=[];
wapExpertYes=[];
for i=1:length(subjectIDandStatusandTask)
    if ismember(cell2mat(subjectIDandStatusandTask(i,1)),whichTypeofSubject)
        indexSubject=[indexSubject; i];
    end
end
for j=1:length(indexSubject)
    index=indexSubject(j)
    tasksOfSubject= cell2mat(subjectIDandStatusandTask(index,3))
    WAPPerTaskKW=[];
    WAPPerTaskExpert=[];
    for i=1:length(tasksOfSubject)
        task=tasksOfSubject(i);
        WAPPerTaskKW=[WAPPerTaskKW; mean(cell2mat(indexResultsTask(task,4)))]; %the mean value of all annotated WAPs is used as WAP value for a task
        WAPPerTaskExpert=[WAPPerTaskExpert; gtTablePerTask(task,5)]; %only the WAP value of Wieying is used
    end
    % Average WAP of one subject determined by the KW's and the expert (Wieying)
    subjectWAPKW=mean(WAPPerTaskKW);
    subjectWAPExpert=mean(WAPPerTaskExpert);
    wapKWYes=[wapKWYes;subjectWAPKW];
    wapExpertYes=[wapExpertYes; subjectWAPExpert];
end
%% Boxplot
figure; boxplot([wapKWNo, wapExpertNo, wapKWYes, wapExpertYes], {'Healthy KW', 'Healthy Expert', 'CF KW', 'CF Expert'})
ylabel('Wall Area Percentage [%]')

%% Wilcoxon rank sum test / Mann-Whitney U-test
[p,h]=ranksum(wapExpertNo, wapExpertYes)
[p,h]=ranksum(wapKWNo, wapKWYes)

%% Anova
expert=[wapExpertNo wapExpertYes]
kw=[wapKWNo wapKWYes]
p=anova1(expert)
p=anova1(kw)