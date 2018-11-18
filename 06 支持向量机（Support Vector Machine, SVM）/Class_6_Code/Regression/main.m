%% I. ��ջ�������
clear all
clc

%% II. ��������
load concrete_data.mat

%%
% 1. �������ѵ�����Ͳ��Լ�
n = randperm(size(attributes,2));

%%
% 2. ѵ��������80������
p_train = attributes(:,n(1:80))';
t_train = strength(:,n(1:80))';

%%
% 3. ���Լ�����23������
p_test = attributes(:,n(81:end))';
t_test = strength(:,n(81:end))';

%% III. ���ݹ�һ��
%%
% 1. ѵ����
[pn_train,inputps] = mapminmax(p_train');
pn_train = pn_train';
pn_test = mapminmax('apply',p_test',inputps);
pn_test = pn_test';

%%
% 2. ���Լ�
[tn_train,outputps] = mapminmax(t_train');
tn_train = tn_train';
tn_test = mapminmax('apply',t_test',outputps);
tn_test = tn_test';

%% IV. SVMģ�ʹ���/ѵ��
%%
% 1. Ѱ�����c����/g����
[c,g] = meshgrid(-10:0.5:10,-10:0.5:10);
[m,n] = size(c);
cg = zeros(m,n);
eps = 10^(-4);
v = 5;
bestc = 0;
bestg = 0;
error = Inf;
for i = 1:m
    for j = 1:n
        cmd = ['-v ',num2str(v),' -t 2',' -c ',num2str(2^c(i,j)),' -g ',num2str(2^g(i,j) ),' -s 3 -p 0.1'];
        cg(i,j) = svmtrain(tn_train,pn_train,cmd);
        if cg(i,j) < error
            error = cg(i,j);
            bestc = 2^c(i,j);
            bestg = 2^g(i,j);
        end
        if abs(cg(i,j) - error) <= eps && bestc > 2^c(i,j)
            error = cg(i,j);
            bestc = 2^c(i,j);
            bestg = 2^g(i,j);
        end
    end
end

%%
% 2. ����/ѵ��SVM  
cmd = [' -t 2',' -c ',num2str(bestc),' -g ',num2str(bestg),' -s 3 -p 0.01'];
model = svmtrain(tn_train,pn_train,cmd);

%% V. SVM����Ԥ��
[Predict_1,error_1] = svmpredict(tn_train,pn_train,model);
[Predict_2,error_2] = svmpredict(tn_test,pn_test,model);

%%
% 1. ����һ��
predict_1 = mapminmax('reverse',Predict_1,outputps);
predict_2 = mapminmax('reverse',Predict_2,outputps);

%%
% 2. ����Ա�
result_1 = [t_train predict_1];
result_2 = [t_test predict_2];

%% VI. ��ͼ
figure(1)
plot(1:length(t_train),t_train,'r-*',1:length(t_train),predict_1,'b:o')
grid on
legend('��ʵֵ','Ԥ��ֵ')
xlabel('�������')
ylabel('��ѹǿ��')
string_1 = {'ѵ����Ԥ�����Ա�';
           ['mse = ' num2str(error_1(2)) ' R^2 = ' num2str(error_1(3))]};
title(string_1)
figure(2)
plot(1:length(t_test),t_test,'r-*',1:length(t_test),predict_2,'b:o')
grid on
legend('��ʵֵ','Ԥ��ֵ')
xlabel('�������')
ylabel('��ѹǿ��')
string_2 = {'���Լ�Ԥ�����Ա�';
           ['mse = ' num2str(error_2(2)) ' R^2 = ' num2str(error_2(3))]};
title(string_2)

%% VII. BP������
%%
% 1. ����ת��
pn_train = pn_train';
tn_train = tn_train';
pn_test = pn_test';
tn_test = tn_test';

%%
% 2. ����BP������
net = newff(pn_train,tn_train,10);

%%
% 3. ����ѵ������
net.trainParam.epochs = 1000;
net.trainParam.goal = 1e-3;
net.trainParam.show = 10;
net.trainParam.lr = 0.1;

%%
% 4. ѵ������
net = train(net,pn_train,tn_train);

%%
% 5. �������
tn_sim = sim(net,pn_test);

%%
% 6. �������
E = mse(tn_sim - tn_test);

%%
% 7. ����ϵ��
N = size(t_test,1);
R2=(N*sum(tn_sim.*tn_test)-sum(tn_sim)*sum(tn_test))^2/((N*sum((tn_sim).^2)-(sum(tn_sim))^2)*(N*sum((tn_test).^2)-(sum(tn_test))^2)); 

%%
% 8. ����һ��
t_sim = mapminmax('reverse',tn_sim,outputps);

%%
% 9. ��ͼ
figure(3)
plot(1:length(t_test),t_test,'r-*',1:length(t_test),t_sim,'b:o')
grid on
legend('��ʵֵ','Ԥ��ֵ')
xlabel('�������')
ylabel('��ѹǿ��')
string_3 = {'���Լ�Ԥ�����Ա�(BP������)';
           ['mse = ' num2str(E) ' R^2 = ' num2str(R2)]};
title(string_3)