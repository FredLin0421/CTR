function [ga_path2loop,gb_path2loop]=path2loop(ga,gb,sa,sb,N)

%% 
initial_a= ga(end,:);
initial_b= gb(end,:);
 

d_a = zeros(N,3);
d_b = zeros(N,3);
     
for i = 1:N
     %%% Vector calculations(Magnitude+direction) %%% 
     d_a(i,:) = initial_a + ((sa-initial_a)/norm(initial_a-sa))  * norm(initial_a-sa)* i* 0.1;
     d_b(i,:) = initial_b + ((sb-initial_b)/norm(initial_b-sb))  * norm(initial_b-sb)* i * 0.1;
     
%      scatter3(d_a(i,1),d_a(i,2),d_a(i,3),'r');
%      hold on
%      scatter3(d_b(i,1),d_b(i,2),d_b(i,3),'g');
%      pause(.01);
end

ga_path2loop = d_a;
gb_path2loop = d_b;