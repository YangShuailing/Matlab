clc;
clear all  %清除 
close all; %关闭之前数据
Microphone_Distance=0.14;
k = 1;%参数
L=Microphone_Distance;%%一个phone上两个microphone距离
Node_number =10;
Size_Grid =1;
Speaker_to_speaker = zeros;
rmse_CMDS =zeros(Node_number,1);
Microphone_1_Location=zeros(Node_number,2);
Microphone_2_Location=zeros(Node_number,2);
Microphone_11_Location=zeros(Node_number,2);
Microphone_22_Location=zeros(Node_number,2);
Beep = zeros(Node_number,1);
My = zeros(Node_number,1);
Rmse_beep = zeros(Node_number,1);
Rmse_my = zeros(Node_number,1);
Speaker_to_speaker = zeros(Node_number,1);
Speaker_to_speaker1= zeros;
Angle =zeros(Node_number,1);
Microphone_Center_Location=Size_Grid*abs((rand(Node_number,2))); %中心位置
Y=zeros(Node_number,2);%mds形成的坐标
for  i=1:Node_number
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PhoneA  
        %%(L/2,0)
        Microphone_1_Location(i,1)=Microphone_Center_Location(i,1) + 0.5*Microphone_Distance;
        Microphone_1_Location(i,2)=Microphone_Center_Location(i,2) + 0.5*Microphone_Distance;  
		%%(-L/2,0)
        Microphone_2_Location(i,1)=Microphone_Center_Location(i,1) - 0.5*Microphone_Distance;
        Microphone_2_Location(i,2)=Microphone_Center_Location(i,2) - 0.5*Microphone_Distance; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%phoneA 的speaker坐标
        speaker1_x=Microphone_Center_Location(i,1);
        speaker1_y=Microphone_Center_Location(i,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
for  j=i+1:Node_number      
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PhoneB 
            %%(L/2,0)
	    Microphone_11_Location(j,1)=Microphone_Center_Location(j,1) + 0.5*Microphone_Distance;
        Microphone_11_Location(j,2)=Microphone_Center_Location(j,2) + 0.5*Microphone_Distance;  
		%%(-L/2,0)
        Microphone_22_Location(j,1)=Microphone_Center_Location(j,1) - 0.5*Microphone_Distance;
        Microphone_22_Location(j,2)=Microphone_Center_Location(j,2) - 0.5*Microphone_Distance;  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%phoneB 的speaker坐标
       speaker2_x=Microphone_Center_Location(j,1);
       speaker2_y=Microphone_Center_Location(j,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Microphone坐标
         Microphone1_1=Microphone_1_Location(i,1);
         Microphone1_2=Microphone_1_Location(i,2);%%%A1
         Microphone2_1=Microphone_2_Location(i,1);
         Microphone2_2=Microphone_2_Location(i,2);%%%A2        
         Microphone3_1=Microphone_11_Location(j,1);
         Microphone3_2=Microphone_11_Location(j,2);%%%B1         
         Microphone4_1=Microphone_22_Location(j,1);
         Microphone4_2=Microphone_22_Location(j,2);%%%B2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Sab1代表a为声源到b的第一个麦克风的距离
         Sab1=sqrt((speaker1_x-Microphone3_1)^2+(speaker1_y-Microphone3_2)^2);
         Sab2=sqrt((speaker1_x-Microphone4_1)^2+(speaker1_y-Microphone4_2)^2);
         Sba1=sqrt((speaker2_x-Microphone1_1)^2+(speaker2_y-Microphone1_2)^2);
         Sba2=sqrt((speaker2_x-Microphone2_1)^2+(speaker2_y-Microphone2_2)^2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%两个声源A-B真实距离      
         speaker_to_speaker = sqrt((speaker1_x-speaker2_x)^2+(speaker1_y-speaker2_y)^2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%计算
         daa=Microphone_Distance/2;
         dbb=Microphone_Distance/2;%%%一个手机上两个麦克风之间的距离
         Sa11=daa;
         Sa21=daa;
         Sb13=daa;
         Sb23=daa;
         a=0;
         b=0;
         c=0;
         d=0;
if Sab1>=Sba2    
        a = Sab1;
        d = Sba2;           
    else  
        d = Sab1;
        a = Sba2;
end
if Sba1>=Sab2
        b = Sba1;
        c = Sab2;    
    else
       c = Sba1;
       b = Sab2;
end       
TDOA1 = abs(d-a);
TDOA2 = abs(b-c);
M = a+b+c+d;%%%%%%基于beepbeep
cosa = TDOA2/L;
cosb = TDOA1/L;
Q=(TDOA1+TDOA2+M)/2;
C = (Q*L*cosb-Q^2)/(L*cosb+L*cosa-2*Q);
% C=c;
A = Q-C;
B = C-TDOA2;
D = A+TDOA1;
my1 = sqrt(C^2+(L/2)^2-2*C*(L/2)*cosa);
my2 = sqrt(A^2+(L/2)^2-2*A*(L/2)*cosb);
my = (my1+my2)/2;%%%实测两个声源的距离
beep= (a+d+c+d)/4;

Beep(k)  = beep;
My(k) = my;
% rmse_beep = norm(speaker_to_speaker-beep);
% rmse_my = norm(speaker_to_speaker-my1);
% Rmse_beep(k) = rmse_beep;
% Rmse_my(k)= rmse_my;
Speaker_to_speaker(k)=speaker_to_speaker;
k=k+1;
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MDS   
% D =Beep';
% [a,b]=cmdscale(D);
% a=a(:,1:2);
% [D,Z,transform] = procrustes(Microphone_Center_Location(1:3,:),a(1:3,:));
% c = transform.c;
% T = transform.T;
% b = transform.b;
% ec=[c(1,1) c(1,2)];
% cc= kron(ec,ones(Node_number,1));
% Z1 = b*a*T + cc;
% [D,Z,transform] = procrustes(Microphone_Center_Location,a);
% est_CMDS=Z;
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

est_mds_my= mds_node(Microphone_Center_Location,My);
est_mds_beep=mds_node(Microphone_Center_Location,Beep); %mds得到的坐标

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% my算法定出的节点坐标
figure(1)
for  m=1:Node_number
plot(est_mds_my(m,1),est_mds_my(m,2),'*r')
hold on
plot(Microphone_Center_Location(m,1),Microphone_Center_Location(m,2),'.k')
 legend( 'Our method localization','Node Location');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% beep算法定出的节点坐标
figure(2)
for  m=1:Node_number
plot(est_mds_beep(m,1),est_mds_beep(m,2),'*r')
hold on
plot(Microphone_Center_Location(m,1),Microphone_Center_Location(m,2),'.b')
 legend( 'Beepbeep localization','Node Location');
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 误差的CDF图像
% for i=1:Node_number
% rmse_beep = norm(Microphone_Center_Location(i,:)-est_mds_beep(i,:))
% rmse_my = norm(Microphone_Center_Location(i,:)-est_mds_my(i,:))
% Rmse_beep(i) = rmse_beep;
% Rmse_my(i)= rmse_my;
% end
% 
% figure(4)
% totalNum=size(Rmse_my,1);
% ymin=min(Rmse_my); 
% ymax=max(Rmse_my);
% x=linspace(ymin,ymax,20);
% yy=hist(Rmse_my,x); %计算各个区间的个数 
% yy=yy/totalNum;%计算各个区间的概率
% for i=2:size(x,2)
%     yy(1,i)=yy(1,i-1)+yy(1,i);
% end
% plot(x, yy, 'bo-', 'LineWidth', 1, 'MarkerFaceColor', 'b');
% hold on;
% totalNum=size(Rmse_beep,1);
% ymin=min(Rmse_beep); 
% ymax=max(Rmse_beep);
% x=linspace(ymin,ymax,20); 
% yy=hist(Rmse_beep,x); %计算各个区间的个数 
% yy=yy/totalNum;%计算各个区间的概率
% for i=2:size(x,2)
%     yy(1,i)=yy(1,i-1)+yy(1,i);
% end
% plot(x, yy, 'bo-', 'LineWidth', 1, 'MarkerFaceColor', 'r');
%  axis([0 ymax 0 1]); 
%  xlabel('Positioning error(m)');
% ylabel('CDF');
% legend( 'Our method','Beepbeep');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%