clc;
clear;
x = 1:50;
for i=1:50
y(i)=RBS(i);
y1(i)=VASL(i);
end

plot(x,y,'k-',x,y1,'k-.','linewidth',1.3) 
xlabel('The munber of nodes with Level1')
ylabel('The number of transmission data ')
legend('Global synchronization scheme','VASL ');
% text(50,2500,'\rightarrow RBS')
% text(70,895,'  VASL \rightarrow ')
hold on 
