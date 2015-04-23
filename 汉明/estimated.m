function x= estimated( prefix ,filenames,fftSize,marginSamples )
%ESTIMATED 此处显示有关此函数的摘要
%   此处显示详细说明
[Row,Line]=size(filenames);
for  i=1:2:Row
% eval(['R'num2str(ceil(i/2)) '=filenames{i}'])  
R=filenames{i};
[c1,Fs]= audioread( strcat(prefix ,filenames{i}));
i=i+1;
%  eval(['L'num2str(i/2) '=filenames{i}'];);
L=filenames{i};
[c2,Fs]= audioread( strcat(prefix ,filenames{i}));

waves1=c1/max(abs(c1));
waves2=c2/max(abs(c2));

estimated_delays = GCC(waves1,waves2,fftSize,marginSamples);

if estimated_delays >= 0
    Tdoa_flag = 0;
else
    Tdoa_flag = 1;
end

x(i/2)=Tdoa_flag;

end

end

