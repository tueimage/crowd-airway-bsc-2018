%% Load data
[dataPath slicePath resultPath] = getPath;
load([resultPath 'filterUsefulResults.mat'], 'filterGtTable', 'filterDataTable', 'filterAnnotTable');
numTasks=2380;

%% 
indexResultsTask=cell(numTasks,1);
for i=1:numTasks
    indexes=[];
    for j=1:length(filterDataTable)
        if filterDataTable(j,1)==i
            indexes=[indexes j];
        end
    end
    indexResultsTask(i,1)={indexes};
end

%%
AllTasks=0; %If set to one, all results will be shown in the scatterplot
Tasks=[117,119];%Choose specific numbers of tasks to analyse
% Later ervoor zorgen dat in Tasks alleen degene met CF of zonder CF komen,
% zodat je alleen van die categorien data in een figuur krijgt. 

if AllTasks==1; 
    Tasks=[1:numTasks];
end
for i=1:length(Tasks)
    task=Tasks(i);

     InnerAreasTask=[];
     OuterAreasTask=[];
     indexesAnnotations=cell2mat(indexResultsTask(task,1))
     for j=1:length(indexesAnnotations)
         indexAnnotation=indexesAnnotations(j);
         InnerAreasTask=[InnerAreasTask; filterAnnotTable(indexAnnotation,1)];
         OuterAreasTask=[OuterAreasTask; filterAnnotTable(indexAnnotation,2)];
     end
     
     boxplot([InnerAreasTask,OuterAreasTask]);
     hold on; 
     %figure; errorbar(mean(InnerAreasTask), std(InnerAreasTask), 'o')
 end
%  mean(InnerAreasTask)
%  std(InnerAreasTask)
 %boxplot([InnerAreasTask,OuterAreasTask])
