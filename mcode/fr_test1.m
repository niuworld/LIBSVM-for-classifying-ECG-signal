




ecgpuwave('100','test');
[tm,signal]=rdsamp('100');
pwaves=rdann('100','test',[],[],[],'p');
plot(tm,signal(:,1));hold on;grid on
plot(tm(pwaves),signal(pwaves),'or')