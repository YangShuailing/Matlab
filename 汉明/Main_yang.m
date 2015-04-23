clc;
clear all  %清除 
close all; %关闭之前数据
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 变量
marginSamples=15; % 比较范围
fftSize=44100;   %fft采样点数 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Old Method
% filename1 =' G:\实测数据\Node Fixed\4.5-4.5\Y\';
% filename2 =' G:\实测数据\Node Fixed\4.5-4.5\X\';
% dirs1=dir('G:\实测数据\Node Fixed\4.5-4.5\Y\*.wav');   % 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
% dirs2=dir('G:\实测数据\Node Fixed\4.5-4.5\X\*.wav');   % 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
% dircell1=struct2cell(dirs1)' ;    % 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
% filenames1=dircell1(:,1) ;  % 第一列是文件名
% dircell2=struct2cell(dirs2)' ;    % 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
% filenames2=dircell2(:,1);  % 第一列是文件名
% filenames1=sort_nat(filenames1); 
% filenames2=sort_nat(filenames2) ;
% [Row,Line]=size(filenames1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% New Method 
prefix1 ='G:\实测数据\M3测试数据\节点位置固定\7.5_10.5\X方向\';%输入目录  路径1
prefix2 ='G:\实测数据\M3测试数据\节点位置固定\7.5_10.5\Y方向\';%输入目录 路径2 
suffix = '*.wav';%文件后缀名
dirs1=dir(strcat(prefix1,suffix));   % 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
dircell=struct2cell(dirs1)' ;    % 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
filenames1=dircell(:,1) ;  % 第一列是文件名
filenames1=sort_nat(filenames1); 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dirs2=dir(strcat(prefix2,suffix));   % 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
dircel2=struct2cell(dirs2)' ;    % 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
filenames2=dircel2(:,1) ;  % 第一列是文件名
filenames2=sort_nat(filenames2); 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TDOA_Flag1 = estimated( prefix1,filenames1,fftSize,marginSamples ) ; %计算得到的0、1串
TDOA_Flag2 = estimated( prefix2,filenames2,fftSize,marginSamples );  %计算得到的0、1串
TDOA_Flag  = [TDOA_Flag1,TDOA_Flag2]

save TDOA_Flag.dat  TDOA_Flag 