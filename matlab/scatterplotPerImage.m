%% Define data paths and load data

[dataPath slicePath resultPath] = getPath;
load([resultPath 'annotationSummary_allSubjects.mat'], 'gtTable', 'dataTable', 'annotTable', 'gtTablePerTask');
%Columns:
%dataTable = [dataTable; i numAnnot useAnnotation];
%gtTable = [gtTable; areaInnerWieying, areaOuterWieying, areaInnerAdria, areaOuterAdria]; %per result
%annotTable = [annotTable; min(area1,area2), max(area1,area2)]; %or nan if only one or zero ellipses are drawn
%gtTablePerTask = [gtTablePerTask; areaInnerWieying, areaOuterWieying,areaInnerAdria, areaOuterAdria]; %per task 


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

%% Median experts' data
areaInnerExpertCombined=median([gtTablePerTask(:,1), gtTablePerTask(:,3)],2);
areaOuterExpertCombined=median([gtTablePerTask(:,2), gtTablePerTask(:,4)],2);

%% Median knowledge workers' data
numTask=length(gtTablePerTask);
areaInnerKWCombined=[]; % Contains median annotation inner area of each task. 
areaOuterKWCombined=[]; % Contains median annotation outer area of each task. 

for i=1:numTask
    combineAreaInner=[];
    combineAreaOuter=[];
    for j=1:length(filterDataTable)
        if filterDataTable(j,1)==i
            combineAreaInner=[combineAreaInner; filterAnnotTable(j,1)];
            combineAreaOuter=[combineAreaOuter; filterAnnotTable(j,2)];
        end
    end
    CAI= median(combineAreaInner);
    CAO= median(combineAreaOuter);
    areaInnerKWCombined=[areaInnerKWCombined; CAI];
    areaOuterKWCombined=[areaOuterKWCombined; CAO];
    
end

% De NaN die nu nog in areaInner/OuterKWCombined voorkomen zijn de tasks
% die geen enkele bruikbare annotaties hebben opgeleverd. 
    
            

%% Scatterplot of areas combined per image
figure; scatter(areaInnerExpertCombined, areaInnerKWCombined, 'b')
xlabel('Expert area in mm^2'); 
ylabel('Worker area in mm^2'); 
title('Inner airway, median combined');
refline(1,0)

figure; scatter(areaOuterExpertCombined, areaOuterKWCombined, 'b')
xlabel('Expert area in mm^2'); 
ylabel('Worker area in mm^2'); 
title('Outer airway, median combined');
refline(1,0)
