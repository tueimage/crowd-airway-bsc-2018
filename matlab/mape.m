%% CHOOSE the annotation area of which you want to retrieve the MAPE
type=2; % %1=inner, 2=outer area 

%% Load data
[dataPath slicePath resultPath] = getPath;
load([resultPath 'subjectIDandStatusandTask.mat'], 'subjectIDandStatusandTask');
load([resultPath 'filterUsefulResults.mat'], 'filterGtTable', 'filterDataTable', 'filterAnnotTable');
load([resultPath 'subjectsCF.mat'], 'subjectsYesCF', 'subjectsNoCF');

%% uncomment if you want to have one average MAPE per subject -(not used in the research)
% %% Mean absolute percentage error of each subject
% %The overall MAPE value of each subject will be found in subjectIDandMAPE
% %It combines all usable annotations of all image slices of a subject into
% %one MAPE value. 
% 
% %DEFINE the type (subjectsNoCF or subjectsYesCF) of list with subject numbers 
% Type=subjectsYesCF;
% 
% %list that will contain the subject number with corresponding MAPE
% subjectIDandMAPE=zeros(length(Type),2);
% for i=1:length(Type)
%     subjectID=Type(i);
%     indexSubject=find(cell2mat(subjectIDandStatusandTask(:,1)) == subjectID);
%     tasksSubject=cell2mat(subjectIDandStatusandTask(indexSubject,3));
%     indexTable=find(ismember(filterDataTable(:,1),tasksSubject));
%     
%     pred=filterAnnotTable(indexTable,type); % type of area predicted by the KW
%     act=filterGtTable(indexTable,type); % type of area Wieying
%     
%     %Mean absolute percentage error
%     MAPE=mean((abs(act-pred))./(abs(act)))*100;
%     
%     subjectIDandMAPE(i,1)=subjectID;
%     subjectIDandMAPE(i,2)=MAPE;
% end


%% MAPE visualized by box per subject, which shows the deviation of the MAPE of each image slice
%list that will contain the subject number with corresponding MAPE
MAPEperTaskEachSubject=[];
meanMAPEperSubject=[];

for n=1:length(subjectIDandStatusandTask)
    subjectID=cell2mat(subjectIDandStatusandTask(n,1))
    
    %Find tasks/image slices that belong to the subjectID
    indexSubject=find(cell2mat(subjectIDandStatusandTask(:,1)) == subjectID);
    tasksSubject=cell2mat(subjectIDandStatusandTask(indexSubject,3));
    subjectTasksandMAPE=zeros(length(tasksSubject),2);
    
    %Find all annotations that belong to the image slices
    for i=1:length(tasksSubject)
        indexTable=find(ismember(filterDataTable(:,1),tasksSubject(i)));
        pred=filterAnnotTable(indexTable,type); %type of area predicted by the KW
        act=filterGtTable(indexTable,type); % type of area Wieying
        
        %Mean absolute percentage error
        MAPE=mean((abs(act-pred))./(abs(act)))*100;
        
        subjectTasksandMAPE(i,1)=subjectID;
        subjectTasksandMAPE(i,2)=MAPE;
        subjectTasksandMAPE(i,3)=tasksSubject(i);
    end
    mean(subjectTasksandMAPE(:,2)) %The mean of the MAPEs per image slice of the subject
    median(subjectTasksandMAPE(:,2))
    std(subjectTasksandMAPE(:,2))
    
    meanMAPEperSubject=[meanMAPEperSubject;mean(subjectTasksandMAPE(:,2))]; %Collect the mean MAPE per image slice of all subjects
    MAPEperTaskEachSubject=[MAPEperTaskEachSubject;subjectTasksandMAPE];
end

%% Boxplot ordered by healthy subjects and CF subjects
ixnocf = ismember(MAPEperTaskEachSubject(:,1),subjectsNoCF);
statusPerTask=nan(size(MAPEperTaskEachSubject));
statusPerTask(ixnocf) = 2; %if the tasks belongs to a subject without CF the status per task will be 2
statusPerTask(~ixnocf) = 1; %all other tasks (healthy subject) are 1. 
Id = MAPEperTaskEachSubject(:,1);
Id(statusPerTask==1)=Id(statusPerTask==1)+100; %when adding 100 to the ID value, this ID will be bigger than those of the healthy subject ID and thus sorted at the end
figure; boxplot(MAPEperTaskEachSubject(:,2), Id, 'labels', {'1','3','6','8','12','16','17','21','23','24','25','27','2','4','5','7','10','11','13','18','19','26','28','41'})
xlabel('subject ID')
ylabel('mean MAPE [%]')
if type==1
    title('MAPE of inner area per image slice')
else
    title('MAPE of outer area per image slice')
end
%ylim([0 650]) %specify the limit of the y-axis for a better view of the
%boxes.
%% Boxplot on numerical order
%figure; boxplot(MAPEperTaskEachSubject(:,2), MAPEperTaskEachSubject(:,1))

 