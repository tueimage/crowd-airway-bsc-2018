[dataPath slicePath resultPath] = getPath;
load([resultPath 'subjects_status.mat'], 'subjectIDandStatus');
load([resultPath 'filterUsefulResults.mat'], 'filterGtTable', 'filterDataTable', 'filterAnnotTable');
numTasks=2380;

%% select subjects with or without CF
noCF=[];
yesCF=[];
for x=1:length(subjectIDandStatus)
    if subjectIDandStatus(x,2)==1
        noCF=[noCF; subjectIDandStatus(x,1)];
    elseif subjectIDandStatus(x,2)==2
        yesCF=[yesCF; subjectIDandStatus(x,1)];
    end
end

%% Select the tasks of patients with CF and tasks of patients without CF

% Hier gaat hij de mist in, want meerdere tasks/patient, maar hij pakt nu
% telkens maar een patient. 
% 
taskNoCF=[];
previouspatient=0;
for i=1:length(noCF)
    for j=1:numTasks
        if filterDataTable(j,4)== noCF(i) & previouspatient~=noCF(i)
            previouspatient=noCF(i);
            taskNoCF=[taskNoCF; filterDataTable(j,1)];
        end
    end
end

taskYesCF=[];
previouspatient=0;
for k=1:length(yesCF)
    for l=1:numTasks
        if filterDataTable(l,4)== yesCF(k) & previouspatient~=yesCF(k)
            previouspatient=yesCF(k);
            taskYesCF=[taskYesCF; filterDataTable(l,1)];
        end
    end
end

    