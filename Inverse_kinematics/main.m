clc;
clear all;

tic
%% tube definition from outer to inner
tube_nbr = 3;
% command (stroke(mm), angle(rad))
com(:,1) = [0; -pi/2];
com(:,2) = [0; pi/2];
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

E = [80; 80; 80];           % elastic modulus
G = [30; 30; 30];           % shear modulus

J = zeros(tube_nbr);        % cross section polar moment of inertia
for i=1:tube_nbr,   J(i) = pi*(diam(2,i)^4 - diam(1,i)^4)/32; end
I = zeros(tube_nbr);        % cross section area moment of inertia
for i=1:tube_nbr,   I(i) = pi*(diam(2,i)^4 - diam(1,i)^4)/64; end
K = zeros(3,3,tube_nbr);	% stiffness tensor
for i=1:tube_nbr
    K(1,1,i) = E(i)*I(i); K(2,2,i) = E(i)*I(i); K(3,3,i) = J(i)*G(i);
end

computeCTR(tube_nbr, com, tube_geo, diam, K)
toc
camlight('headlight');