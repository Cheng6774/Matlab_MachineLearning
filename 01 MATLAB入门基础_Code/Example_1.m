%% I. ��ջ�������������
clear all   % ���Workspace�е����б���
clc         % ���Command Window�е���������

%% II. �����������
%%
% 1. ���������ִ�Сд
A = 2
a = 3

%%
% 2. ���������Ȳ�����63λ
% ABCDEFGHIJKLMNOPQRSTUVWXYZ123456ABCDEFGHIJKLMNOPQRSTUVWXYZ123456 = 3

%%
% 3. ����������ĸ��ͷ����������ĸ�����ֺ��»�����ɣ�������ʹ�ñ��
% 3A = 4
% .a = 5
% /b = 5
a_2 = 3
% a.2 = 4

%%
% 4. ������Ӧ������ˣ�ͨ������������ֱ�ۿ�����������ʾ����������
A = rand(3,5)
rows = size(A, 1)
cols = size(A, 2)

%% III. MATLAB��������
%%
% 1. ����
2 + 4

10 - 7

3 * 5

8 / 2

%%
% 2. �ַ����ַ���
s = 'a'
abs(s)
char(65)
num2str(65)

str = 'I Love MATLAB & Machine Learning.'

length(str)

doc num2str

%%
% 3. ����
A = [1 2 3; 4 5 2; 3 2 7]
B = A'
C = A(:)
D = inv(A)
A * D

E = zeros(10,5,3)
E(:,:,1) = rand(10,5)
E(:,:,2) = randi(5, 10,5)
E(:,:,3) = randn(10,5)

%%
% 4. Ԫ������
A = cell(1, 6)
A{2} = eye(3)
A{5} = magic(5)
B = A{5}

%%
% 5. �ṹ��
books = struct('name',{{'Machine Learning','Data Mining'}},'price',[30 40])
books.name
books.name(1)
books.name{1}

%% IV. MATLAB�������
%%
% 1. ����Ķ����빹��
A = [1 2 3 5 8 5 4 6]
B = 1:2:9
C = repmat(B, 3, 1)
D = ones(2, 4)

%%
% 2. �������������
A = [1 2 3 4; 5 6 7 8]
B = [1 1 2 2; 2 2 1 1]
C = A + B
D = A - B
E = A * B'
F = A .* B
G = A / B     % G * B = A     G * B * pinv(B) = A * pinv(B)    G = A * pinv(B)
H = A ./ B

%% 
% 3. ������±�
A = magic(5)
B = A(2,3)
C = A(3,:)
D = A(:,4)
[m, n] = find(A > 20)

%% V. MATLAB�߼������̿���
%%
% 1. if ... else ... end
A = rand(1,10)
limit = 0.75;

B = (A > limit);   % B is a vector of logical values
if any(B)
  fprintf('Indices of values > %4.2f: \n', limit);
  disp(find(B))
else
  disp('All values are below the limit.')
end

%%
% 2. for ... end
k = 10;
hilbert = zeros(k,k);      % Preallocate matrix

for m = 1:k
    for n = 1:k
        hilbert(m,n) = 1/(m+n -1);
    end
end
hilbert

%% 
% 3. while ... end
n = 1;
nFactorial = 1;
while nFactorial < 1e100
    n = n + 1;
    nFactorial = nFactorial * n;
end
n

factorial(69)
factorial(70)

prod(1:69)
prod(1:70)

%%
% 4. switch ... case ... end
mynumber = input('Enter a number:');

switch mynumber
    case -1
        disp('negative one');
    case 0
        disp('zero');
    case 1
        disp('positive one');
    otherwise
        disp('other value');
end

%% VI. MATLAB�ű��뺯���ļ�
%%
% 1. �ű��ļ�
myScript

%%
% 2. �����ļ�
mynumber = input('Enter a number:');
output = myFunction(mynumber)

%% VII. MATLAB������ͼ����
%%
% 1. ��άƽ���ͼ
x = 0:0.01:2*pi;
y = sin(x);
figure
plot(x, y)
title('y = sin(x)')
xlabel('x')
ylabel('sin(x)')
xlim([0 2*pi])

x = 0:0.01:20;
y1 = 200*exp(-0.05*x).*sin(x);
y2 = 0.8*exp(-0.5*x).*sin(10*x);
figure
[AX,H1,H2] = plotyy(x,y1,x,y2,'plot');
set(get(AX(1),'Ylabel'),'String','Slow Decay') 
set(get(AX(2),'Ylabel'),'String','Fast Decay') 
xlabel('Time (\musec)') 
title('Multiple Decay Rates') 
set(H1,'LineStyle','--')
set(H2,'LineStyle',':')

%%
% 2. ��ά�����ͼ
t = 0:pi/50:10*pi;
plot3(sin(t),cos(t),t)
xlabel('sin(t)')
ylabel('cos(t)')
zlabel('t')
grid on
axis square

%%
% 3. ͼ�εı����뵼��

% (1) Edit �� Copy Figure
% (2) Toolbar �� Save
% (3) print('-depsc','-tiff','-r300','picture1')
% (4) File �� Export Setup

%% VIII. MATLAB�ļ�����
%%
% 1. mat��ʽ
save data.mat x y1 y2
clear all
load data.mat

%%
% 2. txt��ʽ
M = importdata('myfile.txt');

S = M.data;
save 'data.txt' S -ascii
T = load('data.txt');

isequal(S, T)

%%
% 3. xls��ʽ
xlswrite('data.xls',S)
W = xlsread('data.xls');
isequal(S, W)

xlswrite('data.xlsx',S)
U = xlsread('data.xlsx');
isequal(S, U)

%% 
% 4. csv��ʽ
csvwrite('data.csv',S)
V = csvread('data.csv');
isequal(S, V)

