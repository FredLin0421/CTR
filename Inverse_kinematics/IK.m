clc;
clear all;
load('path.mat');
Pa = Pa';
Pa(3,:) = 40-Pa(3,:);
Pb = Pb';
%%
% x = 30;
% z = 24;
% r=1/0.136;
% syms theta l3
% % eqn = x*cos(theta)-r*cos(theta)+r*cos(theta)^2-sin(theta)*z+l3*sin(theta)+r*sin(theta)^2 == 0;
% eqn = z-r*sin(theta)- (x-r+r*cos(theta))/sin(theta) * cos(theta) == 1;
% S = solve(eqn,theta,'Real',true)


%%
tic
%%
z=80;
y = 1
x=80-8.975;
p_d = [x;y;z];
r=1/0.136;
% theta = linspace(1,360,720);
joint_value = [];
%for i=1:5
    for l3=30:.1:40
        syms theta
        eqn = z-r*sin(theta)-(x-r+r*cos(theta))/sin(theta) * cos(theta) == l3;
        S = solve(eqn,theta,'Real',true);
%         theta = sym2cell(S);
        theta = double(S(:));
        d = size(theta);
        if d(1) ~= 0
            if theta(1) > 0
                theta = theta(1);
            elseif d(1) ~= 1
                if theta(2) > 0
                theta = theta(2);
                else
                    theta = theta(1);
                end
            end
        else
            continue
        end
        theta = theta * 180 / pi
        l1 = (x-r+r*cos(theta))/sin(theta);
%         l3 = z-r*sin(theta)- l1 * cos(theta);
        l2 = r * theta * pi / 180;
        p_t = [r-r*cos(theta)+l1*sin(theta);0;l3+r*sin(theta)+l1*cos(theta)];
        err = norm(p_d-p_t)
        if   abs(err)<=5 && l1>0 && l2>0
            ref = [1;0];
            tar = [x,y];
            theta2 = acosd(dot(ref,tar)/(norm(ref)+norm(tar)));
            joint_value = [joint_value [l1;l2;l3]];
        end
    end
%end
%% tube definition from outer to inner
tube_nbr = 3;
% command (stroke(mm), angle(rad))
com(:,1) = [0; -pi/2];
com(:,2) = [0; 0];
com(:,3) = [0; -pi/2];
% tube definition (portion length (mm), x,y,z curvatures (mm-1))
tube_geo(:,:,1) = [48;
    0;
    0;
    0];
tube_geo(:,:,2) = [31.6;
    0.136;
    0;
    0];
tube_geo(:,:,3) = [17.3;
    0;
    0;
    0];
% diameters (inner, outer)
diam(:,1) = [0.88; 1.2];
diam(:,2) = [1.296; 1.524];
diam(:,3) = [1.76; 2.184];

% E = [10; 100; 280];           % elastic modulus
E = [10; 100; 280];           % elastic modulus
G = [30; 30; 30];           % shear modulus

J = zeros(tube_nbr);        % cross section polar moment of inertia
for i=1:tube_nbr,   J(i) = pi*(diam(2,i)^4 - diam(1,i)^4)/32; end
I = zeros(tube_nbr);        % cross section area moment of inertia
for i=1:tube_nbr,   I(i) = pi*(diam(2,i)^4 - diam(1,i)^4)/64; end
K = zeros(3,3,tube_nbr);	% stiffness tensor
for i=1:tube_nbr
    K(1,1,i) = E(i)*I(i); K(2,2,i) = E(i)*I(i); K(3,3,i) = J(i)*G(i);
end
% computeCTR(tube_nbr, com, tube_geo, diam, K)
[a,b] = size(joint_value);
figure,
for i=1:b
    tube_geo(:,:,1) = [joint_value(1,i)+joint_value(2,i)+joint_value(3,i);
    0;
    0;
    0];
    tube_geo(:,:,2) = [joint_value(2,i)+joint_value(3,i);
    0.136;
    0;
    0];
    tube_geo(:,:,3) = [joint_value(3,i);
    0;
    0;
    0];
    computeCTR(tube_nbr, com, tube_geo, diam, K)
    
  
end
toc
camlight('headlight');
%%
scatter3(p_d(3),p_d(2),80-p_d(1))


        
    






