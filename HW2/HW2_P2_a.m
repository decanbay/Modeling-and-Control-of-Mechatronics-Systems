%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                     HW #2
%%%        Problem #2 Quarter Car Suspension Model
%%%                 Deniz Ekin Canbay
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Part a
clear all;close all;clc
syms m_1 m_2 b k_1 k_2 Y_1 Y_2 s F U
k_1=25; k_2=12; m_1=100; m_2=500; b=20;

eqn1=(s^2*m_1+b*s+k_1+k_2)*Y_1 -(b*s+k_2)*Y_2 - k_1*U+F==0
eqn2=(s^2*m_2+b*s+k_2)*Y_2 - (b*s+k_2)*Y_1 -F==0

Y1Y2=solve([eqn1,eqn2],[Y_1,Y_2])
Y_1=simplify(Y1Y2.Y_1)
Y_2=simplify(Y1Y2.Y_2)

pretty(simplify(subs(Y_1/F,U,0)))
pretty(simplify(subs(Y_2/F,U,0)))
pretty(simplify(subs(Y_1/U,F,0)))
pretty(simplify(subs(Y_2/U,F,0)))

pretty(simplify(subs(Y_2/F,U,0)*4*s/(0.0004*s^2+0.008*s+1)))

%% Part b
clear all;close all;clc
k_1=25; k_2=12; m_1=100; m_2=500; b=20;

A=[0 1 0 0;-(k_1+k_2)/m_1 -b/m_1 k_2/m_1 b/m_1;0 0 0 1;k_2/m_2 b/m_2 -k_2/m_2 -b/m_2];
B=[0 0;k_1/m_1 -1/m_1;0 0;0 1/m_2];
C=[1 0 0 0;0 0 1 0];
D=0
car_susp=ss(A,B,C,D)
tf(car_susp)
step(car_susp)
figure
impulse(car_susp)