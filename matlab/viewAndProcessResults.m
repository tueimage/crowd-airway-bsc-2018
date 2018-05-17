%% Define data paths 

[dataPath slicePath resultPath] = getPath;


%% Load ground truth measurements 
load(fullfile(dataPath, 'LUVAR_GoLive2.mat'),'data'); 
gt=data;
clear data;

%% Load crowdsourcing data for all subjects 

tic;
s=fileread(fullfile(dataPath, 'Veronika_Slices_Subject2_Try1_20160622_1043.json')); %In the file name, "Subject2" means it is the second batch of subjects (all)

%Parse JSON file (the code is from
%https://nl.mathworks.com/matlabcentral/fileexchange/23393--another--json-parser)
data=parse_json(s); %This is a bit slow, takes 2 minutes on Veronika's laptop
toc;

%% Initialize parameters

%How to convert distances in 2D slices to real-life distances in 3D
voxelSize = 0.55;  %The real voxel size is 0.5508 x 0.5508 x 0.6000, assuming equal size right now
imageScaling = 0.1;
scaleFactor = voxelSize*imageScaling;

%Arrays to collect data
gtTable = [];    %Ground truth measurements (Wiyeing and Adria's algorithm)
dataTable = [];  %Details of task 
annotTable = []; %Measurements of annotation
gtTablePerTask = []; %Ground truth measurements per task (Wiyeing and Adria's algoritm) 
whichAnnotator = '';  %A string to store IDs of the crowd annotators


%How many images to display
showImages = 0;  %If set to 1, the code below will show 100 images, and you need to press the spacebar before going to the next image




%% Go through the crowdsourcing tasks

%How many tasks are there
numTasks = length(data.project.tasks);

%How many tasks to go through
if showImages == 1
    numTasksToShow = 5;
else
    numTasksToShow = numTasks;
end

%Go through the tasks
for i=1:numTasksToShow
    fprintf('Task %d of %d\n', i, numTasksToShow);
    
    %Extract data of this task
    currentTask = data.project.tasks(i);
    currentTask = currentTask{1};        %Necessary because of the way parse_json.m loads the files
    
    fileName = currentTask.frame.original;
    fileParts = strsplit(fileName, '/');
    origFileName = fileParts{length(fileParts)}; %Filename corresponding to the airway image
        
    ids = sscanf(origFileName, 'data(%d).airways(%d).viewpoints(%d)', [1, inf]);
    subjectID = ids(1);     %Which subject the airway is from
    airwayID = ids(2);      %Which airway of that subject is it
    viewpoint = ids(3);     %Which viewpoint of the airway (in this data, this is always 1)
            
    
    %How many crowdsourcing results are there for this task
    numRes = length(currentTask.results);

    %If there are any results, (optionally) show them, and measure the annotations
    if numRes>0
        %Get original image of this airway
        if showImages == 1
            im = imread([slicePath 'slices_GoLive2\' origFileName]);
        end
        
        %Load the ground truth measurements for this airway
        whichGT=gt(subjectID).airways(airwayID).gt.id;
        areaInnerWieying=gt(subjectID).gt(whichGT).inner.global_area;
        areaOuterWieying=gt(subjectID).gt(whichGT).outer.global_area;
            
        whichPoint=gt(subjectID).airways(airwayID).gt.airway_point_id;
        areaInnerAdria = gt(subjectID).airways(airwayID).inner.area(whichPoint);
        areaOuterAdria = gt(subjectID).airways(airwayID).outer.area(whichPoint);
                                   
        vec = gt(subjectID).airways(airwayID).viewpoints.vec;
        
        %Add airway ground truth of each task to the corresponding array
        gtTablePerTask = [gtTablePerTask; areaInnerWieying, areaOuterWieying, areaInnerAdria, areaOuterAdria];
        
        %Go through crowdsourcing results
        for j=1:numRes
          
            %Display image and ground truth measurements in the image
            if showImages == 1
                imshow(im);
                title(sprintf('Wieying %2.1f-%2.1f, Adria %2.1f-%2.1f', areaInnerWieying, areaOuterWieying, areaInnerAdria, areaOuterAdria));
            end
            
            %Go through the annotations within this result (ideally, there
            %should be two annotations, for the inner and outer airway)
            currentResults = currentTask.results(j);
            currentResults = currentResults{1};
            numAnnot=length(currentResults.annotations);
                        
            % Measure the ellipses in this image. This function loops through the annotations
            [centerX, centerY, angle, radius1, radius2] = measureEllipses(currentResults.annotations);
  
            % Draw ellipses. This functions loops through the annotations
            if showImages == 1
                ellipse(radius1,radius2,angle,centerX,centerY);    
            end
            
            % Decide if these annotations are "usable". This is now defined
            % as two ellipses within each other (for inner and outer airway),
            % but this could be changed
            useAnnotation = classifyAnnnotation(centerX, centerY, angle, radius1, radius2);
            
            % Record the IDs of the annotators who made the annotations
            if numAnnot > 0
                currentAnnotation = currentResults.annotations(1);
                currentAnnotation = currentAnnotation{1};
                whichAnnotator = strvcat(whichAnnotator, currentAnnotation.meta.creator);
            else
                whichAnnotator = strvcat(whichAnnotator, 'unknown');
            end
            
            %Add airway ground truth to the corresponding array
            gtTable = [gtTable; areaInnerWieying, areaOuterWieying, areaInnerAdria, areaOuterAdria];
            
            %Add crowdsourcing details to the corresponding array
            dataTable = [dataTable; i numAnnot useAnnotation subjectID];
            
                       
            %Measure the ellipses - this currently assumes that voxels are square, which is not the case. 
            
            %If there are 2 or more ellipses
            if length(radius1)>1
                
                area1=(radius1(1)*scaleFactor) * (radius2(1)*scaleFactor) * pi;
                area2=(radius1(2)*scaleFactor) * (radius2(2)*scaleFactor) * pi;
                
                if showImages == 1
                    xlabel(sprintf('Use %d, %2.1f-%2.1f', useAnnotation, area1, area2));
                end
                
                %Add measurements to the corresponding array
                annotTable = [annotTable; min(area1,area2), max(area1,area2)];
                
            %If there is only 1, or 0 ellipses
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

%Save the results
save([resultPath 'annotationSummary_allSubjects.mat'], 'gtTable', 'dataTable', 'annotTable', 'gtTablePerTask');

%%
load([resultPath 'annotationSummary_allSubjects.mat'], 'gtTable', 'dataTable', 'annotTable', 'gtTablePerTask');

%Columns:
%dataTable = [dataTable; i numAnnot useAnnotation];
%gtTable = [gtTable; areaInnerWieying, areaOuterWieying, areaInnerAdria, areaOuterAdria]; %per result
%annotTable = [annotTable; min(area1,area2), max(area1,area2)]; %or nan if only one or zero ellipses are drawn
%gtTablePerTask = [gtTablePerTask; areaInnerWieying, areaOuterWieying,areaInnerAdria, areaOuterAdria]; %per task 

