clear all; close all; clc;

damping_ratio = 0.1;
omega_n = 25;
omega_d = omega_n * sqrt(1-damping_ratio^2);

sd = -damping_ratio * omega_n + omega_d*i;
sd = -12 +12*i

syms s z
A = 248.5;
A = 1;
G_num = A*(s+z);

a1 = 1;
a0 = 5.882;
a0=8+12;
a = 0;
a = 8*12;
G_den = a1*s^2+a0*s+a;

den_roots = [a1 a0 a];
den_roots = roots(den_roots)


alpha1 = 180-rad2deg(atan(imag(sd)/(den_roots(1)-real(sd))) - atan(imag(sd)/(den_roots(2)-real(sd))))
alpha2 = -180-rad2deg(atan(imag(sd)/(den_roots(1)-real(sd))) - atan(imag(sd)/(den_roots(2)-real(sd))))

alpha = min(abs(alpha1),abs(alpha2))

d = imag(sd)/tan(deg2rad(alpha))

z = d - real(sd)

% PD Controller
s = sd
G_num = A*(s+z);
G_den = a1*s^2+a0*s+a;
G = G_num/G_den

H = 1;

Ksum = 1;

Kd = abs(Ksum)/abs(G*H)

% Manual Version

% num_val = subs(G_num);
% den_val = subs(G_den);

% a=sqrt(vpa(imag(num_val))^2+vpa(real(num_val))^2);
% b=sqrt(vpa(imag(den_val))^2+vpa(real(den_val))^2);

% Kd = 1/(a/b)

Kp = Kd*z

% PI Controller