function y1 = VASL( x )
%VASL �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
if x<13
   y1=x*sqrt(x) *0.8+rand()*10;
 
elseif x>=13
    y1=x*sqrt(x) *0.8+rand()*40;
end
%     y1=x*sqrt(x) *0.8 ;

end

