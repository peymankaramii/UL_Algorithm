clc;clear;close all;format long g

ss=1000;
all_x = rand(1,ss)*20;
all_y = (abs(1-((all_x-10).^2)/100)*25).^0.5;
m=rand(1,ss);
u1=(m<0.5);
u2=(m>=0.5)*-1;
all_y=all_y.*(u1+u2)+5;
point=[1:ss;all_x;all_y]';
plot(point(:,2),point(:,3),'.') ; axis equal


