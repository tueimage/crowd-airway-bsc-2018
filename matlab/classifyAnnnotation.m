function [b, numAnnot] = classifyAnnotation(centerX, centerY, angle, radius1, radius2)


%Start assuming it is a correct annotation, add rules which can change this
b = 1;

numAnnot = size(centerX,1);

%If nothing is annotated, or an odd number of annotations is made
if numAnnot == 0 || mod(numAnnot,2) ~= 0
    b = 0;
    return;
end


numPairs = numAnnot/2;


distMat = sqrt(pdist2(centerX, centerY));
distMat(logical(eye(size(distMat)))) = intmax;


[~, minix] = min(distMat,[],1);

distNN = zeros(size(distMat));
for i=1:size(distNN,2)
    distNN(minix(i),i) = 1;
end
[row,col]=ind2sub(size(distNN),find(distNN==1));


pairs = [row col];


removePairs = [];
for i=1:size(pairs,1)
    pairDist = distMat(pairs(i,1),pairs(i,2));
    if pairDist > 10
        removePairs = [removePairs i];
    end
end
pairs(removePairs,:) = [];
if isempty(pairs)
    b = 0;
    return;
end

