clc;
Sensor_Num=50;
Room_Size=50;
Sensor_Loc=Room_Size*abs(rand(Sensor_Num,2));
R = 10;%������������

%��������room��Χ�İ˸�ͬ����С�Ŀռ䣬������ֲ�ͬ��������⴫�����ڵ�
Sensor_Left=Room_Size*abs(rand(Sensor_Num,2));
Sensor_Left(:,1)=Sensor_Left(:,1)-Room_Size;
Sensor_Right=Room_Size*abs(rand(Sensor_Num,2));
Sensor_Right(:,1)=Sensor_Right(:,1)+Room_Size;
Sensor_Up=Room_Size*abs(rand(Sensor_Num,2));
Sensor_Up(:,2)=Sensor_Up(:,2)+Room_Size;
Sensor_Down=Room_Size*abs(rand(Sensor_Num,2));
Sensor_Down(:,2)=Sensor_Down(:,2)-Room_Size;
Sensor_Left_Up=Room_Size*abs(rand(Sensor_Num,2));
Sensor_Left_Up(:,1)=Sensor_Left_Up(:,1)-Room_Size;
Sensor_Left_Up(:,2)=Sensor_Left_Up(:,2)+Room_Size;
Sensor_Right_Up=Room_Size*abs(rand(Sensor_Num,2));
Sensor_Right_Up(:,1)=Sensor_Right_Up(:,1)+Room_Size;
Sensor_Right_Up(:,2)=Sensor_Right_Up(:,2)+Room_Size;
Sensor_Left_Down=Room_Size*abs(rand(Sensor_Num,2));
Sensor_Left_Down(:,1)=Sensor_Left_Down(:,1)-Room_Size;
Sensor_Left_Down(:,2)=Sensor_Left_Down(:,2)-Room_Size;
Sensor_Right_Down=Room_Size*abs(rand(Sensor_Num,2));
Sensor_Right_Down(:,1)=Sensor_Right_Down(:,1)+Room_Size;
Sensor_Right_Down(:,2)=Sensor_Right_Down(:,2)-Room_Size;

All_Sensor=[Sensor_Loc;Sensor_Left;Sensor_Right;Sensor_Up;Sensor_Down;Sensor_Left_Up;Sensor_Right_Up;Sensor_Left_Down;Sensor_Right_Down];

Speaker_Loc=Room_Size*abs(rand(1,2));

%%������Դλ��
plot(Speaker_Loc(1,1), Speaker_Loc(1,2),'ro-');
hold on;
%%������������뾶
alpha=0:pi/20:2*pi;%�Ƕ�[0,2*pi]
x=Speaker_Loc(1,1)+R*cos(alpha);
y=Speaker_Loc(1,2)+R*sin(alpha);
plot(x,y,'g:')
axis equal
hold on
Dis_To_Sensor=sqrt((All_Sensor(:,1)-Speaker_Loc(1,1)).^2+(All_Sensor(:,2)-Speaker_Loc(1,2)).^2);

[xx,yy]=localization(All_Sensor(:,1),All_Sensor(:,2),Room_Size,Sensor_Num,Dis_To_Sensor,Speaker_Loc);
disp(sprintf('��ʵλ��(%f,%f)������λ��(%f,%f)\n',Speaker_Loc(1,1),Speaker_Loc(1,2),xx,yy));