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
%Unit in the fourth colom contains a column with the Wall Area Percentages
%of the task
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
    WAPTask=[];
    indexesAnnotations=cell2mat(indexResultsTask(task,1));
    for j=1:length(indexesAnnotations)
        indexAnnotation=indexesAnnotations(j);
        InnerAreasTask=[InnerAreasTask; filterAnnotTable(indexAnnotation,1)];
        OuterAreasTask=[OuterAreasTask; filterAnnotTable(indexAnnotation,2)];
        WAPTask=[WAPTask; filterAnnotTable(indexAnnotation,3)];
        indexResultsTask(task,2)= {InnerAreasTask};
        indexResultsTask(task,3)= {OuterAreasTask};
        indexResultsTask(task,4)= {WAPTask};
    end
end
 
save([resultPath 'indexResultsTask.mat'], 'indexResultsTask');