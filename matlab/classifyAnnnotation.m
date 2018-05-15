function [isAnnotationUsable, numAnnot] = classifyAnnotation(centerX, centerY, angle, radius1, radius2)


%Start assuming it is a usable annotation, add rules which can change this
isAnnotationUsable = 1;

numAnnot = size(centerX,1);

%If nothing is annotated, or an odd number of annotations is made, it is
%unusable
if numAnnot == 0 || mod(numAnnot,2) ~= 0
    isAnnotationUsable = 0;
    return;
end

%% In this part, find out which of the ellipses belong to the same airway

%Threshold on the maximum pixel distance of the centers of two ellipses of
%the same airway
distanceThreshold=10; 

%Calculate distances between all ellipse centers, set distance to self to
%infinity
distMat = sqrt(pdist2(centerX, centerY));
distMat(logical(eye(size(distMat)))) = intmax;

%Find closest other ellipse
[~, minix] = min(distMat,[],1);
distNN = zeros(size(distMat));
for i=1:size(distNN,2)
    distNN(minix(i),i) = 1;
end
[row,col]=ind2sub(size(distNN),find(distNN==1));


%Store pairs of closest ellipses, e.g. en entry [1 3] means ellipse 1 is
%closest to ellipse 3
pairs = [row col];

%Remove pairs where the ellipses are too far apart from each other
removePairs = [];
for i=1:size(pairs,1)
    pairDist = distMat(pairs(i,1),pairs(i,2));
    if pairDist > distanceThreshold
        removePairs = [removePairs i];
    end
end
pairs(removePairs,:) = [];

%If there are no pairs left, this annotation is not usable
if isempty(pairs)
    isAnnotationUsable = 0;
    return;
end

