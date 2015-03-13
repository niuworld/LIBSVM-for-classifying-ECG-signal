function MIV = SVMMIV(y,x,model)
% by faruto @ faruto's Studio~
% http://blog.sina.com.cn/faruto
% Email:faruto@163.com
% last modified 2010.11.29
%% ≥ı ºªØ
[m,n] = size(x);
xup = cell(n,1);
xdown = cell(n,1);
MIV = zeros(n,1);
yup = zeros(m,n);
ydown = zeros(m,n);
mseup = zeros(n,1);
msedown = zeros(n,1);
%% xup xdown
for i = 1:n
    xup{i} = x;
    xdown{i} = x;
    xup{i}(:,i) = x(:,i).*1.1;
    xdown{i}(:,i) = x(:,i).*0.9;
    
    [py, mse] = svmpredict(y, xup{i}, model);
    yup(:,i) = py;
    mseup(i) = mse(2);
    [py, mse] = svmpredict(y, xdown{i}, model);
    ydown(:,i) = py;
    msedown(i) = mse(2);
    
end
IV = yup - ydown;
temp = mean(IV);
MIV = temp';
