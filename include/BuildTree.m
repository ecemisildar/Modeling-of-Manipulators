function [iTj] = BuildTree()
% This function should build the tree of frames for the chosen manipulator.
% Inputs: 'None'
% Outputs: The tree of frames.

% A is the transformation matrix with dh parameters
% iTj is a 3-dimensional matlab matrix, suitable for defining tree of frames.
% iTj should represent the transformation matrix between the i-th and j-th frames.
% iTj(row,col,link_idx)

%theta is how much its turning
syms theta;
numberOfLinks = 7;
%rotating around z axis
Rz = [cos(theta) -sin(theta) 0;
      sin(theta)  cos(theta) 0;
      0 0 1];
%axis changings between the frames
R = [[1 0 0; 0 1 0; 0 0 1]... %R01
    ,[0 1 0; 0 0 1; 1 0 0]... %R12
    ,[1 0 0; 0 0 -1; 0 1 0]...%R23
    ,[1 0 0; 0 0 1; 0 -1 0]...%R34
    ,[1 0 0; 0 0 -1; 0 1 0]...%R45
    ,[1 0 0; 0 0 1; 0 -1 0]...%R56
    ,[1 0 0; 0 0 -1; 0 1 0]]; %R67
%it makes the 3d matrix in the desired format 3x3x7
R = reshape(R,[3 3 7]);
%translations between frames
T = [0 0 175;         %T01
     0 0 (213-175);   %T12
     0 -(420-326.5) 0;%T23
     145.5 0 326.5;   %T34
     0 35 0;          %T45
     0 0 -(420-35);   %T56
     0 153 0]*1e-2;   %T67
%making it column matrix intead of row
T = T';
%calculates the symbolic transformation matrix for each frame 
    for i = 1:numberOfLinks
          %rotational part
          iTj(1:3,1:3,i) = R(:,:,i) * Rz;
          %translational part
          iTj(1:3,4,i) = T(:,i);
          %dummy part to obtain square matrix
          iTj(4,:,i) = [0 0 0 1];
    end

end
