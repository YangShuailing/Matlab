clc;
clear all  %��� 
close all; %�ر�֮ǰ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ����
marginSamples=15; % �ȽϷ�Χ
fftSize=44100;   %fft�������� 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Old Method
% filename1 =' G:\ʵ������\Node Fixed\4.5-4.5\Y\';
% filename2 =' G:\ʵ������\Node Fixed\4.5-4.5\X\';
% dirs1=dir('G:\ʵ������\Node Fixed\4.5-4.5\Y\*.wav');   % ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б����ؽṹ���顣
% dirs2=dir('G:\ʵ������\Node Fixed\4.5-4.5\X\*.wav');   % ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б����ؽṹ���顣
% dircell1=struct2cell(dirs1)' ;    % �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
% filenames1=dircell1(:,1) ;  % ��һ�����ļ���
% dircell2=struct2cell(dirs2)' ;    % �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
% filenames2=dircell2(:,1);  % ��һ�����ļ���
% filenames1=sort_nat(filenames1); 
% filenames2=sort_nat(filenames2) ;
% [Row,Line]=size(filenames1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% New Method 
prefix1 ='G:\ʵ������\M3��������\�ڵ�λ�ù̶�\7.5_10.5\X����\';%����Ŀ¼  ·��1
prefix2 ='G:\ʵ������\M3��������\�ڵ�λ�ù̶�\7.5_10.5\Y����\';%����Ŀ¼ ·��2 
suffix = '*.wav';%�ļ���׺��
dirs1=dir(strcat(prefix1,suffix));   % ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б����ؽṹ���顣
dircell=struct2cell(dirs1)' ;    % �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
filenames1=dircell(:,1) ;  % ��һ�����ļ���
filenames1=sort_nat(filenames1); 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dirs2=dir(strcat(prefix2,suffix));   % ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б����ؽṹ���顣
dircel2=struct2cell(dirs2)' ;    % �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
filenames2=dircel2(:,1) ;  % ��һ�����ļ���
filenames2=sort_nat(filenames2); 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TDOA_Flag1 = estimated( prefix1,filenames1,fftSize,marginSamples ) ; %����õ���0��1��
TDOA_Flag2 = estimated( prefix2,filenames2,fftSize,marginSamples );  %����õ���0��1��
TDOA_Flag  = [TDOA_Flag1,TDOA_Flag2]

save TDOA_Flag.dat  TDOA_Flag 