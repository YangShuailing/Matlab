clc;
x = 1:100;
for i=1:100
y(i)=RBS(i);
y1(i)=VASL(i);
end

plot(x,y,'-',x,y1,':') 
xlabel('The number of nodes')
ylabel('The number of transmission data ')
% legend('RBS','VASL');
text(50,2500,'\rightarrow RBS')
text(70,895,'  VASL \rightarrow ')
hold on 
