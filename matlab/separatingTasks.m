%% Load data
[dataPath slicePath resultPath] = getPath;
load([resultPath 'filterUsefulResults.mat'], 'filterGtTable', 'filterDataTable', 'filterAnnotTable');
numTasks=2380;

%% Constructing a cell with each row a task who's number is equivalent to the row index
%indexResultsTask contains three columns: 
%Unit in first column contains the row of index numbers
%that contain information of the task in filter- AnnotTable, DataTable and
%GtTable. 
%Unit in the second column contains a columnl with the annotated inner areas
%of that task
%Unit in the third colum contains a column with the annotated outer areas of
%the task
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

for task=1:numTasks;
    InnerAreasTask=[];
    OuterAreasTask=[];
    indexesAnnotations=cell2mat(indexResultsTask(task,1));
    for j=1:length(indexesAnnotations)
        indexAnnotation=indexesAnnotations(j);
        InnerAreasTask=[InnerAreasTask; filterAnnotTable(indexAnnotation,1)];
        OuterAreasTask=[OuterAreasTask; filterAnnotTable(indexAnnotation,2)];
        indexResultsTask(task,2)= {InnerAreasTask};
        indexResultsTask(task,3)= {OuterAreasTask};
    end
end
 %%
 AllBox=0; % if AllBox set to 1, all tasks will be shown in boxplot.
 spec=[1,2]; %specific tasks to show 
 Type=2 % 2 for inner area, 3 for outer area
 % miss later nog een stop inbouwen voor als geen 2 of 3 aangegeven is die
 % dan returned van vul dit in. 
 if AllBox == 1
    spec = numTasks;
 end
 
 % wilt een figuur met twee boxplots, waarvan een van de inner area van
 % task 1 is en de ander van task 2. 
 % handmatig kun je dat doen door boxplot([info1 , info2]) 
 % ongelijke lengte van de info geeft ook een probleem. Dus wanneer van
 % task 1 9x de area geannoteerd is, maar van task 2 11x. 
 % Maar ik wil eigenlijk dat dit aantal tussen [] niet vast staat, maar dat
 % je dus ook 100 kunt weergeven of 6 afhankelijk van hoeveel tasks je
 % specificeert. 

 
 %  boxes=[];
%  for i=1:length(spec)
%      boxes=[boxes, cell2mat(indexResultsTask(spec(i),Type))];
%  end
%  figure; boxplot(boxes)
 figure; boxplot([cell2mat(indexResultsTask(spec(1),Type)), cell2mat(indexResultsTask(spec(2),Type))])
 %figure; boxplot(cell2mat(indexResultsTask(spec,Type)))
 %figure; errorbar(mean(cell2mat(indexResultsTask(spec,Type))), std((cell2mat(indexResultsTask(spec,Type)))))
 

 
 
 
 
 
 %boxplot([InnerAreasTask,OuterAreasTask, InnerAreasTask1,OuterAreasTask1]);
%figure; errorbar(mean(InnerAreasTask), std(InnerAreasTask), 'o') 

%  mean(InnerAreasTask)
%  std(InnerAreasTask)
 %boxplot([InnerAreasTask,OuterAreasTask])
