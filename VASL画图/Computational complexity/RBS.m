function y = RBS( x )
%RBS �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
if x>=0&&x<=4
    y=1;
elseif x>4
    y=x*x-x*sqrt(x)+rand();
end

end

