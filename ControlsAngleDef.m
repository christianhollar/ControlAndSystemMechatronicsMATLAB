clear all; close all; clc;

syms s z

a = 33.33;

damping_ratio =  0.707;
omega_n =  a/damping_ratio
omega_d =  omega_n* sqrt(1-damping_ratio^2)

damping_ratio_omega_n = damping_ratio*omega_n;

sd = -damping_ratio_omega_n + omega_d*i
sd = sd;

A = 281.82;

G_num = A*(s+z);

a = [0 33.33 1];

G_den = 0;

for k = 1:length(a)
    G_den = G_den + a(k)*s^(k-1);
end

den_roots = roots(flip(a))
den_roots
alpha = zeros(size(den_roots));

G_save = G_num/G_den

for k = 1:length(den_roots)
    alpha(k) = rad2deg(atan2(imag(sd),real(sd)-(den_roots(k))));
end


alpha
sum(alpha)
alpha = (-180+sum(alpha))

d = imag(sd)/tan(deg2rad(alpha))

z = -(real(sd)-d)

% PD/PI Controller

s = sd;
G_num = A*(s+z);
G_den = 0;

for k = 1:length(a)
    G_den = G_den + a(k)*s^(k-1);
end

G = G_num/G_den

Ksum = 1;

Kd = abs(Ksum)/abs(G)
Kp = Kd*z

% PI Controller
Ki = Kp
Kp = Kd

