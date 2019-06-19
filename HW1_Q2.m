%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%             Deniz Ekin Canbay
%%%                     HW #1
%%%        Problem #2 Quarter Car Suspension Model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
m1=100; m2=500; b=20; k1=25; k2=12;
A=[0 1 0 0; -(k1+k2)/m1 -b/m1 k2/m1 b/m1;0 0 0 1; k2/m2 b/m2 -k2/m2 -b/m2];
B = [0 k1/m1 0 0]';
C = [1 0 0 0;0 0 1 0];
D=[0 0]';
sys = ss(A,B,C,D)
figure
step(sys)
grid on
title("Step Responses of Quarter Car Model")

[p,z] = pzmap(sys)

figure
pzplot(sys)
grid on
title("Pole Zero Map of Quarter Car Model")

figure
impulse(sys)
grid on
title("Impulse Responses of Quarter Car Model")

%%
num1=[m1*k1 b*k1 k1*(k1+k2)]
den1=[m1*m2 (m1*b+m2*b) (m1*k2+m2*(k1+k2)) b*k1 k1*k2]
tf1=tf(num1,den1)
step(tf1)

clear all
close all
syms m1 m2 b k1 k2 s
%%
Y1U = simplifyFraction(k1/(m1*s*s+k1+k2+b*s - (b*s+k2)*(b*s+k2)/(m2*s*s+k2+b*s))) % Y1/U
%%
Y2Y1=simplifyFraction((b*s+k2)/(m2*s^2+b*s+k2))
%%
Y2U=simplifyFraction(Y2Y1*Y1U)
%%
pretty(Y1U)
pretty(Y2U)
m1=100; m2=500; b=20; k1=25; k2=12;
Y1U=subs(Y1U)
Y2U=subs(Y2U)
%%
[num1, den1] = numden((Y1U))
[num2, den2] = numden((Y2U))
%%
s=tf('s')
eval(['Y1_U = ',char(Y1U)])
eval(['Y2_U = ',char(Y2U)])

figure
step(Y1_U)
title("Step Response of Y1")
grid on
saveas(gcf,'Y1step.png')

figure
impulse(Y1_U)
title("Impulse Response of Y1")
grid on
saveas(gcf,'Y1impulse.png')

figure
step(Y2_U)
title("Step Response of Y2")
grid on
saveas(gcf,'Y2step.png')

figure
impulse(Y2_U)
title("Impulse Response of Y2")
grid on
saveas(gcf,'Y2impulse.png')

[p1,z1]=pzmap(Y1_U)
[p2,z2]=pzmap(Y2_U)

figure
pzmap(Y1_U,'b')
grid on
title("Pole Zero Map of the Y1 / U")
saveas(gcf,'Y1pzmap.png')

figure
pzmap(Y2_U,'b')
grid on
title("Pole Zero Map of the Y2 / U")
saveas(gcf,'Y2pzmap.png')



