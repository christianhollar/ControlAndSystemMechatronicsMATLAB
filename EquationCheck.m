data = load("Project1VelocityTrial2.txt");
time = data(:,1);
time = time - time(1);
linV = data(:,2)

plot(time,linV)

VinMax = 5.3; 
R = 6;
Kt = 0.05;
r = 0.01929;

b1 =  2.9429e-04;
b2 = 2.1741/2;
J = 2.8438e-05;
m = inputm + 0.264; 

a1 = (R/Kt)*(J/r+m*r);
a0 = (R/Kt)*(b1/r+Kt^2/(R*r)+b2*r);

tau = a1/a0;

linv_model = linv_ss*(1-exp(-time./tau));

figure 
plot(time,linV);
hold on
plot(time,linv_model);

%fun=@(b2,time) linv_ss*(1-exp(-time./tau))
fun=@(b2,time) linv_ss*(1-exp(-time.*((R/Kt)*(b1/r+Kt^2/(R*r)+b2*r))./((R/Kt)*(J/r+m*r))));
b2 = lsqcurvefit(fun,b2,time,linV)