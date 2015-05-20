function [ est_CMDS ] = mds_node( Microphone_Center_Location,My )
%MDS_NODE 输入距离和基准坐标系，输入坐标
%   此处显示详细说明
D = My';
[a,b]=cmdscale(D);
a=a(:,1:2);
[D,Z,transform] = procrustes(Microphone_Center_Location(1:3,:),a(1:3,:));
c = transform.c;
T = transform.T;
b = transform.b;
ec=[c(1,1) c(1,2)];
[M,N]=size(Microphone_Center_Location);
cc= kron(ec,ones(M,1));
Z1 = b*a*T + cc;
[D,Z,transform] = procrustes(Microphone_Center_Location,a);
est_CMDS=Z;

end

