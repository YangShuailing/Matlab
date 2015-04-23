function [ x,y ] = localication( X,Y,Room_Size,Sensor_Num,Dis_To_Sensor,Speaker_Loc)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
voronoi(X',Y');
hold on;
axis([0 Room_Size 0 Room_Size]);
%axis([-1*Room_Size 2*Room_Size -1*Room_Size 2*Room_Size]);
[V,C]=voronoin([X Y]);

%求解每个sensor周围有哪些Voronio顶点
% for i=1:Sensor_Num
%     C{i} %sensor i周围有编号为C{i}的V图顶点，这些顶点把sensor i包围在一个以这些点为顶点的凸多边形内，这些顶点的坐标是[V(C{i},1),V(C{i},2)];
% end;

%选取有效范围内的V图顶点，其他范围外的顶点舍弃，用Valid_V数组记录有效V图顶点的编号，例如V（Valid_V（1））表示有效范围内的第一个V图顶点
t=1;
for i=1:size(V,1)
     if(V(i,1)>=0 && V(i,1)<=Room_Size && V(i,2)>=0 && V(i,2)<=Room_Size)
         Valid_V(t)=i;
         t=t+1;
     end
end;

%选择起始点

%声源到两个Sensor之间距离的差记为DeltaDis,包含位置误差
for i=1:size(V,1)
 Start_V_Point_Num1=Valid_V(ceil(size(Valid_V,2)*abs(rand(1))));
Start_V_Point_Loc=V(Start_V_Point_Num1,:);
 Dis_SpeakerTo_Sensor=sqrt(((Speaker_Loc(1,1)-Start_V_Point_Loc(1,1)).^2)+((Speaker_Loc(1,2)-Start_V_Point_Loc(1,2)).^2));
if (Dis_SpeakerTo_Sensor<10)
    Start_V_Point_Num =Start_V_Point_Num1;
end
end
%找到三个与起始点相关的sensor节点
Sensor_ABC_Num=[0 0 0];
Sensor_ABC_Loc=[0 0;0 0;0 0];
t=1;
while(t~=4)
    t=1;
    for i=1:Sensor_Num*9
        for j=1:size(C{i},2)
            if(Start_V_Point_Num == C{i}(1,j))
                Sensor_ABC_Num(t)=i;
                Sensor_ABC_Loc(t,:)=[X(i) Y(i)];
                
                t=t+1;
            end
        end
    end
end

%计算下一步可能走到的三个V图顶点
% Next_V_Point_ABC_Num=[0 0 0];
% Next_V_Point_ABC_Loc=[0 0; 0 0; 0 0];
% 
% for i=1:size(C{Sensor_ABC_Num(1)},2)
%     for j=1:size(C{Sensor_ABC_Num(2)},2)
%           if(C{Sensor_ABC_Num(1)}(1,i)==C{Sensor_ABC_Num(2)}(1,j) && C{Sensor_ABC_Num(1)}(1,i)~=Start_V_Point_Num)
%                Next_V_Point_ABC_Num(1)=C{Sensor_ABC_Num(1)}(1,i);
%                Next_V_Point_ABC_Loc(1,:)=[V(C{Sensor_ABC_Num(1)}(1,i),1),V(C{Sensor_ABC_Num(1)}(1,i),2)];
%                break;
%           end
%      end
% end
% for i=1:size(C{Sensor_ABC_Num(1)},2)
%     for j=1:size(C{Sensor_ABC_Num(3)},2)
%           if(C{Sensor_ABC_Num(1)}(1,i)==C{Sensor_ABC_Num(3)}(1,j) && C{Sensor_ABC_Num(1)}(1,i)~=Start_V_Point_Num)
%                Next_V_Point_ABC_Num(2)=C{Sensor_ABC_Num(1)}(1,i);
%                Next_V_Point_ABC_Loc(2,:)=[V(C{Sensor_ABC_Num(1)}(1,i),1),V(C{Sensor_ABC_Num(1)}(1,i),2)];
%                break;
%           end
%      end
% end
% for i=1:size(C{Sensor_ABC_Num(2)},2)
%     for j=1:size(C{Sensor_ABC_Num(3)},2)
%           if(C{Sensor_ABC_Num(2)}(1,i)==C{Sensor_ABC_Num(3)}(1,j) && C{Sensor_ABC_Num(2)}(1,i)~=Start_V_Point_Num)
%                Next_V_Point_ABC_Num(3)=C{Sensor_ABC_Num(2)}(1,i);
%                Next_V_Point_ABC_Loc(3,:)=[V(C{Sensor_ABC_Num(2)}(1,i),1),V(C{Sensor_ABC_Num(2)}(1,i),2)];
%                break;
%           end
%      end
% end

