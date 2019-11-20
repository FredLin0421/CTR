function [ga_grasping,gb_grasping]=grasping_tail(ga,gb,tail,N)
%% grasping the tail

initial_a = ga(end,:);
initial_b = gb(end,:);
d_a = zeros(N,3);
d_b = zeros(N,3);




% Vector 
% d_a = initial_a + ((tail-initial_b)/norm(initial_b-tail))  * norm(initial_b-tail)/2; 
% d_b = initial_b + ((tail-initial_b)/norm(initial_b-tail))  * norm(initial_b-tail);

% Interpolation
% xb = [ initial_b(1) d_b(1)];
% zb = [ initial_b(3) d_b(3)];
% [pb,Sb] = polyfit(xb,zb,1);
% 
% xa = [ initial_a(1) d_a(1) ];
% za = [ initial_a(3) d_a(2)];
% [pa,Sa] = polyfit(xa,za,1);

% path = [linspace(initial_b(1),d_b(1),N);...
%         linspace(initial_a(1),d_a(1),N)];
% for i = 1:N
%     
%     x1(i) = path(1,i);
%     x2(i) = path(2,i);
%     z1(i) = polyval(pb,path(1,i));
%     z2(i) = polyval(pa,path(2,i));
%     scatter3(x1(i),y1(i),z1(i),'g');
%     hold on
%     scatter3(x2(i),y2(i),z2(i),'r');   
%     pause(.01);
% end

%  path = [linspace(initial_b(1),d_b(1),N);...
%          linspace(initial_a(1),d_a(1),N)];
 for i = 1:N
     %%% Vector calculations(Magnitude+direction) %%% 
     d_a(i,:) = initial_a + ((tail-initial_b)/norm(initial_b-tail))  * norm(initial_b-tail)* i* 0.1/2;
     d_b(i,:) = initial_b + ((tail-initial_b)/norm(initial_b-tail))  * norm(initial_b-tail)* i * 0.1;
     
%      h1=scatter3(d_a(i,1),d_a(i,2),d_a(i,3),'r');
%      hold on
%      h2=scatter3(d_b(i,1),d_b(i,2),d_b(i,3),'g');
%      legend([h1,h2], {'Right gripper', 'Left gripper'});
%      pause(.05);
 end
ga_grasping = d_a;
gb_grasping = d_b;









