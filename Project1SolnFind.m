close all; clear all; clc;

%
% Christian Hollar 
% Project 1 - ME480 - Section 5
%

% Inputs
inputm = 0;
inputTime = 2;
goal = 0.5;

% Variables
VinMax = 5.3; 
R = 6;
Kt = 0.05;
r = 0.01929;

b1 =  2.9429e-04;
b2 = 2.1741/2;
J = 2.8438e-05;
m = inputm + 0.264; 

DT = 0.001;
time = 0:DT:5;

a1 = (R/Kt)*(J/r+m*r);
a0 = (R/Kt)*(b1/r+Kt^2/(R*r)+b2*r);

tau = a1/a0;

Vin = 0;

voltageGoal = 0;

x = 0

while x<goal
    
    Vin = Vin + 0.001;
    U = Vin;
    x = (U*inputTime/a0)+(U*a1)/(a0^2)*exp(-a0*inputTime/a1)
    
    if(x>goal)
       voltageGoal = U;
    end
    
end
d=0.5
voltage = d/((inputTime/a0)+(a1/a0^2)*exp((-a0*inputTime)/a1))
U
voltageConvert = U/VinMax * 400
