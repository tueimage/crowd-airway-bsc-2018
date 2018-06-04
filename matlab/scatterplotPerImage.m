%% This scripts generates scatterplots
% A scatterplot in which each point represents the of the outer area expert 
% vs. combination of kw's outer areas 
% scatterplot in which each point represents the the inner area expert vs.
% combination of the kw's inner areas

%% Define data paths and load data

[dataPath slicePath resultPath] = getPath;
load([resultPath 'annotationSummary_allSubjects.mat'],'gtTablePerTask');
%gtTablePerTask = [gtTablePerTask; areaInnerWieying, areaOuterWieying,areaInnerAdria, areaOuterAdria]; %per task 

load([resultPath 'indexResultsTask.mat'], 'indexResultsTask');
%indexResultsTask is a cell each row contains data from one image. The
%first column contains the task numbers, the second the inner areas, the
%third the outer areas and the fourth colum contains the wall area
%percentages. 
%% Expert's data

areaInnerExpert=gtTablePerTask(:,1);
areaOuterExpert=gtTablePerTask(:,2);
%% Knowledge workers' data
% the median of the annotated areas is used
numImage=length(indexResultsTask);
areaInnerKWCombined=[];
areaOuterKWCombined=[];

for i=1:numImage
areaInnerKWCombined=[areaInnerKWCombined; median(cell2mat(indexResultsTask(i,2)))];
areaOuterKWCombined=[areaOuterKWCombined; median(cell2mat(indexResultsTask(i,3)))];
end

%% Remove unusable annotated images
% images that were discarded due to the filter criteria are defined as NaN
% Remove those images in order to be able to calculate the correlation
AIE=[];
AIK=[];
AOE=[];
AOK=[];
for i=1:numImage
    if isnan(areaInnerKWCombined(i,1))==0 % if it doesnt contain NaN, than keep it as a point
        AIE=[AIE; areaInnerExpert(i,1)];
        AIK=[AIK; areaInnerKWCombined(i,1)];
    end
    if isnan(areaOuterKWCombined(i,1))==0
        AOE=[AOE; areaOuterExpert(i,1)];
        AOK=[AOK; areaOuterKWCombined(i,1)];
    end
end

%% Correlation
[rhoI,pval]=corr(AIE,AIK) %Inner areas / airway lumen
[rhoO,pval]=corr(AOE, AOK) %Outer areas / airway wall

%% Scatterplot of areas combined per image
figure; scatter(AIE, AIK, 'b')
xlabel('Expert area in mm^2'); 
ylabel('Worker area in mm^2'); 
title(['Airway lumen, median combined, r=', num2str(rhoI)]);
refline(1,0)

figure; scatter(AOE, AOK, 'b')
xlabel('Expert area in mm^2'); 
ylabel('Worker area in mm^2'); 
title(['Airway wall, median combined, r=', num2str(rhoO)]);
refline(1,0)