%根据三个距离差判断选取哪一个点作为下一步所走的点
TDOA_ABC_12=Dis_To_Sensor(Sensor_ABC_Num(1))-Dis_To_Sensor(Sensor_ABC_Num(2));
TDOA_ABC_13=Dis_To_Sensor(Sensor_ABC_Num(1))-Dis_To_Sensor(Sensor_ABC_Num(3));
TDOA_ABC_23=Dis_To_Sensor(Sensor_ABC_Num(2))-Dis_To_Sensor(Sensor_ABC_Num(3));

%找到TOA_ABC_12,TOA_ABC_13,TOA_ABC_23中最大的一个，然后选择另外两个较小的sensor决定的方向作为起始方向，对应的V图顶点为下一步到达的点
Next_V_Point_Num=0;
Next_V_Point_Loc=[0 0];
Related_Sensor=[0 0];
if(TDOA_ABC_12>=0 && TDOA_ABC_13>=0) %TOA_ABC_1最大
    for i=1:size(C{Sensor_ABC_Num(2)},2)
        for j=1:size(C{Sensor_ABC_Num(3)},2)
            if(C{Sensor_ABC_Num(2)}(1,i)==C{Sensor_ABC_Num(3)}(1,j) && C{Sensor_ABC_Num(2)}(1,i)~=Start_V_Point_Num)
                Related_Sensor=[Sensor_ABC_Num(2) Sensor_ABC_Num(3)];
                Next_V_Point_Num=C{Sensor_ABC_Num(2)}(1,i);
                Next_V_Point_Loc(:)=[V(C{Sensor_ABC_Num(2)}(1,i),1),V(C{Sensor_ABC_Num(2)}(1,i),2)];
                break;
            end
        end
    end
end
if(TDOA_ABC_12<=0 && TDOA_ABC_23>=0) %TOA_ABC_2最大
    for i=1:size(C{Sensor_ABC_Num(1)},2)
        for j=1:size(C{Sensor_ABC_Num(3)},2)
            if(C{Sensor_ABC_Num(1)}(1,i)==C{Sensor_ABC_Num(3)}(1,j) && C{Sensor_ABC_Num(1)}(1,i)~=Start_V_Point_Num)
                Related_Sensor=[Sensor_ABC_Num(1) Sensor_ABC_Num(3)];
                Next_V_Point_Num=C{Sensor_ABC_Num(1)}(1,i);
                Next_V_Point_Loc(:)=[V(C{Sensor_ABC_Num(1)}(1,i),1),V(C{Sensor_ABC_Num(1)}(1,i),2)];
                break;
            end
        end
    end
end
if(TDOA_ABC_13<=0 && TDOA_ABC_23<=0) %TOA_ABC_3最大
    for i=1:size(C{Sensor_ABC_Num(1)},2)
        for j=1:size(C{Sensor_ABC_Num(2)},2)
            if(C{Sensor_ABC_Num(1)}(1,i)==C{Sensor_ABC_Num(2)}(1,j) && C{Sensor_ABC_Num(1)}(1,i)~=Start_V_Point_Num)
                Related_Sensor=[Sensor_ABC_Num(1) Sensor_ABC_Num(2)];
                Next_V_Point_Num=C{Sensor_ABC_Num(1)}(1,i);
                Next_V_Point_Loc(:)=[V(C{Sensor_ABC_Num(1)}(1,i),1),V(C{Sensor_ABC_Num(1)}(1,i),2)];
                break;
            end
        end
    end
