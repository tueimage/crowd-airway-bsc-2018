
%%Correlatie buiten en binnen in kleur
[dataPath slicePath resultPath] = getPath;
load([resultPath 'annotationSummary_allSubjectsFilter.mat'], 'filterGtTable', 'filterDataTable', 'filterAnnotTable');
load([resultPath 'tasksSplitOnCFStatus.mat'], 'taskIDYesCF', 'taskIDNoCF');
numTasks=2380;

AllResults=1; %If set to one, all results will be shown in the scatterplot
Tasks=taskIDNoCF; %Choose specific numbers of tasks to analyse

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

%%
%%Correlatie buiten en binnen
[dataPath slicePath resultPath] = getPath;
load([resultPath 'annotationSummary_allSubjectsFilter.mat'], 'filterGtTable', 'filterDataTable', 'filterAnnotTable');
load([resultPath 'tasksSplitOnCFStatus.mat'], 'taskIDYesCF', 'taskIDNoCF');
numTasks=2380;

AllResults=1; %If set to one, all results will be shown in the scatterplot
Tasks=taskIDNoCF; %Choose specific numbers of tasks to analyse

if AllResults==1; 
    Tasks=[1:numTasks];
end

NInnerArea=[];
NOuterArea=[];
for k=1:length(taskIDNoCF)
    Task=taskIDNoCF(k);
    AnnTask=[];
    for i=1:length(filterDataTable)
        if filterDataTable(i,1)==Task
            AnnTask=[AnnTask; i];
        end
    end
    
    
    KWInnerArea=filterAnnotTable(AnnTask,1);
    KWOuterArea=filterAnnotTable(AnnTask,2);
    Type=filterDataTable(AnnTask,1);
    
    NInnerArea=[NInnerArea;KWInnerArea];
    NOuterArea=[NOuterArea;KWOuterArea];

end

YInnerArea=[];
YOuterArea=[];
for k=1:length(taskIDYesCF)
    Task=taskIDYesCF(k);
    AnnTask=[];
    for i=1:length(filterDataTable)
        if filterDataTable(i,1)==Task
            AnnTask=[AnnTask; i];
        end
    end
    
    
    KWInnerArea=filterAnnotTable(AnnTask,1);
    KWOuterArea=filterAnnotTable(AnnTask,2);
    Type=filterDataTable(AnnTask,1);
    
    YInnerArea=[YInnerArea;KWInnerArea];
    YOuterArea=[YOuterArea;KWOuterArea];

end
InnerArea=[NInnerArea; YInnerArea];
OuterArea=[NOuterArea; YOuterArea];
Group=[zeros(length(NInnerArea),1); ones(length(YInnerArea),1)];
figure; gscatter(InnerArea, OuterArea,Group, 'br')
axis([0 100 0 100]);
xlabel('Inner area in mm^2'); 
ylabel('Outer area in mm^2'); 
title('All annotations of the specified tasks');
