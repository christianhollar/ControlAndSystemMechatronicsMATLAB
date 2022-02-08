clear all; close all; clc;

data = load("Project1.txt");
data = load("AngVProject1Trial2.txt");
data = load("Data3AngV.txt"); Vin = 4.265;
time = data(:,1);
time = time - time(1);
angv = data(:,2);

n = .632 * angv(length(angv));
[val,idx]=min(abs(angv-n));
tau=time(idx)/2

y_raw = angv;
y_filt(1) = 0;
dT(1)=0;

for k = 2:length(time)
    dy_filt(k-1) = 1/tau*(y_raw(k-1)-y_filt(k-1));
    dT(k)=time(k)-time(k-1);
    y_filt(k) = y_filt(k-1) + dy_filt(k-1)*dT(k);
    
end

filt_ss = y_filt(length(y_filt)/2+0.5:length(y_filt));
angv_ss = mean(filt_ss)

n=.632*angv_ss
[val,idx]=min(abs(y_filt-n));
tau=time(idx)

angv_model = angv_ss*(1-exp(-time./tau));

figure
plot(time,angv,'b')
hold on
plot(time,y_filt,'r')
xlabel('Time (s)');
ylabel('Angular Velocity (rad/s)');
plot(time,angv_model,'k');

%Vin = 5; %5V
%Vin = 4.556; %4.556
R = 6;
Kt=0.05;

b = (Vin*Kt/R)/angv_ss-Kt^2/R

J = tau*(b+Kt^2/R)