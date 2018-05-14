
%% extracting radius from ground truth. 

%Toevoegen in viewAndProcessResults net zoals de areas. 
whichGT=gt(subjectID).airways(airwayID).gt.id;
radiusInnerWieying=gt(subjectID).gt(whichGT).inner.global_radius;
radiusOuterWieying=gt(subjectID).gt(whichGT).outer.global_radius;
radiusInnerAdria = gt(subjectID).airways(airwayID).inner.global_radius;
radiusOuterAdria = gt(subjectID).airways(airwayID).outer.global_radius;

% in for loop deze appenden tot een dataset die je opslaat bij t verkrijgen
% van de data
radiusTable=[]; 

diameterInnerExpert=2*median([radiusTable(:,1), radiusTable(:,3)],2);
diameterOuterExpert=2*median([radiusTable(:,2), radiusTable(:,4)],2);

%% extracting radius from data KW
%radius1 en radius 2 zijn de radii van ??n ellipse. Hiervan wellicht een
%gemiddelde nemen. Dat is dan over 1 rij. 
%De tweede (als aanwezig) staat voor de andere annotatie. Grootste
%gemiddelde zal de outer radius zijn. De ander de inner.

annotation1Radius= mean([radius1(1) radius2(1)]);
annotation2Radius= mean([radius1(2) radius2(2)]);

outerRadius=max(annotation1Radius, annotation2Radius);
innerRadius=min(annotation1Radius, annotation2Radius); 

%% Properties

WT=(2*outerRadius-2*innerRadius)/2;
WTR=WT/(2*outerRadius);
