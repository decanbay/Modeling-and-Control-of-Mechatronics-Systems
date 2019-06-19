syms q1 q2 theta
lin_sin = @(theta,theta0) sind(theta0) + cosd(theta0)*(theta-deg2rad(theta0))
lin_cos = @(theta,theta0) cosd(theta0) -sind(theta0)*(theta-deg2rad(theta0))
q0=30
lin2  = sind(q0) + cosd(q0)*(q1-deg2rad(q0));
%%
% x1=q1 x2 =q2 x3=q1.  x4 = q2. 
syms x1 x2 x3 x4
m1=1; m2=1; L1=2; L2=2; Lc1=1; Lc2=1; I1 = m1*L1^2/3; I2=I1;
g=9.807;
d11=m1*Lc1^2 + m2*(L1^2 + Lc2^2 + 2*L1*Lc2*cos(x2))+I1+I2
d12=m2*(Lc2^2 + L1*Lc2*cos(x2)) + I2
d21=d12;
d22 = m2*Lc2^2 + I2

M= [d11,d12;d21,d22]
c=m2*Lc2^2 + I2
C11 = c*x4
C12= c*x4 + c*x3
C21=-c*x3
C22=0;
C=[C11,C12;C21,C22]
C*[x3 x4]'
g1 = (m1*Lc1 + m2*L1)*g*cos(x1) + m2*Lc2*g*cos(x1+x2)
g2 = m2*Lc2*g*cos(x1+x2)

