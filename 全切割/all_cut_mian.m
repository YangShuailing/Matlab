clc;

Sensor_Num = 10;%�������մ���������
Room_Size = [100 100];%�ռ��С����λ���ף�
Test_Times=20;%���涨λ����
Err_NodeLoc=0;%�ڵ�λ�����
Err_Measure=0;%�������
Point_Step=1;


%���������˷�λ��
Sensor_Loc = [Room_Size(1,1)*abs(rand(Sensor_Num,1)) Room_Size(1,2)*abs(rand(Sensor_Num,1))];
% %����ڵ�λ�����
Err=[];Sensor_Loc_Real = Sensor_Loc+(rand(size(Sensor_Loc))-0.5)*2*Err_NodeLoc;

%��ͼ�л�����˷�ڵ�λ��
for i=1:size(Sensor_Loc,1)
    plot(Sensor_Loc(i,1), Sensor_Loc(i,2),'r.-');
    hold on;
end


 for runs = 1:Test_Times
    %������ɴ���λĿ��λ��
    Speaker_Loc = [Room_Size(1,1)*abs(rand(1,1)) Room_Size(1,2)*abs(rand(1,1))];
    %��ͼ�л�����Դλ��
    disp(sprintf('��%d�ζ�λ����Դλ��Ϊ(%f,%f)',runs,Speaker_Loc(1,1), Speaker_Loc(1,2)));
    plot(Speaker_Loc(1,1), Speaker_Loc(1,2),'b*-');
    hold on;
    
    flag=ones(Room_Size(1,1)/Point_Step+1,Room_Size(1,2)/Point_Step+1);%���

   
    
    for i=1:Sensor_Num
      	for j=i+1:Sensor_Num
           	%��Դ������Sensor֮�����Ĳ��ΪDeltaDis,����λ�����
            Dis_SpeakerToI=sqrt(((Speaker_Loc(1,1)-Sensor_Loc(i,1)).^2)+((Speaker_Loc(1,2)-Sensor_Loc(i,2)).^2));
            Dis_SpeakerToJ=sqrt(((Speaker_Loc(1,1)-Sensor_Loc(j,1)).^2)+((Speaker_Loc(1,2)-Sensor_Loc(j,2)).^2)); 
% % % %%%%%%%%%
% %%�ֻ�����λ��Microphone_Center_Location
% Microphone_Center_Location=(Sensor_Loc(i,:)+Sensor_Loc(j,:))/2;
% %����ʸ��Mic_vector
% Mic_vector=Sensor_Loc(i,:)-Sensor_Loc(j,:);
% 
% %%%��֪����ʸ��Direct_vector=[a,b]������λ��(x0,y0)Microphone_Center_Location��
% %%%���㴹ֱƽ����a(x-x0)+b(y-y0)=0  
% 
% a=Mic_vector(1:end,1);
% b=Mic_vector(1:end,2);
% x0=Microphone_Center_Location(1:end,1);
% y0=Microphone_Center_Location(1:end,2);
% 
% aa=-a./b; %%%% �д���б��
% bb=(a.*Microphone_Center_Location(:,1)+b.*Microphone_Center_Location(:,2))./b;  %%%�ؾ�
%         xx=0:100;
%         yy=aa*xx+bb;
%         plot(xx,yy,'color','black','Linewidth',1);
%         hold on;
%   
%     axis([0 100 0 100]);
%             
% % %%%%%%%%%
            DeltaDis=Dis_SpeakerToI-Dis_SpeakerToJ;
            
            for temp_x=1:Room_Size(1,1)/Point_Step+1
                for temp_y=1:Room_Size(1,2)/Point_Step+1
                    %����[temp_x temp_y]���ڵ�i,j����
                    Dis_TempToI=sqrt(((Point_Step*(temp_x-1)-Sensor_Loc(i,1)).^2)+((Point_Step*(temp_y-1)-Sensor_Loc(i,2)).^2));
                    Dis_TempToJ=sqrt(((Point_Step*(temp_x-1)-Sensor_Loc(j,1)).^2)+((Point_Step*(temp_y-1)-Sensor_Loc(j,2)).^2));
                        
                  	%�����ֵ
                   	DeltaDis_TempToSensor=Dis_TempToI-Dis_TempToJ;
                    
                    %��ע
                  	if DeltaDis_TempToSensor*DeltaDis<0 %[temp_x temp_y]��Speaker_Loc����i,j�д���ͬһ�� 
                        flag(temp_x,temp_y)=0;
                    end
                end
            end
        end
    end

   	sum_x=0;
   	sum_y=0;
   	totalcounnt=0;
	for temp_x=1:Room_Size(1,1)/Point_Step+1
      	for temp_y=1:Room_Size(1,2)/Point_Step+1
           	if flag(temp_x,temp_y)==1
            	sum_x=sum_x+(temp_x-1)*Point_Step;
                sum_y=sum_y+(temp_y-1)*Point_Step;
                totalcounnt=totalcounnt+1;
%    %%�����и�����                 
%               plot((temp_x-1)*Point_Step,(temp_y-1)*Point_Step,'y.-');
%              	hold on;
%               axis([0 100 0 100]);
            end
        end
    end
        
	estimated_location=[sum_x/totalcounnt sum_y/totalcounnt];
    D_Error = sqrt((estimated_location(1,1)-Speaker_Loc(1,1)).^2+(estimated_location(1,2)-Speaker_Loc(1,2)).^2);
	disp(sprintf('����λ��Ϊ(%f,%f),���Ϊ%d',estimated_location(1,1), estimated_location(1,2),D_Error));
    plot(estimated_location(1,1),estimated_location(1,2),'r*-');
    hold on;

	Err=[Err D_Error];
end  
save Loc_Result_Cut.mat Err;

