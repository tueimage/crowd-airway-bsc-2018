%% Notities
%Altijd pathways aanroepen en data inladen. numTasks kun je verder terug leiden naar begin data wanneer deze ingeladen
%is.Tasks altijd specificeren wanneer je niet alles wilt zien. 
%Assen zijn nu ingesteld op 50, maar outliers zie je nu niet. 
%Data van experts is nog via median gedaan.

[dataPath slicePath resultPath] = getPath;
load([resultPath 'annotationSummary_allSubjectsFilter.mat'], 'filterGtTable', 'filterDataTable', 'filterAnnotTable');
numTasks=2380;

AllResults=0; %If set to one, all results will be shown in the scatterplot
Tasks=[1,2,1665];%,3,4,5,6,7,8,9,10,11,12,12,14,15,16,17,18,19]; %Choose specific numbers of tasks to analyse

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
    ExpertInnerArea=median([filterGtTable(AnnTask,1), filterGtTable(AnnTask,3)],2);
    ExpertOuterArea=median([filterGtTable(AnnTask,2), filterGtTable(AnnTask,4)],2);
    
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

figure; gscatter(MTExpertArea, MTKWArea,MTGroup)
axis([0 80 0 80]);
xlabel('Expert area in mm^2'); 
ylabel('Worker area in mm^2'); 
title('All annotations of each task, inner and outer');
refline(1,0)