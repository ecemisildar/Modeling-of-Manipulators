function [r]=GetBasicVectorWrtBase(biTei, linkNumber)
%%% GetBasicVectorWrtBase function 
% input :
% iTj transformation matrix in between i and j 
% output
% r : basic vector from i to j

if linkNumber == 1
    r = [0 0 0];
else
    %difference between two sequential frames
    xi = biTei(1,4,linkNumber-1);
    yi = biTei(2,4,linkNumber-1);
    zi = biTei(3,4,linkNumber-1);
    xj = biTei(1,4,linkNumber);
    yj = biTei(2,4,linkNumber);
    zj = biTei(3,4,linkNumber);
    
    r = [(xi-xj), (yi-yj), (zi-zj)];
    
end


end