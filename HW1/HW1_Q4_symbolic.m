%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                     HW #1
%%%        Problem #4 2R Planar Robotic Manipulator
%%%             Deniz Ekin Canbay
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;close all;clc
syms q1_dd q1_d q2_dd q2_d q1 q2 l1 lc1 l2 lc2 m1 m2 g T1 T2
% l1=lc1*2;
% l2=lc2*2;
I1=m1*l1^2/3;
I2=m2*l2^2/3;
eqn1=q1_dd*(m1*lc1^2 + I1+I2 +m2*(l1^2 +lc2^2)+2*m2*l1*lc2*cos(q2))+...
    q2_dd*(I2+m2*l1*lc2*cos(q2) + m2*lc2^2) - 2*q1_d*q2_d*m2*l1*lc2*sin(q2)...
    -q2_d^2*sin(q2)*m2*l1*lc2+g*cos(q1)*(m1*lc1+m2*l1) + cos(q1+q2)*m2*g*lc2-T1==0;
eqn2=q1_dd*(I2+m2*l1*lc2*cos(q2)+m2*lc2^2)+q2_dd*(I2+m2*lc2^2) + (q1_d^2)*sin(q2)*m2*l1*lc2+m2*g*lc2*cos(q1+q2) -T2==0;

q1_q2=solve([eqn1,eqn2],[q1_dd,q2_dd]);
q1_dd=simplify(q1_q2.q1_dd);
q2_dd=simplify(q1_q2.q2_dd);
simplify(subs(q1_dd,[m1,m2,l1,l2,lc1,lc2,g],[1,1,2,2,1,1,9.81]));

JacA=jacobian([q1_dd,q2_dd],[q1,q2,q1_d,q2_d]);
JacB=jacobian([q1_dd,q2_dd],[T1,T2]);
B=[0 0;0 0;double(simplify(subs(JacB,[m1,m2,l1,l2,lc1,lc2,g,q1,q2],[1,1,2,2,1,1,9.81,-pi/2,0])))];
A=[0 0 1 0;0 0 0 1;double(subs(JacA,[m1,m2,l1,l2,lc1,lc2,g,q1,q2,q1_d,q2_d],[1,1,2,2,1,1,9.81,-pi/2,0,0,0]))];
C=[1 0 0 0;0 1 0 0];
D=0;
sys_2R_Robot=ss(A,B,C,D)
tf(sys_2R_Robot)
[p,z]=pzmap(sys_2R_Robot)
%%
t=0:0.01:10
Resp=initial(sys_2R_Robot,[deg2rad(120),deg2rad(30),0,0],t);
figure
plot(t,rad2deg(Resp(:,1)-pi/2),'r--','LineWidth',2)
hold on
plot(t,rad2deg(Resp(:,2)),'b--','LineWidth',2)
grid 
xlabel('Time[s]')
ylabel('Angle[degrees]')
legend('Q_1','Q_2')
saveas(gcf,'HW1_Q4_thetas.png')

x1=cos(Resp(:,1)-pi/2);
y1=sin(Resp(:,1)-pi/2);
x2=x1+cos(Resp(:,1)+Resp(:,2)-pi/2);
y2=y1+sin(Resp(:,1)+Resp(:,2)-pi/2);
%%      Be careful before running this section it may take a little long
figure
for i=1:length(Resp)
clf
xlim([-2 2])
ylim([-2 2])
line([0,x1(i)],[0,y1(i)],'Color','r','Linewidth',8)
hold on
plot([0,x1(i)],[0,y1(i)],'r*')
hold on
line([x1(i),x2(i)],[y1(i),y2(i)],'Color','b','Linewidth',8)
hold on
plot([x1(i),x2(i)],[y1(i),y2(i)],'bo')
pause(0.01)
end
figure
tmp=1;
sgtitle('Linearized 2-R Planar Manipulator Motion')
for i=0:11
subplot(3,4,i+1)
i=i*40+1;
line([0,x1(i)],[0,y1(i)],'Color','r','Linewidth',4)
hold on
line([x1(i),x2(i)],[y1(i),y2(i)],'Color','b','Linewidth',4)
plot(0,0,'ro')
hold on
plot(x1(tmp:i),y1(tmp:i),'r--')
hold on
plot(x2(tmp:i),y2(tmp:i),'b--')
pbaspect([1 1 1])
xlabel(['t=',num2str(t(i))])
xlim([-2 2])
ylim([-2 2])
grid
tmp=i;
end
saveas(gcf,'HW1_Q4_simulation.png')
