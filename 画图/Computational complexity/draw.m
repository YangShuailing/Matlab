clc;
load 'Loc_Result_Cut.mat' ;
x = 1:20;
y1= [6 5.5 5.2 5.5 4.8   4.9 4.7 4.2 4.1 4.0   3.2 2.2 2.0 1.7 0.9  1.0 0.5 0.2  0.3 0.2 ]; %全切割
y4= [7 6.7 7.2 6.5 6.3   6.3 5.7 5.2 5 4.8   4.5 3.1 3.2 2.5 2.7 1.7 1.4 0.7  0.2 0.1 ]; %VASL
 
for i =1:20   
y2(i)= (x(i)*(x(i)-1))/2;
end

for i =1:20
y3(i)= (0.43*x(i)*0.43*(x(i)-1));
end

% xlabel('The number of nodes')
% ylabel('The number of transmission data ')
[AX,h1,h2]=plotyy(x,y1,x,y2);    %返回左侧和右侧坐标轴句柄
hold on
[BX,h3,h4]=plotyy(x,y4,x,y3);    %返回左侧和右侧坐标轴句柄

set(h1,'linestyle','-','marker','o','color','b','LineWidth',1.3);%设置线型
set(h2,'linestyle',':','marker','+','color','g','LineWidth',1.3);%设置线型
set(h3,'linestyle','-','marker','h','color','b','LineWidth',1.3);%设置线型
set(h4,'linestyle',':','marker','*','color','g','LineWidth',1.3);%设置线型
 
ylim(AX(1),[0,10]) ;           %设置右侧y坐标轴的范围为[0,200]
ylim(AX(2),[0,200]);            %设置左侧y坐标轴的范围为[0,200]
ylim(BX(1),[0,10]) ;           %设置右侧y坐标轴的范围为[0,200]
ylim(BX(2),[0,200]);            %设置左侧y坐标轴的范围为[0,200]
legend([h1,h3,h4,h2],'VASL Localization error','OC Localization error','VASL The number of cutting','OC The number of cutting');
set(get(AX(1),'Ylabel'),'String','The average Localization error')
set(get(AX(2),'Ylabel'),'String','The number of cutting')
xlabel('The number of cutting nodes ')

% title('衰变曲线');
 

