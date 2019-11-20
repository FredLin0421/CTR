function [] = drawCTR_tr(tube_nbr, com, tube_geo, diam, K)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% tube_nbr: number of tubes for the CTR. Tube 1 = inner tube
% com: 2 by tube_nbr matrix with line 1 = stroke and line 2 = angle at tube
% base for each tube

% tube_geo: 4 by p by tube_nbr matrix with p maximum number of
% constant-curvature section of one tube. Matrix filled with 0 for tubes
% with less constant-curvature sections. Line 1: section length, line 2, 3
% and 4: x, y and z curvature
% diam: 2 by tube_nbr matrix with line 1 = inner diam and line 2 = outer
% diam for each tube
% K: 3 by 3 by tube_nbr stiffness tensor
% %% tube definition from outer to inner
% tube_nbr = 3;
% % command (stroke(mm), angle(rad))
% com(:,1) = [0; -pi/2];
% com(:,2) = [0; 0];
% com(:,3) = [0; -pi/2];
% % tube definition (portion length (mm), x,y,z curvatures (mm-1))
% tube_geo(:,:,1) = [40;
%     0;
%     0;
%     0];
% tube_geo(:,:,2) = [28.1444;
%     0.136;
%     0;
%     0];
% tube_geo(:,:,3) = [11.8464;
%     0;
%     0;
%     0];
% % diameters (inner, outer)
% diam(:,1) = [0.88; 1.2];
% diam(:,2) = [1.296; 1.524];
% diam(:,3) = [1.76; 2.184];
% 
% E = [80; 80; 80];           % elastic modulus
% G = [30; 30; 30];           % shear modulus
% 
% J = zeros(tube_nbr);        % cross section polar moment of inertia
% for i=1:tube_nbr,   J(i) = pi*(diam(2,i)^4 - diam(1,i)^4)/32; end
% I = zeros(tube_nbr);        % cross section area moment of inertia
% for i=1:tube_nbr,   I(i) = pi*(diam(2,i)^4 - diam(1,i)^4)/64; end
% K = zeros(3,3,tube_nbr);	% stiffness tensor
% for i=1:tube_nbr
%     K(1,1,i) = E(i)*I(i); K(2,2,i) = E(i)*I(i); K(3,3,i) = J(i)*G(i);
% end

%%
% initial homogenious coordinates (base position and orientation)
T = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];

if size(tube_geo,2)>1
    for i=2:size(tube_geo,2)
        tube_geo(1,i,:)=tube_geo(1,i-1,:)+tube_geo(1,i,:);
    end
end

%% initialisation loop
couleurs = fliplr(hsv(tube_nbr));   % creates a panel of tube_nbr colors
tube_flag = ones(1,tube_nbr);       % presence of tube in considered portion
part_index = ones(1,tube_nbr);      % parts of constant curvature considered for current portion
R = zeros(3,3,tube_nbr);            % initialisation of rotation matrix
for i=1:tube_nbr
    j = 1;
    for k=1:size(tube_geo,2)
        tube_geo(1,k,i) = tube_geo(1,k,i) + com(1,i); % include course command in tube definition
        if (tube_geo(1,k,i)<=0)
            j = j+1;
        end
    end
    part_index(i) = j; % find position of first part of each tube in matrix tube
    if (part_index(i)>size(tube_geo,2))
        tube_flag(i) = 0; % tube deleted if fully in negative area
    end
    R(:,:,i) = [cos(com(2,i)) -sin(com(2,i)) 0; sin(com(2,i)) cos(com(2,i)) 0; 0 0 1]; % rotation matrix with angle command
end

