%% Modelling and Control of Manipulator assignment 2: Manipulator Geometry and Direct kinematic
clc;
clear;
close all;
addpath('include');


%% 1.
% You will need to define all the model matrices, and fill the so called iTj matrices inside BuildTree() function
% Be careful to define the z-axis coinciding with the joint rotation axis,
% and such that the positive rotation is the same as showed in the CAD model you received.
clear;clc;
geom_model = BuildTree();
% Useful initizializations
numberOfLinks = 7;                  % number of manipulator's links.
linkType = zeros(1,numberOfLinks);  % boolean that specifies two possible link types: Rotational, Prismatic.
bri= zeros(3,numberOfLinks);        % Basic vector of i-th link w.r.t. base
bTi = zeros(4,4,numberOfLinks);     % Trasformation matrix i-th link w.r.t. base

iTj = zeros(4,4,1);
% Initial joint configuration
q = 1.3*ones(1,7);
% q = [1.3, 0, 1.3, 1.7, 1.3, 0.8, 1.3];
% q = [1.3, 0.1, 0.1, 1, 0.2, 0.3, 1.3];

% Q1.1 and Q1.2
biTei = GetDirectGeometry(q, geom_model, linkType);

%Q1.3
for i = 1:numberOfLinks

    bTi(:,:,i)= GetTransformationWrtBase(biTei, i);

end
%if we want to calculate transformation between joint 3 to 6
linkNumber_i = [3,6];
length = linkNumber_i(2) - linkNumber_i(1);
%it takes first and last joint and all the transformation matrices
for i = 1:length
    iTj(:,:,i) = GetFrameWrtFrame(linkNumber_i(1),linkNumber_i(2), biTei);
end
%for calculating vectors between base and joints
for i = 1:numberOfLinks
    bri(:,i) = GetBasicVectorWrtBase(biTei, i);
end
%%
% Q1.4
% Hint: use plot3() and line() matlab functions.
clc
k = 5;%for ploting axis
qi = q;%initial configuration
%final configuartions
% qf = 2*ones(1,7);
% qf = [2, 0, 1.3, 1.7, 1.3, 0.8, 1.3];
% qf = [1.3 1.3 1.3 1.3 1.3 1.3 1.3];
qf = [1.3 1.3 1.3 2 1.3 1.3 1.3];
%iteration number for plot
numberOfSteps = 100;

for i= 1:numberOfLinks

    Q(:,i) = linspace(q(i),qf(i),numberOfSteps);

end


for j = 1:numberOfSteps
    %-------------------MOVE----------------------%
    for i=1:numberOfLinks

        biTei = GetDirectGeometry(Q(j,:), geom_model, linkType);
        bTi(:,:,i)= GetTransformationWrtBase(biTei, i);

        T = bTi(:,:,i);
        % x,y and z coordinates for the first joint
        %its drawing a line between 0,0,0 and the final position of the
        %link
        if i == 1

            X(i,1) = 0;
            X(i,2) = T(1,4);

            Y(i,1) = 0;
            Y(i,2) =T(2,4);

            Z(i,1) = 0;
            Z(i,2) =T(3,4);
        % x,y and z coordinates for the remaining joints 
        % previous and the final position of the links
        else
            
            X(i,1) = T_prev(1,4);
            X(i,2) = T(1,4);

            Y(i,1) = T_prev(2,4);
            Y(i,2) = T(2,4);

            Z(i,1) = T_prev(3,4);
            Z(i,2) = T(3,4);
        
        end
        T_prev = T;

    end
    
    plot3(X',Y',Z',LineWidth=2,Marker=".",MarkerSize=10);
    axis equal;grid on; axis([-k-4 k+4 -k-4 k+4 0 k+4]);
    title("Robotic Arm Forward Kinematic")
%   subtitle("from qi=[1.3 1.3 1.3 1.3 1.3 1.3 1.3] to qf=[2 2 2 2 2 2 2]")
%   subtitle("from qi=[1.3, 0, 1.3, 1.7, 1.3, 0.8, 1.3] to qf=[2, 0, 1.3, 1.7, 1.3, 0.8, 1.3]")
%   subtitle("from qi=[1.3, 0, 1.3, 1.7, 1.3, 0.8, 1.3] to qf=[2 2 2 2 2 2 2]")
    subtitle("from qi=[1.3 1.3 1.3 1.3 1.3 1.3 1.3] to qf=[1.3 1.3 1.3 1.3 1.3 2 1.3]")
    xlabel("x")
    ylabel("y")
    zlabel("z")

    drawnow limitrate
    hold on;
end






