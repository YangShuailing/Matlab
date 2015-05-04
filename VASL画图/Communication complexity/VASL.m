function y1 = VASL( x )
%VASL 此处显示有关此函数的摘要
%   此处显示详细说明
if x<13
   y1=x*sqrt(x) *0.8+rand()*10;
 
elseif x>=13
    y1=x*sqrt(x) *0.8+rand()*40;
end
%     y1=x*sqrt(x) *0.8 ;

end

