%wine_SVM script by faruto 2009.8.12
%Email:farutoliyang@gmail.com QQ:516667408 blog:http://sina.com.cn/faruto
%www.ilovematlab.cn

load wine_SVM;

data = [wine(:,1), wine(:,2)];

groups = ismember(wine_labels,1); % not familiar with ismember? help... help...

[train, test] = crossvalind('holdOut',groups); % not familiar with crossvalind? help... help...
%train and test here are logical format

train_wine = data(train,:);
train_wine_labels = groups(train,:);
train_wine_labels = double( train_wine_labels );
%in the usage of libsvm, the label vector and instance matrix must be
%double. So we have to transfer the format of labels in this case.

test_wine = data(test,:);
test_wine_labels = groups(test,:);
test_wine_labels = double( test_wine_labels );

train_wine = normalization(train_wine',2);
test_wine = normalization(test_wine',2);
train_wine = train_wine';
test_wine = test_wine';


% bestcv = 0;
% for log2c = -5:5,
%   for log2g = -5:5,
%     cmd = ['-v 5 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
%     cv = svmtrain(train_wine_labels, train_wine, cmd);
%     if (cv >= bestcv),
%       bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
%     end
%   end
% end
% fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
% cmd = ['-c ', num2str(bestc), ' -g ', num2str(bestg)];
% model = svmtrain(train_wine_labels, train_wine, cmd);

model = svmtrain(train_wine_labels, train_wine, '-c 1 -g 0.07');

[predict_label, accuracy,dec_values] = svmpredict(test_wine_labels, test_wine, model);

%plot visualization for train_wine
% w = model.SVs' * model.sv_coef;
% b = -model.rho;
[mm,mn] = size(model.SVs);

figure;
hold on;
[m,n] = size(train_wine);
for run = 1:m
    if train_wine_labels(run) == 1
        h1 = plot( train_wine(run,1),train_wine(run,2),'r+' );
    else
        h2 = plot( train_wine(run,1),train_wine(run,2),'g*' );
    end
    for i = 1:mm
        if model.SVs(i,1)==train_wine(run,1) && model.SVs(i,2)==train_wine(run,2)
            h3 = plot( train_wine(run,1),train_wine(run,2),'o' );
        end
    end
end
legend([h1,h2,h3],'1','0','Support Vectors');
hold off;




