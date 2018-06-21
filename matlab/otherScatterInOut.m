%% Correlation of inner area vs. outer area 
% This script creates an inner-vs-outer area plot in which specific tasks will
% be shown. The annotations belonging to the same image slice are shown in
% the same color. 

[dataPath slicePath resultPath] = getPath;
load([resultPath 'annotationSummary_allSubjectsFilter.mat'], 'filterGtTable', 'filterDataTable', 'filterAnnotTable');
load([resultPath 'tasksSplitOnCFStatus.mat'], 'taskIDYesCF', 'taskIDNoCF');
numTasks=2380;

AllResults=0; %If set to one, all results will be shown in the scatterplot
Tasks=taskIDNoCF; %Choose specific numbers of tasks to analyse

if AllResults==1; 
    Tasks=[1:numTasks];
end

Group=[];
InnerArea=[];
OuterArea=[];
for k=1:length(Tasks)
    Task=Tasks(k); %specific task number
    AnnTask=[]; %annotations of that specific task
    for i=1:length(filterDataTable)
        if filterDataTable(i,1)==Task
            AnnTask=[AnnTask; i];
        end
    end
    
    
    KWInnerArea=filterAnnotTable(AnnTask,1);
    KWOuterArea=filterAnnotTable(AnnTask,2);
    Type=filterDataTable(AnnTask,1);
    
    InnerArea=[InnerArea;KWInnerArea];
    OuterArea=[OuterArea;KWOuterArea];
    Group=[Group;Type];
    keyboard
end

figure; gscatter(InnerArea, OuterArea,Group)
axis([0 100 0 100]);
xlabel('Inner area in mm^2'); 
ylabel('Outer area in mm^2'); 
title('All annotations of the specified tasks');
