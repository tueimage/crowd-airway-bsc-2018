%% Load data
[dataPath slicePath resultPath] = getPath;
load([resultPath 'indexResultsTask.mat'], 'indexResultsTask'); %contains all annotation data per task
load([resultPath 'subjectIDandStatusandTask.mat'], 'subjectIDandStatusandTask'); %contains all tasks and status per subject

%% Boxplot of inner OR outer area of the annotations of the tasks of one subject
 indexSubject=1
 spec=cell2mat(subjectIDandStatusandTask(indexSubject,3)); %specific tasks of one subject
 Type=3; % 2 for inner area, 3 for outer area
 
 %miss later nog een stop inbouwen voor als geen 2 of 3 aangegeven is die
 % dan returned van vul dit in. 
 
 X=[];
 G=[];
 
 for i=1:length(spec)
     area=cell2mat(indexResultsTask(spec(i),Type));
     groep=spec(i)*ones(size(area));
     X=[X; area];
     G=[G; groep];
 end
 
 figure; boxplot(X,G)
 
 %%
 
 