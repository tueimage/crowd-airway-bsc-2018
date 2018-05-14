
%%Correlatie buiten en binnen
[dataPath slicePath resultPath] = getPath;
load([resultPath 'annotationSummary_allSubjectsFilter.mat'], 'filterGtTable', 'filterDataTable', 'filterAnnotTable');
numTasks=2380;

AllResults=0; %If set to one, all results will be shown in the scatterplot
Tasks=[1555,2128,378, 387,433,568,640, 275, 1665]; %Choose specific numbers of tasks to analyse

if AllResults==1; 
    Tasks=[1:numTasks];
end

Group=[];
InnerArea=[];
OuterArea=[];
for k=1:length(Tasks)
    Task=Tasks(k);
    AnnTask=[];
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

end

figure; gscatter(InnerArea, OuterArea,Group)
axis([0 100 0 100]);
xlabel('Inner area in mm^2'); 
ylabel('Outer area in mm^2'); 
title('All annotations of the specified tasks');
