function [centerX, centerY, angle, radius1, radius2] = measureEllipses(annotations)

numAnnot=length(annotations);

centerX = nan(numAnnot,1);
centerY = nan(numAnnot,1);
angle = nan(numAnnot,1);
radius1 = nan(numAnnot,1);
radius2 = nan(numAnnot,1);

for k=1:length(annotations)
    
    %Draw ellipse
    currentAnnotation = annotations(k);
    currentAnnotation = currentAnnotation{1}; %due to parse_json
    
    pts=cell2mat(currentAnnotation.points{1});
    ptsX = pts(1:2:end);
    ptsY = pts(2:2:end);
    
    centerX(k) = ptsX(1);
    centerY(k) = ptsY(1);
    
    v1 = [ptsX(1)-ptsX(2), ptsY(1)-ptsY(2)];
    v2 = [1, 0];
    dot = v1(1)*v2(1) + v1(2)*v2(2) ;
    det = v1(1)*v2(2) - v1(2)*v2(1) ;
    angle(k) = -atan2(det, dot);
    
    vec1 = [centerX(k) centerY(k); ptsX(2) ptsY(2)];
    vec2= [centerX(k) centerY(k); ptsX(3) ptsY(3)];
    
    radius1(k) = pdist(vec1, 'euclidean');
    radius2(k) = pdist(vec2, 'euclidean');
   
end