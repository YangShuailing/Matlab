function y = RBS( x )
%RBS �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
if x>=0&&x<=4
    y=1;
elseif 4<x && x<=12
    y=x*x-x*sqrt(x)+rand()*10;
elseif x>12
    y=x*x-x*sqrt(x)+rand()*60;
%        y=x*x-x*sqrt(x) ;
end

end

