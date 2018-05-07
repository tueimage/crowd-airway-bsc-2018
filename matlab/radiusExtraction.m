
%% extracting radius from ground truth. 
whichGT=gt(subjectID).airways(airwayID).gt.id;
radiusInnerWieying=gt(subjectID).gt(whichGT).inner.global_radius;
radiusOuterWieying=gt(subjectID).gt(whichGT).outer.global_radius;
radiusInnerAdria = gt(subjectID).airways(airwayID).inner.global_radius;
radiusOuterAdria = gt(subjectID).airways(airwayID).outer.global_radius;

