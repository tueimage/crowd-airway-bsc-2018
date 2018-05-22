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
taskNoCF=[];
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

taskYesCF=[];
previouspatientYes=0;

for n=1:length(filterDataTable)
    patientYesCF=[]; 
    for m=1:length(noCF)   
        if filterDataTable(n,4)== yesCF(m) && previouspatientYes ~=yesCF(m)
            previouspatientYes=yesCF(m);
            patientYesCF=[patientYesCF; filterDataTable(n,1)];
        end
    end
    taskYesCF=[taskYesCF; patientYesCF];
end


%% Select the tasks of patients with CF and tasks of patients without CF

% % Hier gaat hij de mist in, want meerdere tasks/patient, maar hij pakt nu
% % telkens maar een patient. 
% 
% taskNoCF=[];
% previouspatient=0;
% 
% for i=1:length(noCF)
%     patientNoCF=[]; 
%     for j=1:length(filterDataTable)       
%         if filterDataTable(j,4)== noCF(i) && noCF(i)~=previouspatient
%             previouspatient=noCF(i);
%             patientNoCF=[patientNoCF; filterDataTable(j,1)];
%         end
%     end
%     taskNoCF=[taskNoCF; patientNoCF];
% end
% 
% taskYesCF=[];
% previouspatient=0;
% for k=1:length(yesCF)
%     for l=1:length(filterDataTable)
%         if filterDataTable(l,4)== yesCF(k) && previouspatient~=yesCF(k)
%             previouspatient=yesCF(k);
%             taskYesCF=[taskYesCF; filterDataTable(l,1)];
%         end
%     end
% end
% 
% 

%% dit weer linken aan indexResultsTask
    