end

%下面开始循环过程，不断探寻知道形成环，过程中对走过的V_Point进行标记，并用Route记录走过的V图顶点路径,用Route_Related_Sensor_Node记录沿途进行决策的sensor节点对
for i=1:size(V,1)
    Pass_Flag(i)=0;
end
Old_V_Point=Start_V_Point_Num;
Current_V_Point=Next_V_Point_Num;
Current_Sensor_Node=Related_Sensor;
Pass_Flag(Old_V_Point)=1;
Route=[Old_V_Point Current_V_Point];
Route_Related_Sensor_Node=[Current_Sensor_Node(1) Current_Sensor_Node(2)];

%disp(sprintf('从V图顶点(%f，%f)出发，顶点编号%d，初始朝向是V图顶点(%f，%f)，顶点编号%d', V(Old_V_Point,1), V(Old_V_Point,2),Old_V_Point,V(Current_V_Point,1),V(Current_V_Point,2),Current_V_Point));
plot(V(Old_V_Point,1), V(Old_V_Point,2),'Y*');
hold on;

while(Pass_Flag(Current_V_Point)~=1)
    %disp(sprintf('根据Sensor(%f,%f)和Sensor(%f,%f)判定下一步走向',X(Current_Sensor_Node(1)),Y(Current_Sensor_Node(1)),X(Current_Sensor_Node(2)),Y(Current_Sensor_Node(2))));
    
    %查找第三个相关的Sensor节点
    for i=1:Sensor_Num*9
        for j=1:size(C{i},2)
            if(C{i}(1,j)==Current_V_Point && i~=Current_Sensor_Node(1) && i~=Current_Sensor_Node(2))
                Temp_Sensor=i;
            end
        end
    end
    
    %计算TDOA并判断
    TDOA=Dis_To_Sensor(Current_Sensor_Node(1))-Dis_To_Sensor(Current_Sensor_Node(2));
    if(TDOA<=0)
        Old_V_Point=Current_V_Point;
        Pass_Flag(Old_V_Point)=1;
        Current_Sensor_Node(2)=Temp_Sensor;
        %计算新的Current_V_Point
        for i=1:size(C{Current_Sensor_Node(1)},2)
            for j=1:size(C{Current_Sensor_Node(2)},2)
                if(C{Current_Sensor_Node(1)}(1,i)==C{Current_Sensor_Node(2)}(1,j) && C{Current_Sensor_Node(1)}(1,i)~=Old_V_Point)
                    Current_V_Point=C{Current_Sensor_Node(1)}(1,i);
                    Route(size(Route,2)+1)=Current_V_Point;
                end
            end
        end
    else %TDOA>0
        Old_V_Point=Current_V_Point;
        Pass_Flag(Old_V_Point)=1;
        Current_Sensor_Node(1)=Temp_Sensor;
        %计算新的Current_V_Point
        for i=1:size(C{Current_Sensor_Node(1)},2)
            for j=1:size(C{Current_Sensor_Node(2)},2)
                if(C{Current_Sensor_Node(1)}(1,i)==C{Current_Sensor_Node(2)}(1,j) && C{Current_Sensor_Node(1)}(1,i)~=Old_V_Point)
                    Current_V_Point=C{Current_Sensor_Node(1)}(1,i);
                    Route(size(Route,2)+1)=Current_V_Point;
                end
            end
        end
    end
    Route_Related_Sensor_Node=[Route_Related_Sensor_Node; Current_Sensor_Node];
    %disp(sprintf('到达新的V图顶点(%f,%f)，顶点编号%d\n',V(Current_V_Point,1),V(Current_V_Point,2),Current_V_Point));
    plot(V(Old_V_Point,1), V(Old_V_Point,2),'r*');
    hold on;
end

