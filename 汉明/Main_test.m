  clc;
clear all  %��� 
close all; %�ر�֮ǰ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
marginSamples=100; % �ȽϷ�Χ
fftSize=8000;   %fft�������� 
prefix =' G:\ʵ������\test\';
suffix = '*.wav';
dirs=dir(strcat(prefix,suffix));   % ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б����ؽṹ���顣
dircell=struct2cell(dirs)' ;    % �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
filenames=dircell(:,1) ;  % ��һ�����ļ���
[Row,Line]=size(filenames);
for  i=1:2:Row
eval(['L' num2str(ceil(i/2)) '=filenames{i}'';'])  
[c1,Fs]= audioread( strcat(prefix,filenames{i}));
size=size(c1)
i=i+1;
eval(['R' num2str(i/2) '=filenames{i}'';'])  
[c2,Fs]= audioread( strcat(prefix,filenames{i}));
waves1=c1/max(abs(c1));
waves2=c2/max(abs(c2));
estimated_delays1 = GCC(waves1,waves2,fftSize,marginSamples);
if estimated_delays1 >= 0
    Tdoa_flag1 = 1;
else
    Tdoa_flag1 = 0;
end
x(i/2)=Tdoa_flag1;
end
x
% [waves1,Fs]= audioread( strcat('G:\ʵ������\test\L1.wav'));
% [waves2,Fs]= audioread( strcat('G:\ʵ������\test\L1.wav'));
% [waves3,Fs]= audioread( strcat('G:\ʵ������\Node Fixed\6.5-6.5\Y\x_7_y_1_R.wav'));
% [waves4,Fs]= audioread( strcat('G:\ʵ������\Node Fixed\6.5-6.5\Y\x_7_y_1_L.wav'));
% [waves5,Fs]= audioread( strcat('G:\ʵ������\Node Fixed\6.5-6.5\Y\x_7_y_2_R.wav'));
% [waves6,Fs]= audioread( strcat('G:\ʵ������\Node Fixed\6.5-6.5\Y\x_7_y_2_L.wav'));
estimated_delays1 = GCC(waves1,waves2,fftSize,marginSamples);
% estimated_delays2 = GCC(waves3,waves4,fftSize,marginSamples)
% estimated_delays3 = GCC(waves5,waves6,fftSize,marginSamples)
% if estimated_delays1 > 0
%     Tdoa_flag1 = 1
% else
%     Tdoa_flag1 = 0
% end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% estimated_delays2 = GCC(waves3,waves4,fftSize,marginSamples)
% estimated_delays3 = GCC(waves5,waves6,fftSize,marginSamples)





