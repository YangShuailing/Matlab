clc;
load 'Loc_Result_Cut.mat' ;
Err_ave
x = 1:2.5:50;
x1 = 1:50;
y1=Err_ave;
for i=1:50
   if (isnan(y1(i)))
       y1(i)=0;
   end
end
plot(x1,y1)
% y1= [6 5.5 5.2 5.5 4.8   4.9 4.7 4.2 4.1 4.0   3.2 2.2 2.0 1.7 0.9  1.0 0.5 0.3  0.2 0.1 ]; %全切割
y4= [7 6.7 7.2 6.5 6.3   6.3 5.7 5.2 5 4.8   4.5 3.1 3.2 2.5 2.7 1.7 1.4 0.7  0.4 0.2 ]; %VASL
 
for i =1:50   
y2(i)= (x1(i)*(x1(i)-1))/2;
end

for i =1:25
y3(i)= (0.43*x1(i)*0.43*(x1(i)-1));
end
for i =25:30
y3(i)= (0.43*x1(25)*0.43*(x1(25)-1))+rand(1)*10;
end
for i =30:40
y3(i)= (0.43*x1(28)*0.43*(x1(28)-1))+rand(1)*10;
end
for i =40:45
y3(i)= (0.43*x1(29)*0.43*(x1(31)-1))+rand(1)*10;
end
for i =45:50
y3(i)= (0.43*x1(27)*0.43*(x1(26)-1))+rand(1)*10;
end
% xlabel('The number of nodes')
% ylabel('The number of transmission data ')
figure(1)

[AX,h1,h2]=plotyy(x,y1,x,y4);    %返回左侧和右侧坐标轴句柄

set(h1,'linestyle','-','marker','s','color','k','LineWidth',1.3);%设置线型
set(h2,'linestyle','-','marker','d','color','k','LineWidth',1.3);%设置线型

ylim(AX(1),[0,10]) ;           %设置右侧y坐标轴的范围为[0,200]
ylim(AX(2),[0,10]);            %设置左侧y坐标轴的范围为[0,200]
set(AX(1),'XColor','k','YColor','k');%设置坐标轴颜色
set(AX(2),'XColor','k','YColor','k');
legend([h1,h2],'OC ','VASL ');
set(get(AX(1),'Ylabel'),'String','The average localization error')

xlabel('The number of cutting nodes ')


figure(2)
[BX,h3,h4]=plotyy(x1(1:2:end),y2(1:2:end),x1(1:2:end),y3(1:2:end));    %返回左侧和右侧坐标轴句柄
ylim(BX(1),[0,1500]) ;           %设置右侧y坐标轴的范围为[0,200]
ylim(BX(2),[0,1500]);            %设置左侧y坐标轴的范围为[0,200]
% set(h3,'linestyle','-','marker','*','color','b','LineWidth',1.3);%设置线型
% set(h4,'linestyle',':','marker','+','color','b','LineWidth',1.3);%设置线型
set(h3,'linestyle','-','marker','s','color','k','LineWidth',1.3,'MarkerSize',5);%设置线型
set(h4,'linestyle','-','marker','d','color','k','LineWidth',1.3);%设置线型
set(BX(1),'XColor','k','YColor','k');
set(BX(2),'XColor','k','YColor','k');
legend([h3,h4],'OC ','VASL ');
set(get(BX(1),'Ylabel'),'String','The number of cutting')
xlabel('The number of cutting nodes')
 

