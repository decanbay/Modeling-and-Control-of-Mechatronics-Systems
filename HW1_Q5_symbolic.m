%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%               2018-2019 Spring
%%%                     HW #1
%%%             Problem #5 Segway Model
%%%             Deniz Ekin Canbay
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;close all; clc
syms J1 J2 M m al th al_d th_d al_dd th_dd l a g u k1 k2 k3 k4
k1=J1+(M+m)*a^2;
k2=J2+m*l^2;
k3=m*a*l;
k4=m*g*l;

eqn1=((M+m)*a^2 +J1)*al_dd +m*l*a*(th_dd*cos(th)-sin(th)*th_d^2)-u==0
eqn2=(m*l^2 +J2)*th_dd+m*l*a*al_dd*cos(th)-m*g*l*sin(th)+u==0;

ALPHA_THETA=solve([eqn1,eqn2],[al_dd,th_dd])
al_dd=simplify(ALPHA_THETA.al_dd)
th_dd=simplify(ALPHA_THETA.th_dd)


JacA=jacobian([al_dd,th_dd],[al,th,al_d,th_d]);
JacB=jacobian([al_dd,th_dd],u);

B=[0; 0;double(simplify(subs(JacB,[J1,J2,a,l,m,M,g,u,th],[1,1,1,1,1,1,9.81,0,deg2rad(180)])))]
A=[0 0 1 0;0 0 0 1;double(subs(JacA,[J1,J2,a,l,m,M,g,u,th,th_d],[1,1,1,1,1,1,9.81,0,deg2rad(180),0]))]
C=[1 0 0 0;0 1 0 0];
D=0;
sys_Segway=ss(A,B,C,D)
impulse(sys_Segway)

%%
t=0:0.01:5
Resp=initial(sys_Segway,[deg2rad(10),deg2rad(-170),0,0],t);
figure
plot(t,rad2deg(Resp(:,1)),'r--','LineWidth',2)
hold on
plot(t,rad2deg(Resp(:,2))+180,'b--','LineWidth',2)
grid 
xlabel('Time[s]')
ylabel('Angle[degrees]')
legend('\alpha','\theta')
saveas(gcf,'HW1_Q5_al_th.png')
%% Transfer Functions Poles and Zeros
segway_tf=tf(sys_Segway)
[p,z]=pzmap(sys_Segway)