%% loop
length_min = 0;
while (any(tube_flag(:)~=0))
    %% tube portion modeling
    length_temp = length_min;
    tube_index_length_min = find(tube_flag,1,'last');
    length_min = tube_geo(1,part_index(tube_index_length_min),tube_index_length_min); % by default, the first part of the first remaining tube
    sum_k = zeros(3,3);
    sum_krt = zeros(3,1);
    % find current limiting length
    for j=find(tube_flag)
        if (tube_geo(1,part_index(j),j)<length_min)
            length_min = tube_geo(1,part_index(j),j);
        end
        sum_k = sum_k + K(:,:,j);
        sum_krt = sum_krt + K(:,:,j)*R(:,:,j)*tube_geo(2:4,part_index(j),j);
    end
    length = length_min - length_temp; % length of considered portion for current loop
    curv = sum_k\sum_krt; % curvature vector
    curv_eq = sqrt(curv(1,1)^2+curv(2,1)^2);
    if (curv_eq==0),                        angle_eq = 0;
    elseif(curv(1,1)==0 && curv(2,1)>0),    angle_eq = pi()/2;
    elseif (curv(1,1)==0 && curv(2,1)<0),   angle_eq = -pi()/2;
    elseif (curv(1,1)<0),                   angle_eq = atan(curv(2,1)/curv(1,1)) + pi();
    else,                                   angle_eq = atan(curv(2,1)/curv(1,1));
    end
    
    %% plot tube portion
    q = linspace(0,2*pi,100);
    % base_i = diam(1,find(tube_flag,1,'last'))/2*[cos(q); sin(q)]; % Base curve is a circle
    base_o = diam(2,find(tube_flag,1,'last'))/2*[cos(q); sin(q)];
    if (curv_eq==0)
        q = linspace(0,length,50);
        path = T(1:3,1:3)*[linspace(0,0,size(q,2)); linspace(0,0,size(q,2)); q] + repmat(T(1:3,4),[1 size(q,2)]); % Trajectory is a straight line
    else
        q = linspace(0,length*curv_eq,50);
        path = T(1:3,1:3)*[cos(angle_eq)*(1-cos(q))/curv_eq; sin(angle_eq)*(1-cos(q))/curv_eq; sin(q)/curv_eq] + repmat(T(1:3,4),[1 size(q,2)]); % Trajectory is an arc
    end
    % draw internal surface of tube
    % [Xi,Yi,Zi]=extrude(base_i,path);
    % surface_i = surf(Xi,Yi,Zi); axis equal;
    % set(surface_i,'FaceColor',couleurs(find(tube_flag,1,'last'),:),'EdgeColor','none');
    % hold on
    % draw external surface of tube
    %R = [0 0 1;0 1 0;-1 0 0];
    %path = R*path;
    [Xo,Yo,Zo]=extrude(base_o,path);
%     surface_o = surf(Xo,Yo,Zo); axis equal;
    %set(surface_o,'FaceColor',couleurs(find(tube_flag,1,'last'),:),'EdgeColor','none');
%      set(surface_o,'FaceColor',couleurs(find(tube_flag,1,'last'),:),'EdgeColor','none');
    hold on
    xlabel('x'); ylabel('y'); zlabel('z'); % axis label
    
    %% matrix of homogenious coordinates
    if (curv_eq==0)
        T = T*[1 0 0 0;
            0 1 0 0;
            0 0 1 length;
            0 0 0 1]; % homogenious coordinates in case of straight portion
    else
        T = T*[cos(angle_eq)^2*(cos(curv_eq*length)-1)+1 sin(angle_eq)*cos(angle_eq)*(cos(curv_eq*length)-1) cos(angle_eq)*sin(curv_eq*length) cos(angle_eq)/curv_eq*(1-cos(curv_eq*length));
            sin(angle_eq)*cos(angle_eq)*(cos(curv_eq*length)-1) cos(angle_eq)^2*(1-cos(curv_eq*length))+cos(curv_eq*length) sin(angle_eq)*sin(curv_eq*length) sin(angle_eq)/curv_eq*(1-cos(curv_eq*length));
            -cos(angle_eq)*sin(curv_eq*length) -sin(angle_eq)*sin(curv_eq*length) cos(curv_eq*length) sin(curv_eq*length)/curv_eq;
            0 0 0 1]; % homogenious coordinates in case of curved portion
    end
    %    show frames
    %    quiver3(T(1,4), T(2,4), T(3,4), T(1,1), T(2,1), T(3,1), 2, 'black')
    %    quiver3(T(1,4), T(2,4), T(3,4), T(1,2), T(2,2), T(3,2), 2, 'black')
    %    quiver3(T(1,4), T(2,4), T(3,4), T(1,3), T(2,3), T(3,3), 2, 'black')
    
    %% prepare for next tube portion
    for j=find(tube_flag)
        if (tube_geo(1,part_index(j),j)==length_min)
            part_index(j) = part_index(j) + 1; % remove stagnation points
        end
        if (part_index(j)>size(tube_geo,2))
            tube_flag(j) = 0; % if end of current limiting tube
        end
    end
    temp = path;
end
end