%% Code section A: plot tracking error
figure;
plot(Err.time,Err.signals.values*1e9,'displayname','tracking error','linewidth',2);
xlim([acc.time(1),acc.time(end)]);
hold on;
temp1=max(abs(Err.signals.values*1e9));
temp2=max(abs(acc.signals.values));
temp3=max(abs(snap.signals.values));
temp4=max(abs(jerk.signals.values));
ratio=temp1/temp2;
ratio31=temp1/temp3;
ratio41 = temp1/temp4;

% To comment these lines to disable scaled plot of corresponding
% derivatives with tracking error.
% plot(acc.time,ratio*acc.signals.values,'DisplayName','scaled acceleration','LineWidth',2);
plot(snap.time,ratio31*snap.signals.values,'DisplayName','scaled snap','LineWidth',2);
% plot(jerk.time,ratio41*jerk.signals.values,'DisplayName','scaled jerk','LineWidth',2);


legend1 = legend(gca,'show');

%% Code section B: plot feedback control signal
figure;
plot(ufb.time,ufb.signals.values,'displayname','feedback control signal','linewidth',2);
xlim([ufb.time(1),ufb.time(end)]);
hold on;
temp1=max(abs(ufb.signals.values));
temp2=max(abs(acc.signals.values));
temp3=max(abs(snap.signals.values));
temp4=max(abs(jerk.signals.values));
ratio=temp1/temp2;
ratio31=temp1/temp3;
ratio41 = temp1/temp4;

% To comment these lines to disable scaled plot of corresponding
% derivatives with feedback control signal.
%  plot(acc.time,ratio*acc.signals.values,'DisplayName','scaled acceleration','LineWidth',2);
 plot(snap.time,ratio31*snap.signals.values,'DisplayName','scaled snap','LineWidth',2);
%  plot(jerk.time, ratio41*jerk.signals.values,'DisplayName','scaled jerk','LineWidth',2);

legend1 = legend(gca,'show');
xlabel('time (s)','fontsize',20);
h = ylabel('control signal (N)','fontsize',20);
set(gca,'fontsize',16);


