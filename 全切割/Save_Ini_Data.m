clc;

Sensor_Num = 50;%�������մ���������
Room_Size = [100 100];%�ռ��С����λ���ף�
Test_Times=1;%���涨λ����
Err_NodeLoc=0;%�ڵ�λ�����
Err_Measure=0;%�������

Point_Step=1;

save Ini_Data.mat Sensor_Num Room_Size; % Err_NodeLoc Err_Measure Point_Step Test_Times;
disp(sprintf('Data saved!\n'));
                            