%下面采用封闭凸多边形周围一圈的节点TDOA信息将凸多边形进行更细的划分
%找到形成的环，Loop表示围成的闭环的V图顶点
temp=Route(1,size(Route,2));
Loop=[temp];
Flag=0;
for i=1:size(Route,2)-1
    if(Flag~=0)
        Loop(size(Loop,2)+1)=Route(i);
    end
    if(Route(i)==temp)
        Flag=i;
    end
end

%Sensor_Outside_Loop表示围成的闭环最临近一层的sensor
%Center_Sensor_Node表示闭环内的Sensor节点
if(Route_Related_Sensor_Node(size(Route_Related_Sensor_Node,1),1)==Route_Related_Sensor_Node(size(Route_Related_Sensor_Node,1)-1,1))
    Center_Sensor_Node=Route_Related_Sensor_Node(size(Route_Related_Sensor_Node,1),1);
    Sensor_Outside_Loop=Route_Related_Sensor_Node(Flag,2);
    for i=Flag+1:size(Route_Related_Sensor_Node,1)
        Sensor_Outside_Loop(size(Sensor_Outside_Loop,2)+1)=Route_Related_Sensor_Node(i,2);
    end
else
    Center_Sensor_Node=Route_Related_Sensor_Node(size(Route_Related_Sensor_Node,1),2);
    Sensor_Outside_Loop=Route_Related_Sensor_Node(Flag,1);
    for i=Flag+1:size(Route_Related_Sensor_Node,1)
        Sensor_Outside_Loop(size(Sensor_Outside_Loop,2)+1)=Route_Related_Sensor_Node(i,1);
    end
end

%计算闭环每条边所在的直线Ax+By+C=0
%Center_Node_Dis_To_Line表示中心节点到这些边的距离
A=zeros(1,size(Loop,2));
B=zeros(1,size(Loop,2));
C=zeros(1,size(Loop,2));
Center_Node_Dis_To_Line=zeros(1,size(Loop,2));
for i=1:size(Loop,2)
    if(i==size(Loop,2))
        A(i)=V(Loop(1,1),2)-V(Loop(1,i),2);
        B(i)=V(Loop(1,i),1)-V(Loop(1,1),1);
        C(i)=V(Loop(1,1),1)*V(Loop(1,i),2)-V(Loop(1,i),1)*V(Loop(1,1),2);
    else
        A(i)=V(Loop(1,i+1),2)-V(Loop(1,i),2);
        B(i)=V(Loop(1,i),1)-V(Loop(1,i+1),1);
        C(i)=V(Loop(1,i+1),1)*V(Loop(1,i),2)-V(Loop(1,i),1)*V(Loop(1,i+1),2);
    end
        Center_Node_Dis_To_Line(i)=(A(i)*X(Center_Sensor_Node)+B(i)*Y(Center_Sensor_Node)+C(i))/sqrt(A(i).^2+B(i).^2);
    %画出闭环所在直线完整的直线
%     x=0:0.1:Room_Size;
%     y=(-1*A(i)*x-C(i))/B(i);
%     plot(x,y);
end

%圈出闭环内的点，标记为1，其他不符合条件的点标记为0
point_step=0.05;
Possible_Area=ones(Room_Size/point_step+1,Room_Size/point_step+1);
for i=1:Room_Size/point_step+1
    for j=1:Room_Size/point_step+1
        temp_x=point_step*(i-1);
        temp_y=point_step*(j-1);
        for k=1:size(Loop,2)
            Dis_To_line=(A(k)*temp_x+B(k)*temp_y+C(k))/sqrt(A(k).^2+B(k).^2);
            if(Dis_To_line*Center_Node_Dis_To_Line(1,k)<0)
                Possible_Area(i,j)=0;
                break;
            end
        end
    end
end

