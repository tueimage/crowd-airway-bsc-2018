%% Load data
[dataPath slicePath resultPath] = getPath;
load([resultPath 'indexResultsTask.mat'], 'indexResultsTask'); %contains all annotation data per task
load([resultPath 'subjectIDandStatusandTask.mat'], 'subjectIDandStatusandTask'); %contains all tasks and status per subject

%% Boxplot of inner OR outer area of the annotations of the tasks of one subject
%This script shows a box for each image slice of one specific subject. The
%values in the box are the usable area measurements of the crowd.

%CHOOSE 
indexSubject=1 %select specific indexes of IDs which you want to know
Type=2; % 2 for inner area, 3 for outer area
 

 spec=cell2mat(subjectIDandStatusandTask(indexSubject,3)); %specific tasks of one subject 
 X=[]; % will contain all annotated areas of a image slice
 G=[]; % will contain the image slice number 
 
 for i=1:length(spec)
     area=cell2mat(indexResultsTask(spec(i),Type));
     groep=spec(i)*ones(size(area));
     X=[X; area];
     G=[G; groep];
 end
 
 figure; boxplot(X,G)
 
 