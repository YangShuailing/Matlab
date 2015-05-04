clc;

Sensor_Num = 50;%声音接收传感器个数
Room_Size = [100 100];%空间大小，单位（米）
Test_Times=1;%仿真定位次数
Err_NodeLoc=0;%节点位置误差
Err_Measure=0;%测量误差

Point_Step=1;

save Ini_Data.mat Sensor_Num Room_Size; % Err_NodeLoc Err_Measure Point_Step Test_Times;
disp(sprintf('Data saved!\n'));
                            