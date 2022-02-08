clear all; close all; clc;

syms K
a = -23;
b = 0;
c = 790+K;

w_c = (-b+sqrt(b^2-4*a*c))/(2*a)

eqn = w_c^4-312*w_c^2+500+20*K == 0

vpa(solve(eqn,K))

w_c = (-b-sqrt(b^2-4*a*c))/(2*a);

eqn = w_c^4-312*w_c^2+500+20*K == 0;

vpa(solve(eqn,K))

% -5807.1929053978141016867529674716
% 823.19290539781410168675296747161