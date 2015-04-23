clc;
load 'Ini_Data.mat';

%随机生成麦克风位置
Sensor_Loc = [Room_Size(1,1)*abs(rand(Sensor_Num,1)) Room_Size(1,2)*abs(rand(Sensor_Num,1))];

%加入节点位置误差
Sensor_Loc_Real = Sensor_Loc+(rand(size(Sensor_Loc))-0.5)*2*Err_NodeLoc;

%在图中画出麦克风节点位置
for i=1:size(Sensor_Loc,1)
    plot(Sensor_Loc(i,1), Sensor_Loc(i,2),'r.-');
    hold on;
end

Err=[];
 for runs = 1:Test_Times
    %随机生成待定位目标位置
    Speaker_Loc = [Room_Size(1,1)*abs(rand(1,1)) Room_Size(1,2)*abs(rand(1,1))];

    %在图中画出声源位置
    disp(sprintf('第%d次定位，声源位置为(%f,%f)',runs,Speaker_Loc(1,1), Speaker_Loc(1,2)));
    plot(Speaker_Loc(1,1), Speaker_Loc(1,2),'b*-');
    hold on;
    
    flag=ones(Room_Size(1,1)/Point_Step+1,Room_Size(1,2)/Point_Step+1);
        
    for i=1:Sensor_Num
      	for j=i+1:Sensor_Num
           	%声源到两个Sensor之间距离的差记为DeltaDis,包含位置误差
            Dis_SpeakerToI=sqrt(((Speaker_Loc(1,1)-Sensor_Loc_Real(i,1)).^2)+((Speaker_Loc(1,2)-Sensor_Loc_Real(i,2)).^2));
            Dis_SpeakerToJ=sqrt(((Speaker_Loc(1,1)-Sensor_Loc_Real(j,1)).^2)+((Speaker_Loc(1,2)-Sensor_Loc_Real(j,2)).^2));
            
            %加测量误差
            Dis_SpeakerToI=Dis_SpeakerToI+(rand()-0.5)*2*Err_Measure;
            Dis_SpeakerToJ=Dis_SpeakerToJ+(rand()-0.5)*2*Err_Measure;
            
           	DeltaDis=Dis_SpeakerToI-Dis_SpeakerToJ;
            
            for temp_x=1:Room_Size(1,1)/Point_Step+1
                for temp_y=1:Room_Size(1,2)/Point_Step+1
                    %计算[temp_x temp_y]到节点i,j距离
                    Dis_TempToI=sqrt(((Point_Step*(temp_x-1)-Sensor_Loc(i,1)).^2)+((Point_Step*(temp_y-1)-Sensor_Loc(i,2)).^2));
                    Dis_TempToJ=sqrt(((Point_Step*(temp_x-1)-Sensor_Loc(j,1)).^2)+((Point_Step*(temp_y-1)-Sensor_Loc(j,2)).^2));
                        
                  	%计算差值
                   	DeltaDis_TempToSensor=Dis_TempToI-Dis_TempToJ;
                    
                    %标注
                  	if DeltaDis_TempToSensor*DeltaDis<0 %[temp_x temp_y]与Speaker_Loc不在i,j中垂线同一侧 
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
                    
%               plot((temp_x-1)*Point_Step,(temp_y-1)*Point_Step,'y.-');
%              	hold on;
%               axis([0 100 0 100]);
            end
        end
    end
        
	estimated_location=[sum_x/totalcounnt sum_y/totalcounnt];
    D_Error = sqrt((estimated_location(1,1)-Speaker_Loc(1,1)).^2+(estimated_location(1,2)-Speaker_Loc(1,2)).^2);
	disp(sprintf('估算位置为(%f,%f),误差为%d',estimated_location(1,1), estimated_location(1,2),D_Error));
        
    plot(estimated_location(1,1),estimated_location(1,2),'r*-');
    hold on;

   	Err=[Err D_Error];
end  
save Loc_Result_Cut.mat Err;

