[dataPath slicePath resultPath] = getPath;
load([resultPath 'subjects_status.mat'], 'subjectIDandStatus');
load([resultPath 'filterUsefulResults.mat'], 'filterGtTable', 'filterDataTable', 'filterAnnotTable');

%% VC trying to find the task IDs of subjects belonging to CF or not

%How many tasks in total
uniqueTaskNumbers = unique(filterDataTable(:,1));
numTasks = length(uniqueTaskNumbers);

%Which subjects have CF or not
subjectsNoCF = subjectIDandStatus(find(subjectIDandStatus(:,2) == 1),1);
subjectsYesCF = subjectIDandStatus(find(subjectIDandStatus(:,2) == 2),1);

%Which tasks have subject IDs, that belong to subjects without CF
indexTaskNoCF = find(ismember(filterDataTable(:,4), subjectsNoCF));
taskIDNoCF = unique(filterDataTable(indexTaskNoCF,1))

%Which tasks have subject IDs, that belong to subjects with CF
indexTaskYesCF = find(ismember(filterDataTable(:,4), subjectsYesCF));
taskIDYesCF = unique(filterDataTable(indexTaskYesCF,1))


%Sanity check
assert(numTasks == length(taskIDYesCF) + length(taskIDNoCF), "Numbers of tasks do not add up"); %If you do not see this error message then things are fine

%%
save([resultPath 'subjectsCF.mat'], 'subjectsYesCF', 'subjectsNoCF');
save([resultPath 'tasksSplitOnCFStatus.mat'], 'taskIDYesCF', 'taskIDNoCF');

%% Creating a cell which contains, subject, status and a list of the tasks belonging to that subject

subjectIDandStatusandTask={};
for i=1:length(subjectIDandStatus)
    indexTaskNoCF = find(ismember(filterDataTable(:,4), subjectIDandStatus(i,1)));
    taskIDNoCF = unique(filterDataTable(indexTaskNoCF,1));
    subjectIDandStatusandTask{i,1}=subjectIDandStatus(i,1);
    subjectIDandStatusandTask{i,2}=subjectIDandStatus(i,2);
    subjectIDandStatusandTask{i,3}=taskIDNoCF;
end
%%
save([resultPath 'subjectIDandStatusandTask.mat'], 'subjectIDandStatusandTask');