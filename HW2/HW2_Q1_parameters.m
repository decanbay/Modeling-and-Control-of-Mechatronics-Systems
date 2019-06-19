%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                     HW #2
%%%                   Problem #1
%%%             Model Parameters For Simulink
%%%                 Deniz Ekin Canbay
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; clc; close all;
zd=1;
ks=10;
wn=(6.7715*2);
M=ks/wn^2; %kg
zeta = 1;
R=10;
B=0.1;
A=0.1; %meter
wd=ks/(zeta*2*sqrt(ks*M)- B- R*A*A); % s/wd coeff for Derivative gain
m=2
k1=8; b1=16
FL=1;
h=1; % DC gain of the sensor (volt/in) 
c=1; % gain of the input signal
s=tf("s");
G=4*s/(s*s*s+8.5*s*s+12*s+2)
Y = ((s/wd + 1)*c*zd/h-FL/ks) / (M*s*s/ks + ((B+R*A*A)/ks + 1/wd)*s +1+(m*s*s+b1*s+k1)/G/ks);
Z=Y*4*s/(s*s*s +8.5*s*s+12*s+2);
figure
step(4*s/(s*s*s +8.5*s*s+12*s+2),'b')
hold on
step(Z,'r')
figure
step(Y)
step(((s/wd + 1)*c*zd/h-FL/ks) / (M*s*s/ks + ((B+R*A*A)/ks + 1/wd)*s +1))
[p,z]=pzmap(Y)