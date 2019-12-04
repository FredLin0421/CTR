clc;
clear all;

%% tube definition from outer to inner
link_nbr = 4;
% command (stroke(mm), angle(rad))
diam = [2.184; 2.184; 1.524; 1.2];  % outer diameter of section 1 to 4
l = [15.26815916;24.23327281;1.12428232; 16.58561056];                   % length of section 1 to 4
psi2 = 0.16514868;

kappa2 = 1.0079047;
kb1 =1.00186171;
kb2 =  1.00478747;
kb3 =  17.8372724;
curv3 = (kappa2*kb2)/(kb1 + kb2 + kb3);
curv2 = (kappa2*kb2)/(kb1 + kb2);
gamma = [0; curv3; curv2; 0];             % curvature of section 1 to 4


T = [cos(psi2) -sin(psi2) 0 0;
       sin(psi2) cos(psi2) 0 0;
       0 0 1 0;
       0 0 0 1];
%T = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1]; % intial transformation matrix

couleurs = fliplr(hsv(link_nbr));   % creates a panel of tube_nbr colors

for i=1:link_nbr
    angle_eq = 0;
    %% plot tube portion
    q = linspace(0,2*pi,100);
    % base_i = diam(1,find(tube_flag,1,'last'))/2*[cos(q); sin(q)]; % Base curve is a circle
    base_o = diam(i)/2*[cos(q); sin(q)];
    if (gamma(i)==0)
        q = linspace(0,l(i),50);
        path = T(1:3,1:3)*[linspace(0,0,size(q,2)); linspace(0,0,size(q,2)); q] + repmat(T(1:3,4),[1 size(q,2)]); % Trajectory is a straight line
    else
        q = linspace(0,l(i)*gamma(i),50);
        path = T(1:3,1:3)*[cos(angle_eq)*(1-cos(q))/gamma(i); sin(angle_eq)*(1-cos(q))/gamma(i); sin(q)/gamma(i)] + repmat(T(1:3,4),[1 size(q,2)]); % Trajectory is an arc
    end
    % draw external surface of tube
    [Xo,Yo,Zo]=extrude(base_o,path);
    surface_o = surf(Xo,Yo,Zo); axis equal;
    set(surface_o,'FaceColor',couleurs(i,:),'EdgeColor','none');
    hold on
    xlabel('x'); ylabel('y'); zlabel('z'); % axis label
    
    %% matrix of homogenious coordinates
    if (gamma(i)==0)
        T = T*[1 0 0 0;
            0 1 0 0;
            0 0 1 l(i);
            0 0 0 1]; % homogenious coordinates in case of straight portion
    else
        T = T*[cos(angle_eq)^2*(cos(gamma(i)*l(i))-1)+1 sin(angle_eq)*cos(angle_eq)*(cos(gamma(i)*l(i))-1) cos(angle_eq)*sin(gamma(i)*l(i)) cos(angle_eq)/gamma(i)*(1-cos(gamma(i)*l(i)));
            sin(angle_eq)*cos(angle_eq)*(cos(gamma(i)*l(i))-1) cos(angle_eq)^2*(1-cos(gamma(i)*l(i)))+cos(gamma(i)*l(i)) sin(angle_eq)*sin(gamma(i)*l(i)) sin(angle_eq)/gamma(i)*(1-cos(gamma(i)*l(i)));
            -cos(angle_eq)*sin(gamma(i)*l(i)) -sin(angle_eq)*sin(gamma(i)*l(i)) cos(gamma(i)*l(i)) sin(gamma(i)*l(i))/gamma(i);
            0 0 0 1]; % homogenious coordinates in case of curved portion
    end
end