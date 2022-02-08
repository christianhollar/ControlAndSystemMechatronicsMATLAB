data = load('YAWRateDataProject3.txt');

time = data(:,1);
time = time - time(1);
yaw = -data(:,2);
length(yaw)
index = 1600;

time = time(index:length(time));
yaw = yaw(index:length(yaw));

plot(time,yaw)