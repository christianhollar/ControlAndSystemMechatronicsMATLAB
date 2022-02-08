clear all; close all; clc;

Kt = 0.1;
R = 6;
Vin = 5.564; 
r = 0.01929;

%data = load("Project1Velocity.txt");
%data = load("Project1VelocityTrial2.txt");
data = load("Data3LinV.txt"); Vin = 4.237;
time = data(:,1);
time = time - time(1);
linV = data(:,2);

n = .632 * linV(length(linV));
[val,idx]=min(abs(linV-n));
tau=time(idx);

y_raw = linV;
y_filt(1) = 0;
dT(1)=0;

for k = 2:length(time)
    dy_filt(k-1) = 1/tau*(y_raw(k-1)-y_filt(k-1));
    dT(k)=time(k)-time(k-1);
    y_filt(k) = y_filt(k-1) + dy_filt(k-1)*dT(k);
end

filt_ss = y_filt(length(y_filt/2):length(y_filt));
linV_ss = mean(filt_ss);

% plot(time,linV)
% hold on
% plot(time,y_filt)

b1 = 1.0066e-04;
J = 5.5603e-05;

b2 = (Vin*Kt)/(linV_ss*r*R)-b1/r^2-Kt^2/(R*r^2);

VinMax = 5.3; 
r = 0.01929;

m = 0.264;%+.321;
a1 = (R/Kt)*(J/r+m*r);
a0 = (R/Kt)*(b1/r+Kt^2/(R*r)+b2*r);

tau = a1/a0;

linv_model = linV_ss*(1-exp(-time./tau));

a1 = (R/Kt)*(J/r+m*r);
a0 = (R/Kt)*(b1/r+Kt^2/(R*r)+b2*r);

fun=@(b2,time) linV_ss*(1-exp(-time.*((R/Kt)*(b1/r+Kt^2/(R*r)+b2*r))./((R/Kt)*(J/r+m*r))));
b2 = lsqcurvefit(fun,b2,time,linV)

%
% Update
%

a1 = (R/Kt)*(J/r+m*r);
a0 = (R/Kt)*(b1/r+Kt^2/(R*r)+b2*r);

tau = a1/a0;

linv_model = linV_ss*(1-exp(-time./tau));

figure 
plot(time,linV);
hold on
plot(time,linv_model);

inputTime = 1.2;
d = 0.4;
VinMax=5.2;
voltage = d/((inputTime/a0)+(a1/a0^2)*exp((-a0*inputTime)/a1));
voltageConvert = voltage/VinMax * 400

