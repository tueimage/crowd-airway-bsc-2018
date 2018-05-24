
%% Define data paths and load data

[dataPath slicePath resultPath] = getPath;
load([resultPath 'annotationSummary_allSubjects.mat'], 'gtTable', 'dataTable', 'annotTable');
load([resultPath 'subjects_status.mat'], 'subjectIDandStatus');

%Adding some data to the tables
for i=1:length(dataTable)
    for j=1:length(subjectIDandStatus)  % adding subject status to the dataTable
        if subjectIDandStatus(j,1)==dataTable(i,4)
            dataTable(i,5)=subjectIDandStatus(j,2);
        end
    end
    %Adding Wall Area Percentage (WAP) to dataTable and gtTable
    %WAP=(wallarea/(wallarea+lumenarea))*100=((outerarea-innerarea)/outerarea)*100
    annotTable(i,3)= ((annotTable(i,2)-annotTable(i,1))/annotTable(i,2))*100;
    gtTable(i,5)= ((gtTable(i,2)-gtTable(i,1))/gtTable(i,2))*100; 
    gtTable(i,6)= ((gtTable(i,4)-gtTable(i,3))/gtTable(i,4))*100;
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
%filterGtTable = [areaInnerWieying, areaOuterWieying, areaInnerAdria, areaOuterAdria, WAPWieying, WAPAdria]; 
%filterAnnotTable = [min(area1,area2), max(area1,area2), WAP]; %or nan if only one or zero ellipses are drawn
