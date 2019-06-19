%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                      HW #1
%%%                   Problem #1
%%%                 Deniz Ekin Canbay
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;close all;clc
sys=tf([4 0],[1 8.5 12 2])

[y,t] = step(sys);
figure
plot(t, squeeze(y), 'LineWidth',2)
grid
title("Step Response of Z/Y")
grid on
saveas(gcf,'q1_a.png')

figure
pzmap(sys)
grid on
title("Pole-Zero Map of Z/Y")
saveas(gcf,'q1_b.png')
[p,z]=pzmap(sys)

[y2,t2] = impulse(sys);
figure
plot(t2, squeeze(y2), 'LineWidth',2)
grid
title("Impulse Response of Z/Y")
grid on
saveas(gcf,'q1_a2.png')