[dataPath slicePath resultPath] = getPath;


%% Load ground truth measurements - original file Adria, this also contains the subjects variable
load(fullfile(dataPath, 'LUVAR_i64_I3_o64_O1_d20_th70_5mm_tapering80_TMI_PAPER.mat'),'data', 'subjects'); 
gt=data;
clear data;

%% 

subjectWithAirwaysID = [];
subjectWithAirwaysStatus = [];

subjectPtno = [];

subjectFEV1_pPred = [];
subjectFVC_pPred = [];
        

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
                              
               subjectWithAirwaysStatus = [subjectWithAirwaysStatus; subjects(i).status];
               
               subjectPtno = strvcat(subjectPtno, subjects(i).ptno);
               
               subjectFEV1_pPred = [subjectFEV1_pPred; subjects(i).FEV1_pPred];
               subjectFVC_pPred = [subjectFVC_pPred; subjects(i).FVC_pPred];
               
               %Other measures like age could be collected here as well
           end
        end
    end
end

save('subjects_status.mat', 'subjectWithAirwaysID', 'subjectWithAirwaysStatus');
    
    