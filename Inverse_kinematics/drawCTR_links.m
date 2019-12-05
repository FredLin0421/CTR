clc;
clear all;

%% tube definition from outer to inner
link_nbr = 4;
% command (stroke(mm), angle(rad))
diam = [2.184; 2.184; 1.524; 1.2];  % outer diameter of section 1 to 4
%%
Length1 = [ 1.15253386  1.07612094 42.91521194  6.67349813 35.68288201 18.6322818...
  1.02549054 12.75548719 30.16100144 26.56833513];
Length2 = [2.42754769e+01 2.68261980e-02 8.66589000e+00 3.40460558e+01...
 6.48585812e-03 1.47537074e+01 2.46072744e+01 3.99161078e-01...
 6.59764298e+00 6.79149465e+00];
Length3 = [52.44475674 68.25135741 24.01243534  1.0939399  47.66036807 34.19589988...
 61.52835028 72.24201854 32.08232315 43.39084922];
Length4 = [13.11716499 14.74626406 10.01140013 48.12263183  1.00028616 20.22188509...
  6.60007905  1.82624281 15.5626817   9.56151557];
kappa2 =  0.0507077;
kb1 =  3.94359409;
kb2 =  6.54065841;
kb3 =  27.77643823;
l22 =  [76.72023365 68.2781836  32.67832534 35.13999573 47.66685393 48.94960723...
 86.1356247  72.64117961 38.67996613 50.18234387];
psi2 =  [5.48398489e+07 1.48889948e-01 6.14135512e+06 4.15670673e+05...
 1.36732043e+07 3.14667076e+07 2.51689972e-01 3.43023940e-01...
 1.98975457e-29 3.21104702e+06];


%%
% l = [15.26815916;24.23327281;1.12428232; 16.58561056];                   % length of section 1 to 4
% psi2 = 0.16514868;
% 
% kappa2 = 1.0079047;
% kb1 =1.00186171;
% kb2 =  1.00478747;
% kb3 =  17.8372724;
curv3 = (kappa2*kb2)/(kb1 + kb2 + kb3);
curv2 = (kappa2*kb2)/(kb1 + kb2);
gamma = [0; curv3; curv2; 0];             % curvature of section 1 to 4


% T = [cos(psi2) -sin(psi2) 0 0;
%        sin(psi2) cos(psi2) 0 0;
%        0 0 1 0;
%        0 0 0 1];
%T = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1]; % intial transformation matrix

couleurs = fliplr(hsv(link_nbr));   % creates a panel of tube_nbr colors

 for p=1:size(Length3,2)
    l = [Length4(p) Length3(p) Length2(p) Length1(p)];
    T = [cos(psi2(p)) -sin(psi2(p)) 0 0;
       sin(psi2(p)) cos(psi2(p)) 0 0;
       0 0 1 0;
       0 0 0 1];
   
    
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
 end