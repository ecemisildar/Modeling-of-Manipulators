function [theta,v] = ComputeInverseAngleAxis(R)
%EULER REPRESENTATION: Given a tensor rotation matrices this function
% should output the equivalent angle-axis representation values,
% respectively 'theta' (angle), 'v' (axis) 
% SUGGESTED FUNCTIONS
    % size() +
    % eye() +
    % eig() +
    % find()
    % abs()
    % det() +
    % NB: Enter a square, 3x3 proper-orthogonal matrix to calculate its angle
    % and axis of rotation. Error messages must be displayed if the matrix
    % does not satisfy the rotation matrix criteria.
    % Check matrix R to see if its size is 3x3
    if size(R) == [3,3]
        % Check matrix R to see if it is orthogonal 
        if R' - R^-1 < 1e-4
            % Check matrix R to see if it is proper: det(R) = 1
            if abs(det(R)) - 1 < 1e-4
                % Compute the angle of rotation 
                %rot_rad = atan2();
                euler_vector = rotm2eul(R);
                theta = norm(euler_vector);
                %theta = rad2deg(theta1);
%                 v = (euler_vector/theta);
                % Calculate eigenvalues and eigenvectors of R
                [x,d] = eig(R);         
                % Compute the axis of rotation
                for i= 1:3
                    if isreal(x(:,i))
                       v = d(:,i);
                    end
                end
            else
               err('DETERMINANT OF THE INPUT MATRIX IS 0')
            end
        else
           err('NOT ORTHOGONAL INPUT MATRIX')
        end
    else
       err('WRONG SIZE OF THE INPUT MATRIX')
    end

end

