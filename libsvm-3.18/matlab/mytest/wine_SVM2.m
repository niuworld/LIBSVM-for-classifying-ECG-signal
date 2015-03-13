%wine_SVM script by faruto 2009.8.12
%Email:farutoliyang@gmail.com QQ:516667408 blog:http://sina.com.cn/faruto
%www.ilovematlab.cn
clear
clc


load wine_SVM;

train_wine = [wine(1:30,:);wine(60:95,:);wine(131:153,:)];
train_wine_labels = [wine_labels(1:30);wine_labels(60:95);wine_labels(131:153)];


test_wine = [wine(31:59,:);wine(96:130,:);wine(154:178,:)];
test_wine_labels = [wine_labels(31:59);wine_labels(96:130);wine_labels(154:178)];

train_wine = normalization(train_wine',2);
test_wine = normalization(test_wine',2);
train_wine = train_wine';
test_wine = test_wine';


% bestcv = 0;
% for log2c = -10:10,
%   for log2g = -10:10,
%     cmd = ['-v 5 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
%     cv = svmtrain(train_wine_labels, train_wine, cmd);
%     if (cv >= bestcv),
%       bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
%     end
%   end
% end
% fprintf('(best c=%g, g=%g, rate=%g)\n',bestc, bestg, bestcv);
% cmd = ['-c ', num2str(bestc), ' -g ', num2str(bestg)];
% model = svmtrain(train_wine_labels, train_wine, cmd);

model = svmtrain(train_wine_labels, train_wine, '-c 2 -g 0.02 -t 2');

[predict_label, accuracy,dec_values] = svmpredict(test_wine_labels, test_wine, model);

%plot visualization for train_wine
% w = model.SVs' * model.sv_coef;
% b = -model.rho;
% [mm,mn] = size(model.SVs);
% 
% figure;
% hold on;
% [m,n] = size(train_wine);
% for run = 1:m
%     if train_wine_labels(run) == 1
%         h1 = plot( train_wine(run,1),train_wine(run,2),'r+' );
%     else
%         h2 = plot( train_wine(run,1),train_wine(run,2),'g*' );
%     end
%     for i = 1:mm
%         if model.SVs(i,1)==train_wine(run,1) && model.SVs(i,2)==train_wine(run,2)
%             h3 = plot( train_wine(run,1),train_wine(run,2),'o' );
%         end
%     end
% end
% legend([h1,h2,h3],'1','0','Support Vectors');
% hold off;
%web -browser http://www.ilovematlab.cn/thread-47135-1-1.html



