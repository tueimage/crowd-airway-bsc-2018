
%% Define data paths and load data

[dataPath slicePath resultPath] = getPath;
load([resultPath 'annotationSummary_allSubjects.mat'], 'gtTable', 'dataTable', 'annotTable');
load([resultPath 'subjects_status.mat'], 'subjectIDandStatus');

%Adding subject status to the dataTable
for i=1:length(dataTable)
    for j=1:length(subjectIDandStatus)
        if subjectIDandStatus(j,1)==dataTable(i,4)
            dataTable(i,5)=subjectIDandStatus(j,2);
        end
    end
end

%% Filter data to keep all succesfull performed annotation results
% Just the data that of an annotation result that contains two annotations
% which are defined as correct by the 'classifyAnnotation.m' are being kept. 

filterDataTable=[];
filterAnnotTable=[]; 
filterGtTable=[];

for i=1:length(dataTable)
    if dataTable(i,2)==2 && dataTable(i,3)==1
        filterDataTable=[filterDataTable; dataTable(i,:)];
        filterAnnotTable=[filterAnnotTable; annotTable(i,:)];
        filterGtTable=[filterGtTable; gtTable(i,:)];
    end
end

save([resultPath 'filterUsefulResults.mat'], 'filterGtTable', 'filterDataTable', 'filterAnnotTable');
%Columns:
%filterDataTable = [i numAnnot useAnnotation subjectID status];
%filterGtTable = [areaInnerWieying, areaOuterWieying, areaInnerAdria, areaOuterAdria]; 
%filterAnnotTable = [min(area1,area2), max(area1,area2)]; %or nan if only one or zero ellipses are drawn
