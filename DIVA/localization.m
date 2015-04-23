function [ x,y ] = localication( X,Y,Room_Size,Sensor_Num,Dis_To_Sensor,Speaker_Loc)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
voronoi(X',Y');
hold on;
axis([0 Room_Size 0 Room_Size]);
%axis([-1*Room_Size 2*Room_Size -1*Room_Size 2*Room_Size]);
[V,C]=voronoin([X Y]);

%���ÿ��sensor��Χ����ЩVoronio����
% for i=1:Sensor_Num
%     C{i} %sensor i��Χ�б��ΪC{i}��Vͼ���㣬��Щ�����sensor i��Χ��һ������Щ��Ϊ�����͹������ڣ���Щ�����������[V(C{i},1),V(C{i},2)];
% end;

%ѡȡ��Ч��Χ�ڵ�Vͼ���㣬������Χ��Ķ�����������Valid_V�����¼��ЧVͼ����ı�ţ�����V��Valid_V��1������ʾ��Ч��Χ�ڵĵ�һ��Vͼ����
t=1;
for i=1:size(V,1)
     if(V(i,1)>=0 && V(i,1)<=Room_Size && V(i,2)>=0 && V(i,2)<=Room_Size)
         Valid_V(t)=i;
         t=t+1;
     end
end;

%ѡ����ʼ��

%��Դ������Sensor֮�����Ĳ��ΪDeltaDis,����λ�����
for i=1:size(V,1)
 Start_V_Point_Num1=Valid_V(ceil(size(Valid_V,2)*abs(rand(1))));
Start_V_Point_Loc=V(Start_V_Point_Num1,:);
 Dis_SpeakerTo_Sensor=sqrt(((Speaker_Loc(1,1)-Start_V_Point_Loc(1,1)).^2)+((Speaker_Loc(1,2)-Start_V_Point_Loc(1,2)).^2));
if (Dis_SpeakerTo_Sensor<10)
    Start_V_Point_Num =Start_V_Point_Num1;
end
end
%�ҵ���������ʼ����ص�sensor�ڵ�
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

%������һ�������ߵ�������Vͼ����
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

%��������������ж�ѡȡ��һ������Ϊ��һ�����ߵĵ�
TDOA_ABC_12=Dis_To_Sensor(Sensor_ABC_Num(1))-Dis_To_Sensor(Sensor_ABC_Num(2));
TDOA_ABC_13=Dis_To_Sensor(Sensor_ABC_Num(1))-Dis_To_Sensor(Sensor_ABC_Num(3));
TDOA_ABC_23=Dis_To_Sensor(Sensor_ABC_Num(2))-Dis_To_Sensor(Sensor_ABC_Num(3));

%�ҵ�TOA_ABC_12,TOA_ABC_13,TOA_ABC_23������һ����Ȼ��ѡ������������С��sensor�����ķ�����Ϊ��ʼ���򣬶�Ӧ��Vͼ����Ϊ��һ������ĵ�
Next_V_Point_Num=0;
Next_V_Point_Loc=[0 0];
Related_Sensor=[0 0];
if(TDOA_ABC_12>=0 && TDOA_ABC_13>=0) %TOA_ABC_1���
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
if(TDOA_ABC_12<=0 && TDOA_ABC_23>=0) %TOA_ABC_2���
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
if(TDOA_ABC_13<=0 && TDOA_ABC_23<=0) %TOA_ABC_3���
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

%���濪ʼѭ�����̣�����̽Ѱ֪���γɻ��������ж��߹���V_Point���б�ǣ�����Route��¼�߹���Vͼ����·��,��Route_Related_Sensor_Node��¼��;���о��ߵ�sensor�ڵ��
for i=1:size(V,1)
    Pass_Flag(i)=0;
end
Old_V_Point=Start_V_Point_Num;
Current_V_Point=Next_V_Point_Num;
Current_Sensor_Node=Related_Sensor;
Pass_Flag(Old_V_Point)=1;
Route=[Old_V_Point Current_V_Point];
Route_Related_Sensor_Node=[Current_Sensor_Node(1) Current_Sensor_Node(2)];

%disp(sprintf('��Vͼ����(%f��%f)������������%d����ʼ������Vͼ����(%f��%f)��������%d', V(Old_V_Point,1), V(Old_V_Point,2),Old_V_Point,V(Current_V_Point,1),V(Current_V_Point,2),Current_V_Point));
plot(V(Old_V_Point,1), V(Old_V_Point,2),'Y*');
hold on;

while(Pass_Flag(Current_V_Point)~=1)
    %disp(sprintf('����Sensor(%f,%f)��Sensor(%f,%f)�ж���һ������',X(Current_Sensor_Node(1)),Y(Current_Sensor_Node(1)),X(Current_Sensor_Node(2)),Y(Current_Sensor_Node(2))));
    
    %���ҵ�������ص�Sensor�ڵ�
    for i=1:Sensor_Num*9
        for j=1:size(C{i},2)
            if(C{i}(1,j)==Current_V_Point && i~=Current_Sensor_Node(1) && i~=Current_Sensor_Node(2))
                Temp_Sensor=i;
            end
        end
    end
    
    %����TDOA���ж�
    TDOA=Dis_To_Sensor(Current_Sensor_Node(1))-Dis_To_Sensor(Current_Sensor_Node(2));
    if(TDOA<=0)
        Old_V_Point=Current_V_Point;
        Pass_Flag(Old_V_Point)=1;
        Current_Sensor_Node(2)=Temp_Sensor;
        %�����µ�Current_V_Point
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
        %�����µ�Current_V_Point
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
    %disp(sprintf('�����µ�Vͼ����(%f,%f)��������%d\n',V(Current_V_Point,1),V(Current_V_Point,2),Current_V_Point));
    plot(V(Old_V_Point,1), V(Old_V_Point,2),'r*');
    hold on;
end

%������÷��͹�������ΧһȦ�Ľڵ�TDOA��Ϣ��͹����ν��и�ϸ�Ļ���
%�ҵ��γɵĻ���Loop��ʾΧ�ɵıջ���Vͼ����
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

%Sensor_Outside_Loop��ʾΧ�ɵıջ����ٽ�һ���sensor
%Center_Sensor_Node��ʾ�ջ��ڵ�Sensor�ڵ�
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

%����ջ�ÿ�������ڵ�ֱ��Ax+By+C=0
%Center_Node_Dis_To_Line��ʾ���Ľڵ㵽��Щ�ߵľ���
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
    %�����ջ�����ֱ��������ֱ��
%     x=0:0.1:Room_Size;
%     y=(-1*A(i)*x-C(i))/B(i);
%     plot(x,y);
end

%Ȧ���ջ��ڵĵ㣬���Ϊ1�����������������ĵ���Ϊ0
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

%���ñջ���Χ���ٽ���һȦsensor���ֽ�һ�����ֱջ�����
%����ջ�������ٽ�һȦ��sensor��ȷ�����д���out_Ax+Out_By+Out_C=0
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
    %�����ָ��õ���ֱ��
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

