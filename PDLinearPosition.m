%Yaw

syms s z

a = 20;

damping_ratio_omega_n = a;

omega_n = 10;
damping_ratio = 0.707;

omega_d = omega_n*sqrt(1-damping_ratio^2);

sd = -damping_ratio_omega_n + omega_d*i
sd = sd + 9
A = 180.85;
G_num = A*(s+z);

a = [0 20 1];

G_den = 0;

for k = 1:length(a)
    G_den = G_den + a(k)*s^(k-1);
end

den_roots = roots(flip(a));

alpha = zeros(size(den_roots));

for k = 1:length(den_roots)
    alpha(k) = rad2deg(atan2(imag(sd),real(sd)-(den_roots(k))));
end

alpha = -180+abs(sum(alpha))

d = imag(sd)/tan(deg2rad(alpha))

z = -(real(sd)-d)

% PD Controller

s = sd;
G_num = A*(s+z);
G_den = 0;

for k = 1:length(a)
    G_den = G_den + a(k)*s^(k-1);
end

G = G_num/G_den

H = 1;

Ksum = 1;

Kd = abs(Ksum)/abs(G*H)
Kp = Kd*z