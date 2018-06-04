%% Load data 
[dataPath slicePath resultPath] = getPath;
load([resultPath 'subjectIDandStatusandTask.mat'], 'subjectIDandStatusandTask'); %contains all tasks and status per subject
load([resultPath 'filterUsefulResults.mat'], 'filterGtTable', 'filterDataTable', 'filterAnnotTable');
%%
for index=1:length(subjectIDandStatusandTask(:,1))
    tasksOfSubject= cell2mat(subjectIDandStatusandTask(index,3)); %all images of subject 41
    indexAnnotations = find(ismember(filterDataTable(:,1), tasksOfSubject)); %alle annotaties van subject 41
    gtOuterArea=filterGtTable(indexAnnotations,2);
    
    %finding the largest and smallest airway of the subject by selecting the
    %maximum and minimum outer area of all images annotated by the expert.
    LairwaySubject=max(gtOuterArea);
    SairwaySubject=min(gtOuterArea);
    
    %The indexes of the KW results belonging to the largest and smalest airway
    indexLargestAirway=find(ismember(gtOuterArea,LairwaySubject));
    indexSmallestAirway=find(ismember(gtOuterArea,SairwaySubject));
    
    disp( [num2str(length(indexLargestAirway)), ' annotations available of the largest airway and ', num2str(length(indexSmallestAirway)), ' annotations of the smallest airway'])
    
    %(crowdArea-expertArea)/expertArea
    %Relative differences on the outer and inner area of the LARGEST airway of
    %the subject
    relDifOutL= (filterAnnotTable(indexLargestAirway,2)-filterGtTable(indexLargestAirway,2))./filterGtTable(indexLargestAirway,2);
    relDifInL= (filterAnnotTable(indexLargestAirway,1)-filterGtTable(indexLargestAirway,1))./filterGtTable(indexLargestAirway,1); %Relative differences on the outer and inner area of the largest airway of
    
    %Relative differences on the outer and inner area of the SMALLEST airway ofthe subject
    relDifOuts= (filterAnnotTable(indexSmallestAirway,2)-filterGtTable(indexSmallestAirway,2))./filterGtTable(indexSmallestAirway,2);
    relDifIns= (filterAnnotTable(indexSmallestAirway,1)-filterGtTable(indexSmallestAirway,1))./filterGtTable(indexSmallestAirway,1);
    keyboard
end

%% BOxplot 
% met ieder subject erin met de grootste en kleinste luchtweg 