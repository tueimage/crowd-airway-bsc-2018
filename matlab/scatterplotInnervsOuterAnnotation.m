%% Scatterplot airway lumen area vs. airway wall area
% This script generates a scatterplot of airway lumen area vs. ariway wall
% area and calculates the correlation coefficient and its p-value. This
% will be done for both the expert area assessment as the KWs' annotations

%% Load data
[dataPath slicePath resultPath] = getPath;
load([resultPath 'annotationSummary_allSubjectsFilter.mat'], 'filterGtTable', 'filterDataTable', 'filterAnnotTable');
load([resultPath 'tasksSplitOnCFStatus.mat'], 'taskIDYesCF', 'taskIDNoCF');

%% Retrieve the needed data
%This could be implemented more efficient, but it works.
%Retrieve the inner and outer area of the tasks of subjects without CF
Tasks=taskIDNoCF; 

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

%Retrieve the inner and outer area of the tasks of subjects with CF
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


%% Generate scatter plot of annotations

[rho,p]=corr(InnerArea, OuterArea)
%uncomment the next line if you want to see the two groups in different
%colors
%figure; gscatter(InnerArea, OuterArea,Group, 'br')
figure; scatter(InnerArea,OuterArea)
axis([0 100 0 100]);
xlabel('Airway lumen area in mm^2'); 
ylabel('Aiway wall area in mm^2'); 
title('Annotations of the KWs');

%adding a vertical and horizontal line to the scatterplot to indicate the
%annotations which did not change the size of one of the ellipses
hline=refline(0,23.7600);
hline.Color='r'; 
vline=line([23.7600 23.7600], [0 100]);
vline.Color='r'; 

%% Generate scatter plot of expert
InnerAreaE=filterGtTable(:,1);
OuterAreaE=filterGtTable(:,2);
[rho,p]=corr(InnerAreaE, OuterAreaE)

figure; scatter(InnerAreaE, OuterAreaE)
xlabel('Airway lumen area in mm^2'); 
ylabel('Aiway wall area in mm^2'); 
title('Area measurements expert');