%利用闭环周围最临近的一圈sensor二分进一步划分闭环区域
%计算闭环外侧最临近一圈的sensor所确定的中垂线out_Ax+Out_By+Out_C=0
Out_A=zeros(1,size(Sensor_Outside_Loop,2));
Out_B=zeros(1,size(Sensor_Outside_Loop,2));
Out_C=zeros(1,size(Sensor_Outside_Loop,2));
for i=1:size(Sensor_Outside_Loop,2)
    if(i==size(Sensor_Outside_Loop,2))
        Out_A(i)=X(Sensor_Outside_Loop(1,i))-X(Sensor_Outside_Loop(1,1));
        Out_B(i)=Y(Sensor_Outside_Loop(1,i))-Y(Sensor_Outside_Loop(1,1));
        Out_C(i)=(Y(Sensor_Outside_Loop(1,1)).^2-Y(Sensor_Outside_Loop(1,i)).^2+X(Sensor_Outside_Loop(1,1)).^2-X(Sensor_Outside_Loop(1,i)).^2)/2;
    else
        Out_A(i)=X(Sensor_Outside_Loop(1,i))-X(Sensor_Outside_Loop(1,i+1));
        Out_B(i)=Y(Sensor_Outside_Loop(1,i))-Y(Sensor_Outside_Loop(1,i+1));
        Out_C(i)=(Y(Sensor_Outside_Loop(1,i+1)).^2-Y(Sensor_Outside_Loop(1,i)).^2+X(Sensor_Outside_Loop(1,i+1)).^2-X(Sensor_Outside_Loop(1,i)).^2)/2;
    end
    %画出分割用到的直线
    x=0:0.1:Room_Size;
    y=(-1*Out_A(i)*x-Out_C(i))/Out_B(i);
    plot(x,y);
end

for i=1:Room_Size/point_step+1
    for j=1:Room_Size/point_step+1
        if(Possible_Area(i,j)>=1)
            temp_x=point_step*(i-1);
            temp_y=point_step*(j-1);
            for k=1:size(Sensor_Outside_Loop,2)
                if(k<size(Sensor_Outside_Loop,2))
                    TDOA_Out_Loop=Dis_To_Sensor(Sensor_Outside_Loop(k))-Dis_To_Sensor(Sensor_Outside_Loop(k+1));
                else
                    TDOA_Out_Loop=Dis_To_Sensor(Sensor_Outside_Loop(k))-Dis_To_Sensor(Sensor_Outside_Loop(1));
                end
                if(TDOA_Out_Loop>=0)
                    if(k<size(Sensor_Outside_Loop,2))
                        if((Out_A(k)*X(Sensor_Outside_Loop(k+1))+Out_B(k)*Y(Sensor_Outside_Loop(k+1))+Out_C(k))*(Out_A(k)*temp_x+Out_B(k)*temp_y+Out_C(k))>=0)
                            Possible_Area(i,j)=Possible_Area(i,j)+1;
                        end
                    else
                        if((Out_A(k)*X(Sensor_Outside_Loop(1))+Out_B(k)*Y(Sensor_Outside_Loop(1))+Out_C(k))*(Out_A(k)*temp_x+Out_B(k)*temp_y+Out_C(k))>=0)
                            Possible_Area(i,j)=Possible_Area(i,j)+1;
                        end
                    end
                else
                    if((Out_A(k)*X(Sensor_Outside_Loop(k))+Out_B(k)*Y(Sensor_Outside_Loop(k))+Out_C(k))*(Out_A(k)*temp_x+Out_B(k)*temp_y+Out_C(k))>=0)
                         Possible_Area(i,j)=Possible_Area(i,j)+1;
                    end
                end
            end
        end
    end
end

max=0;
for i=1:Room_Size/point_step+1
    for j=1:Room_Size/point_step+1
       if(Possible_Area(i,j)>max)
           max=Possible_Area(i,j);
       end
    end
end
 
x_summation=0;
y_summation=0;
count=0;
for i=1:Room_Size/point_step+1
    for j=1:Room_Size/point_step+1
        if(Possible_Area(i,j)==max)
            plot((i-1)*point_step,(j-1)*point_step,'color','black','Linewidth',8);
            x_summation=x_summation+(i-1)*point_step;
            y_summation=y_summation+(j-1)*point_step;
            count=count+1;
        end
    end
end
 
x=x_summation/count;
y=y_summation/count;
end

