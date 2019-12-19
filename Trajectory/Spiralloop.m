 function [ga_spiralloop, gb_spiralloop]...
     = Spiralloop(ga,gb,D,W)
%% Initialization
%D = 1.5;                % Diameter of gripper
%W = 1.7;                % Number of wraps(loops) about gripper B
L1 = pi * D * W;         % Suture length looped on the stationary robot gripper.
L2 = 6;                  % 10 mm, safety distance between two grippers at end of
                         % trajectory.
L3 = L1+L2+20;           % Suture length from suture exit point (on tissue) to
                         % stationary robot gripper.
L = L1 + L2 + L3;
N = 25;                 % Number of trajectory potins
r = zeros(1,N);  
s = 5;                   % Gripper b stationary point while looping
Pa_x = zeros(1,N);       % Coordinates (x,y) of wrapping trajectory.
Pa_y = zeros(1,N);
Pa_z = zeros(1,N);
Pb_x = zeros(1,N)+s;
Pb_y = zeros(1,N);
Pb_z = zeros(1,N);

theta = 0.4;
Oy = ga(2);                 % Coordinates (x,y) of stationary gripper.
Oz = ga(3);
h = 15;                 % looping height
k = 2;                        
%% Trajectory generator
for n= 1:N
    
    r(1) = L1 + L2;
    r(n) = r(1) - 2.5 * pi * W * ( n / N );        % r(n): radius of spiral loop at step n.
    Pa_y(n) = Oy - r(n) * sin(theta*n);    
    Pa_z(n) = Oz + r(n) * cos(theta*n);
%     plot3(0,0,0,'bv')
%     xlabel('x'); ylabel('y'); zlabel('z');  
%     hold on
%     h1=scatter3(Pa_x(n),Pa_y(n),Pa_z(n)+h,'r')
%     h2=scatter3(Pb_x(n),Pb_y(n),Pb_z(n)+h,'g')
%     legend([h1,h2], {'Right gripper', 'Left gripper'});
%     pause(.01);
    
end


%% Trajectory point for spiral loop 

ga_spiralloop = [ Pa_x' (Pa_y+k)' (Pa_z+h)'];
gb_spiralloop = [ Pb_x' Pb_y' (Pb_z+h)']; 










