%% I. ��ջ�������
clear all
clc

%% II. ѵ����/���Լ�����
%%
% 1. ��������
load spectra_data.mat

%%
% 2. �������ѵ�����Ͳ��Լ�
temp = randperm(size(NIR,1));
% ѵ��������50������
P_train = NIR(temp(1:50),:)';
T_train = octane(temp(1:50),:)';
% ���Լ�����10������
P_test = NIR(temp(51:end),:)';
T_test = octane(temp(51:end),:)';
N = size(P_test,2);

%% III. RBF�����紴�����������
%%
% 1. ��������
net = newrbe(P_train,T_train,30);

%%
% 2. �������
T_sim = sim(net,P_test);

%% IV. ��������
%%
% 1. ������error
error = abs(T_sim - T_test)./T_test;

%%
% 2. ����ϵ��R^2
R2 = (N * sum(T_sim .* T_test) - sum(T_sim) * sum(T_test))^2 / ((N * sum((T_sim).^2) - (sum(T_sim))^2) * (N * sum((T_test).^2) - (sum(T_test))^2)); 

%%
% 3. ����Ա�
result = [T_test' T_sim' error']

%% V. ��ͼ
figure
plot(1:N,T_test,'b:*',1:N,T_sim,'r-o')
legend('��ʵֵ','Ԥ��ֵ')
xlabel('Ԥ������')
ylabel('����ֵ')
string = {'���Լ�����ֵ����Ԥ�����Ա�';['R^2=' num2str(R2)]};
title(string)

