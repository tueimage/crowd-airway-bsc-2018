[dataPath slicePath resultPath] = getPath;
load([resultPath 'subjects_status.mat'], 'subjectIDandStatus');
load([resultPath 'filterUsefulResults.mat'], 'filterGtTable', 'filterDataTable', 'filterAnnotTable');
numTasks=2380; 

%% VC trying to find the task IDs of subjects belonging to CF or not
load([resultPath 'annotationSummary_allSubjects.mat'], 'gtTable', 'dataTable', 'annotTable', 'gtTablePerTask');

%How many tasks in total
uniqueTaskNumbers = unique(dataTable(:,1));
numTasks = length(uniqueTaskNumbers);

%Which subjects have CF or not
subjectsNoCF = subjectIDandStatus(find(subjectIDandStatus(:,2) == 1),1);
subjectsYesCF = subjectIDandStatus(find(subjectIDandStatus(:,2) == 2),1);

%Which tasks have subject IDs, that belong to subjects without CF
indexTaskNoCF = find(ismember(dataTable(:,4), subjectsNoCF));
taskIDNoCF = unique(dataTable(indexTaskNoCF,1))

%Which tasks have subject IDs, that belong to subjects with CF
indexTaskYesCF = find(ismember(dataTable(:,4), subjectsYesCF));
taskIDYesCF = unique(dataTable(indexTaskYesCF,1))


%Sanity check
assert(numTasks == length(taskIDYesCF) + length(taskIDNoCF), "Numbers of tasks do not add up"); %If you do not see this error message then things are fine


%% select subjects with or without CF
noCF=[];
yesCF=[];
for x=1:length(subjectIDandStatus)
    if subjectIDandStatus(x,2)==1
        noCF=[noCF; subjectIDandStatus(x,1)];
    elseif subjectIDandStatus(x,2)==2
        yesCF=[yesCF; subjectIDandStatus(x,1)];
    else
        error('This should not happen');
    end
end

%% Select the tasks of patients with CF and tasks of patients without CF
%Het totaal van taskNoCF en taskYesCF zou op 2380 moeten uitkomen.

taskNoCF=[]; % The task numbers of patients without CF 
previouspatientNo=0;

for i=1:length(filterDataTable)
    patientNoCF=[]; 
    for j=1:length(noCF)   
        if filterDataTable(i,4)== noCF(j) && previouspatientNo ~=noCF(j)
            previouspatientNo=noCF(j);
            patientNoCF=[patientNoCF; filterDataTable(i,1)];
        end
    end
    taskNoCF=[taskNoCF; patientNoCF];
end

taskYesCF=[]; %The task numbers of patients with CF
previouspatientYes=0;

for n=1:length(filterDataTable)
    patientYesCF=[]; 
    for m=1:length(yesCF)   
        if filterDataTable(n,4)== yesCF(m) && previouspatientYes ~=yesCF(m)
            previouspatientYes=yesCF(m);
            patientYesCF=[patientYesCF; filterDataTable(n,1)];
        end
    end
    taskYesCF=[taskYesCF; patientYesCF];
end



%% dit weer linken aan indexResultsTask
    