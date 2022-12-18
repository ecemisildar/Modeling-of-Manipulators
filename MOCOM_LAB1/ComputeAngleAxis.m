function R = ComputeAngleAxis(theta,v)
%Implement here the Rodrigues formula

h = [0 -v(3) v(2); v(3) 0 -v(1); -v(2) v(1) 0];

R = eye(3) + h*sin(theta) + h.^2*(1-cos(theta));