function [ga_knottying, gb_knottying]=knot_tying(ga_knottying,gb_knottying,fa,fb,N)

%% Knot Tying
 initial_a= ga_knottying(end,:);
 initial_b= gb_knottying(end,:);
 

 d_a = zeros(N,3);
 d_b = zeros(N,3);
     

for i = 1:N
     %%% Vector calculations(Magnitude+direction) %%% 
     d_a(i,:) = initial_a + ((fa-initial_a)/norm(initial_a-fa))  * norm(initial_a-fa)* i* 0.1;
     d_b(i,:) = initial_b + ((fb-initial_b)/norm(initial_b-fb))  * norm(initial_b-fb)* i * 0.1;
     
%      h1=scatter3(d_a(i,1),d_a(i,2),d_a(i,3),'r');
%      hold on
%      h2=scatter3(d_b(i,1),d_b(i,2),d_b(i,3),'g');
%      legend([h1,h2], {'Right gripper', 'Left gripper'});
%      pause(.1);
 end
 
 ga_knottying = d_a;
 gb_knottying = d_b;











