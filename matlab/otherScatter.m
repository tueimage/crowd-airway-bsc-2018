%% Scatter specific tasks 
% This script creates an expert-vs-worker plot in which specific tasks will
% be shown. The corresponding lumen and wall areas of an image are shown in
% the same color. 

%% Load data
[dataPath slicePath resultPath] = getPath;
load([resultPath 'annotationSummary_allSubjectsFilter.mat'], 'filterGtTable', 'filterDataTable', 'filterAnnotTable');
numTasks=2380; %The number of images of the original dataset

%%
AllResults=0; %If set to one, all results will be shown in the scatterplot
Tasks=[1,2,1976, 21]; %Choose specific numbers of images to show, if this image was discarded by filtering, then no results for this image will be shown, e.g. task 21. 

if AllResults==1; 
    Tasks=[1:numTasks];
end

Group=[];
MTExpertArea=[];
MTKWArea=[];
MTGroup=[];
for k=1:length(Tasks)
    Task=Tasks(k);
    AnnTask=[];
    for i=1:length(filterDataTable)
        if filterDataTable(i,1)==Task
            AnnTask=[AnnTask; i];
        end
    end
    %Expert's area is median combined to one single value per task
    ExpertInnerArea=(filterGtTable(AnnTask,1));
    ExpertOuterArea=(filterGtTable(AnnTask,2));
    
    KWInnerArea=filterAnnotTable(AnnTask,1);
    KWOuterArea=filterAnnotTable(AnnTask,2);
    
    ExpertArea=[ExpertInnerArea; ExpertOuterArea];
    KWArea=[KWInnerArea; KWOuterArea];
    
    Type=filterDataTable(AnnTask,1);
    Group=[Type; Type];
    MTGroup=[MTGroup; Group];
    MTExpertArea=[MTExpertArea; ExpertArea];
    MTKWArea=[MTKWArea; KWArea];
    

end
%scatterplot with each image a different color.
figure; gscatter(MTExpertArea, MTKWArea,MTGroup)
axis([0 80 0 80]); %The axis is set to 80 to make sure that individual dots can be seen, but this prevents larger areas from being displayed so always check if you should adjust this value.
xlabel('Expert area in mm^2'); 
ylabel('Worker area in mm^2'); 
title('All annotations of the specific images selected, lumen area and wall area');
