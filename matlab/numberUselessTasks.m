%% Counts the number of tasks without usefull annotation results. 
%'tel' is this number

[dataPath slicePath resultPath] = getPath;
load([resultPath 'indexResultsTask.mat'], 'indexResultsTask');
tel=0;
for i=1:length(indexResultsTask)
    if isempty(cell2mat(indexResultsTask(i,1)))
        tel=tel+1;
    end
end
    
