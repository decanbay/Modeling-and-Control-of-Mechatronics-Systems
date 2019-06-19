%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%               2018-2019 Spring
%%%                     HW #1
%%%                   Problem #3 
%%%             Deniz Ekin Canbay           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; clc; close all;
m=10; c=3; k=5; L1=1; L2=2; L3=2;
num=[k*L1];
den=[m*L3^2 c*L2^2 k*L1^2];
% Get the transfer function
TF_P3 = tf(num,den)
impulse(TF_P3)
grid on
figure
step(TF_P3)
[p,z]=pzmap(TF_P3)
pzmap(TF_P3)
% State Space Form
A=[0 1; (-(k*L1*L1)/(m*L3*L3)) (-(c*L2*L2)/(m*L3*L3)) ]
B=[0;((k*L1)/(m*L3*L3))]
C =[1 0]
D=[0]
sys=ss(A,B,C,D)
figure
[y2,t2] = impulse(sys)
plot(t2, squeeze(y2), 'LineWidth',2)
grid
title("Impulse Response")
grid on
saveas(gcf,'q3_b.png')