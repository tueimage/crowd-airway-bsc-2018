%Load GT
%load('C:\Users\Veronika\Dropbox\Postdoc\Lungs\luvar\LUVAR_i64_I3_o64_O1_d20_th70_5mm_tapering80_TMI_PAPER','data');
%gt = data;

dataPath = 'C:\Users\VCheplyg\Dropbox\10. Work\CrowdAirway\data\';

resultPath = 'C:\Users\VCheplyg\Dropbox\10. Work\CrowdAirway\results\';

%%
%Load ground truth measurements (structure Adria)
load(fullfile(dataPath, 'LUVAR_GoLive2.mat'),'data'); 
 gt=data;
 clear data;
 
 addpath('C:\Users\VCheplyg\Dropbox\MATLAB\json\parse_json_2009_07_23');

%% Load annotations - previous data, already analyzed
%Subject1, 4 orientations, 2nd try in total, 1st try with ellipse tool

%tic;
%https://nl.mathworks.com/matlabcentral/fileexchange/33381-jsonlab--a-toolbox-to-encode-decode-json-files
%data1=loadjson(fullfile(dataPath, 'Veronika_Slices_Subject1_Try2_20160525_0805.json'), 'ShowProgress', 1); 
%toc;
%43 seconds

%tic;
%Get JSON toolbox from http://www.artefact.tk/software/matlab/jsonio/ 
%data2=jsonread(fullfile(dataPath, 'Veronika_Slices_Subject1_Try2_20160525_0805.json')); 
%toc;
%2 seconds. AT least 10 mins for full file, doesn't finish

%%
%All subjects (Subject batch number 2), 1 orientation - this data has not been analyzed yet! 


%https://nl.mathworks.com/matlabcentral/fileexchange/23393--another--json-parser

tic;
s=fileread(fullfile(dataPath, 'Veronika_Slices_Subject2_Try1_20160622_1043.json'));
data=parse_json(s); 
toc;
%2 minutes! fastest method

%%
%TODO: some parameters needed later?
C=get(gca,'colororder');

voxelSize = 0.55;  %0.5508 x 0.5508 x 0.6000, how to convert distances in 2D slices back to real-world measurements? 
imageScaling = 0.1;

scaleFactor = voxelSize*imageScaling;



%%  For easy analysis, let's collect data in tables

gtTable = [];    %Ground truth measurements (Wiyeing and Adria's algorithm)

dataTable = [];  %Details of task 
annotTable = []; %Measurements of annotation 


numTasks = length(data.project.tasks);


whichAnnotator = '';


showImages = 0;

if showImages == 1
    numTasksToShow = 100;
else
    numTasksToShow = numTasks;
end


for i=1:numTasksToShow
    [i numTasksToShow]
    currentTask = data.project.tasks(i);
    currentTask = currentTask{1};        %Necessary because of the way parse_json loads the files, otherwise could use data.project.tasks(i) directly
    
    fileName = currentTask.frame.original;
    fileParts = strsplit(fileName, '/');
    origFileName = fileParts{length(fileParts)}; 
        
    ids = sscanf(origFileName, 'data(%d).airways(%d).viewpoints(%d)', [1, inf]);
    subjectID = ids(1);
    airwayID = ids(2);
    viewpoint = ids(3);
        
    
    
    numRes = length(currentTask.results);
    if numRes>0

        %Get original image of that task
        if showImages == 1
            im = imread([dataPath '\slices_GoLive2\' origFileName]);
        end

        for j=1:numRes
            
            if showImages == 1
                imshow(im);
            end
                                    
            whichGT=gt(subjectID).airways(airwayID).gt.id;
            areaInnerWieying=gt(subjectID).gt(whichGT).inner.global_area;
            areaOuterWieying=gt(subjectID).gt(whichGT).outer.global_area;
            
            whichPoint=gt(subjectID).airways(airwayID).gt.airway_point_id;
            areaInnerAdria = gt(subjectID).airways(airwayID).inner.area(whichPoint);
            areaOuterAdria = gt(subjectID).airways(airwayID).outer.area(whichPoint);
            

                       
            vec = gt(subjectID).airways(airwayID).viewpoints.vec;
                        
            if showImages == 1
                title(sprintf('Wieying %2.1f-%2.1f, Adria %2.1f-%2.1f', areaInnerWieying, areaOuterWieying, areaInnerAdria, areaOuterAdria));
            end
                        
            currentResults = currentTask.results(j);
            currentResults = currentResults{1};
            
            numAnnot=length(currentResults.annotations);
            
                       
            
            %Create structures to store information about ellipses, to
            %use for analysis later
            [centerX, centerY, angle, radius1, radius2] = measureEllipses(currentResults.annotations);
  
            if showImages == 1
                   ellipse(radius1,radius2,angle,centerX,centerY);    
            end
                        
            useAnnotation = classifyAnnnotation(centerX, centerY, angle, radius1, radius2);
            
            
            if numAnnot > 0
                currentAnnotation = currentResults.annotations(1);
                currentAnnotation = currentAnnotation{1};
                whichAnnotator = strvcat(whichAnnotator, currentAnnotation.meta.creator);
            else
                whichAnnotator = strvcat(whichAnnotator, 'unknown');
            end
            
            
            dataTable = [dataTable; i numAnnot useAnnotation];
            gtTable = [gtTable; areaInnerWieying, areaOuterWieying, areaInnerAdria, areaOuterAdria];
           
            
            %TODO Need to transform length of radii to world coordinates
            
            if length(radius1)>1
                
                area1=(radius1(1)*scaleFactor) * (radius2(1)*scaleFactor) * pi;
                area2=(radius1(2)*scaleFactor) * (radius2(2)*scaleFactor) * pi;
                
                if showImages == 1
                    xlabel(sprintf('Use %d, %2.1f-%2.1f', useAnnotation, area1, area2));
                end
                
                annotTable = [annotTable; min(area1,area2), max(area1,area2)];
            
            else
                if showImages == 1
                    xlabel(sprintf('Use %d', useAnnotation));
                end
                
                if length(radius1)==1
                      area1=(radius1(1)*scaleFactor) * (radius2(1)*scaleFactor) * pi;
                      annotTable = [annotTable; area1 nan];
                else
                 annotTable = [annotTable; nan nan];
                end
            end
            
                        
            if showImages == 1
                pause;
            end
        end
    end
end

save([resultPath 'annotationSummary_allSubjects.mat'], 'gtTable', 'dataTable', 'annotTable');



%%
load([resultPath 'annotationSummary_allSubjects.mat'], 'gtTable', 'dataTable', 'annotTable');

%Columns:
%dataTable = [dataTable; i numAnnot useAnnotation];
%gtTable = [gtTable; areaInnerWieying, areaOuterWieying, areaInnerAdria, areaOuterAdria];
%annotTable = [annotTable; min(area1,area2), max(area1,area2)]; %or nan if only one or zero ellipses are drawn




