function [ga_needle,gb_needle] = Needle_path(opt_needle)
%Initialization

%The diameter of the needle curvature
dia_needle = opt_needle(3)/2;
%The assumed depth of the needle 
dep_needle = dia_needle./3;
% dia_gripper = 9;
h=-15;

%Center of rotation
c_rotat = (dia_needle/2)-(dep_needle);
%we take into account the z-axis and the x-axis for the circle we want to
%Angle it starts from 
ang_start = (pi/2)- asin(c_rotat/dia_needle);
ang_swept = pi-ang_start;
ang= (3.14159 -ang_swept)/2;%this makes sure that the angle of the start and the end point is perpendicular to the surface
%Number of points required
theta = linspace (0 +ang, ang_swept+ang, 50);
%since the center of the circle is (0,0,6)

for k= 1:length(theta)
    a = theta(k);
    x(k) = -(dia_needle*cos(a));
    y(k) = 0;
    z(k) = (dia_needle*sin(a))+ c_rotat-(dia_needle-dep_needle);
end

%plot3(x,y,z)

%for returning back

for q = 1:length (theta)
    x1(q)= x(k -(q-1));
    y1(q) = 0;
    z1(q) = z(k -(q-1));
end

%for the final position
for r= 1:25
    a = theta(k);
    x2(r) = x(r);
    y2(r) = 0;
    z2(r) = z(r);
end

ga_needle = [ x' y' z';x1' y1' z1';x2' y2' z2'];
[m,n]=size(ga_needle);
gb_needle = zeros(m,n);
gb_needle(:,2)=gb_needle(end,2)+h;


