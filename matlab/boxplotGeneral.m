%% Load data
[dataPath slicePath resultPath] = getPath;
load([resultPath 'indexResultsTask.mat'], 'indexResultsTask');
numTasks=2380;

%%
AllBox=0; % if AllBox set to 1, all tasks will be shown in boxplot. NOT RECOMMENDED
 
 spec=[1, 4,5,6,7,8,9,10,11,12,13,43,15,16,17]; %specific tasks to show 
 Type=2; % 2 for inner area, 3 for outer area
 
 %miss later nog een stop inbouwen voor als geen 2 of 3 aangegeven is die
 % dan returned van vul dit in. 
 
 if AllBox == 1
     spec = 1:numTasks;
 end
 
 X=[];
 G=[];
 
 for i=1:length(spec)
     area=cell2mat(indexResultsTask(spec(i),Type));
     groep=spec(i)*ones(size(area));
     X=[X; area];
     G=[G; groep];
 end
 
 boxplot(X,G)
 
 %% Trash
%  %figure; boxplot(cell2mat(indexResultsTask(spec,Type)))
%  %figure; errorbar(mean(cell2mat(indexResultsTask(spec,Type))), std((cell2mat(indexResultsTask(spec,Type)))))
 
 %boxplot([InnerAreasTask,OuterAreasTask, InnerAreasTask1,OuterAreasTask1]);
%figure; errorbar(mean(InnerAreasTask), std(InnerAreasTask), 'o') 

%  mean(InnerAreasTask)
%  std(InnerAreasTask)
 %boxplot([InnerAreasTask,OuterAreasTask])
