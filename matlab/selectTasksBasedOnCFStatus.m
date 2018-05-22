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
    