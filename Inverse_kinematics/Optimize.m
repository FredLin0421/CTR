clc;
clear all;


  %% matrix of homogenious coordinates
   if (curv_eq==0),                        angle_eq = 0;
    elseif(curv(1,1)==0 && curv(2,1)>0),    angle_eq = pi()/2;
    elseif (curv(1,1)==0 && curv(2,1)<0),   angle_eq = -pi()/2;
    elseif (curv(1,1)<0),                   angle_eq = atan(curv(2,1)/curv(1,1)) + pi();
    else,                                   angle_eq = atan(curv(2,1)/curv(1,1));
   end
    
    if (curv_eq==0)
        T = T*[1 0 0 0;
            0 1 0 0;
            0 0 1 length;
            0 0 0 1]; % homogenious coordinates in case of straight portion
    else
        T = T*[cos(angle_eq)^2*(cos(curv_eq*length)-1)+1 sin(angle_eq)*cos(angle_eq)*(cos(curv_eq*length)-1) cos(angle_eq)*sin(curv_eq*length) cos(angle_eq)/curv_eq*(1-cos(curv_eq*length));
            sin(angle_eq)*cos(angle_eq)*(cos(curv_eq*length)-1) cos(angle_eq)^2*(1-cos(curv_eq*length))+cos(curv_eq*length) sin(angle_eq)*sin(curv_eq*length) sin(angle_eq)/curv_eq*(1-cos(curv_eq*length));
            -cos(angle_eq)*sin(curv_eq*length) -sin(angle_eq)*sin(curv_eq*length) cos(curv_eq*length) sin(curv_eq*length)/curv_eq;
            0 0 0 1]; % homogenious coordinates in case of curved portion
    end
  %%
    
tube_nbr = 3;

kb = sym('kb', [1 tube_nbr], 'real');           % bending stiffness for tube 1 to n
kappa = sym('kappa', [1 tube_nbr], 'real');     % tube curvature for tube 1 to n
length = sym('length',[1 tube_nbr+1],'real');
angle_eq = sym('angle_eq',[1 tube_nbr+1],'real');

% each row represents a section for the robot
tube_flag = [1 1 1 1;   % tube 1
             1 1 1 0;   % tube 2
             1 1 0 0];  % tube 3
   
tube_curv = [0 0 0 0;
             0 kappa(2) kappa(2) 0;
            0 0 0 0];
%  tube_curv = [kappa(1) kappa(1) kappa(1) kappa(1);
%              0 kappa(2) kappa(2) 0;
%              kappa(3) kappa(3) 0 0];
curv_eq = sym(zeros(size(tube_flag,2),1));
for i=1:size(tube_flag,2)
    curv_eq(i) = 1/sum(kb.*tube_flag(:,i)') * sum(kb.*tube_curv(:,i)'.*tube_flag(:,i)');
end
%%
syms l22
angle_eq = 0 
length(2) = l22-length(3);
curv_eq(1) = 0;




    T1= [1 0 0 0;
            0 1 0 0;
            0 0 1 length(4); 
            0 0 0 1];
   T2= [cos(angle_eq)^2*(cos(curv_eq(2)*length(3))-1)+1 sin(angle_eq)*cos(angle_eq)*(cos(curv_eq(2)*length(3))-1) cos(angle_eq)*sin(curv_eq(2)*length(3)) cos(angle_eq)/curv_eq(2)*(1-cos(curv_eq(2)*length(3)));
            sin(angle_eq)*cos(angle_eq)*(cos(curv_eq(2)*length(3))-1) cos(angle_eq)^2*(1-cos(curv_eq(2)*length(3)))+cos(curv_eq(2)*length(3)) sin(angle_eq)*sin(curv_eq(2)*length(3)) sin(angle_eq)/curv_eq(2)*(1-cos(curv_eq(2)*length(3)));
            -cos(angle_eq)*sin(curv_eq(2)*length(3)) -sin(angle_eq)*sin(curv_eq(2)*length(3)) cos(curv_eq(2)*length(3)) sin(curv_eq(2)*length(3))/curv_eq(2);
            0 0 0 1];
   T3 = [cos(angle_eq)^2*(cos(curv_eq(3)*length(2))-1)+1 sin(angle_eq)*cos(angle_eq)*(cos(curv_eq(3)*length(2))-1) cos(angle_eq)*sin(curv_eq(3)*length(2)) cos(angle_eq)/curv_eq(3)*(1-cos(curv_eq(3)*length(2)));
            sin(angle_eq)*cos(angle_eq)*(cos(curv_eq(3)*length(2))-1) cos(angle_eq)^2*(1-cos(curv_eq(3)*length(2)))+cos(curv_eq(3)*length(2)) sin(angle_eq)*sin(curv_eq(3)*length(2)) sin(angle_eq)/curv_eq(3)*(1-cos(curv_eq(3)*length(2)));
            -cos(angle_eq)*sin(curv_eq(3)*length(2)) -sin(angle_eq)*sin(curv_eq(3)*length(2)) cos(curv_eq(3)*length(2)) sin(curv_eq(3)*length(2))/curv_eq(3);
            0 0 0 1];
   T4 = [1 0 0 0;
            0 1 0 0;
            0 0 1 length(1);
            0 0 0 1];
        
  Tend=T1*T2*T3*T4
  Tend(1:3,4)

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        