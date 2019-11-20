function wound_visualization(wound_width,l,dh,gamma)
%% Wound visualization
%l = 15;                  % wound length/2
%dh = .3;
% opt_needle = [ pi 1 27 5/8 9 0; 
%                pi 5 36 1/2 10 0;
%                pi/6 1 15 1/2 7 0;
%                pi/6 5 58 5/8 28 0;
%                5*pi/4 1 26 5/8 1 0;
%                5*pi/4 5 53 1/2 17 0];
                    
% theta = (180-gamma)/2;               
% x1 = [opt_needle(2)/2 l/2 l/2 opt_needle(2)/2];
% y1 = [-l/2 -l/2 l/2 l/2];
% z1 = [opt_needle(2)/2 0 0 opt_needle(2)/2];
% h1 = fill3(x1,y1,z1,[0 0 1]);
% hold on
% h2 = fill3(-x1,-y1,-z1,[0 0 1]);
% 
% x2 = [0 x1(1) x1(4) 0];
% y2 = [y1(1) y1(1) y1(3) y1(3)];
% z2 = [-dh 0 0 -dh];
% h3 = fill3(x2,y2,z2,[1 0 0]);
% h1 = fill3(-x2,-y2,z2,[1 0 0]);
% xlabel('x'); ylabel('y'); zlabel('z');

 theta = (180-gamma)/2;               
%  xr = [wound_width/2 cos(theta)*(l/2) cos(theta)*(l/2) wound_width/2];
 xr = [-l/2 -l/2 l/2 l/2];
%  yr = [-l/2 -l/2 l/2 l/2];
 yr = [wound_width/2 cos(theta)*(l/2) cos(theta)*(l/2) wound_width/2];
 zr = [0 -sin(theta) -sin(theta) 0];
 yl = [-cos(theta)*(l/2) -wound_width/2 -wound_width/2 -cos(theta)*(l/2)];
 xl = [l/2 l/2 -l/2 -l/2];
 zl = [-sin(theta) 0 0 -sin(theta)];
 hr = fill3(xr,yr,zr,[.77 .54 .52]);
 hold on
 hl = fill3(xl,yl,zl,[.77 .54 .52]);
 
%  x2 = [0 xr(1) xr(4) 0];
%  y2 = [yr(1) yr(1) yr(3) yr(3)];
 y2 = [0 yr(1) yr(4) 0];
 x2 = [xr(1) xr(1) xr(3) xr(3)];
 z2 = [-dh 0 0 -dh];
 h3 = fill3(x2,y2,z2,[.77 .54 .52]);
 h1 = fill3(-x2,-y2,z2,[.77 .54 .52]);
 xlabel('x'); ylabel('y'); zlabel('z');
 
 
 
 
 
 
 
 
 