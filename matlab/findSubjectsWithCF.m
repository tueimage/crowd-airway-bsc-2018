[dataPath slicePath resultPath] = getPath;


%% Load ground truth measurements - original file Adria, this also contains the subjects variable
load(fullfile(dataPath, 'LUVAR_i64_I3_o64_O1_d20_th70_5mm_tapering80_TMI_PAPER.mat'),'data', 'subjects'); 
gt=data;

clear data;

%% 

subjectWithAirwaysID = [];
subjectWithAirwaysStatus = [];    

%Go through all subjects in ground truth data
for i=1:length(gt)
    
    %If this subject had any airways measured by experts
    if ~isempty(gt(i).airways) 
        
        %Get the real ID of this subject
        thisSubjectID = gt(i).airways(1).case_num;
        subjectWithAirwaysID = strvcat(subjectWithAirwaysID, thisSubjectID);
        
        %Get information about the subject 
        for j=1:length(subjects)
           if strcmp(subjects(j).ID, ['av' thisSubjectID])
                              
               subjectWithAirwaysStatus = [subjectWithAirwaysStatus; subjects(j).status]; % 1=no CF, 2=CF
               
               %Other measures like age could be collected here as well
           end
        end
    end
    subjectIDandStatus=[str2num(subjectWithAirwaysID), subjectWithAirwaysStatus];
end

save([resultPath 'subjects_status.mat'], 'subjectIDandStatus');
    %subjectIDandStatus contains the ID's and status of the subjects who's
    %airways were used for annotation
    
