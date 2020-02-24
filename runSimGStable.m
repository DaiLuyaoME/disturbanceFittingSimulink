modelName = 'mainNewTraj';
%%
set_param([modelName,'/ilcSignal'],'commented','on');
set_param([modelName,'/GStable'],'commented','on');
sim(modelName,[0 0.18]);
error1 = Err.signals.values;
%%
method = 'zpetc';
set_param([modelName,'/ilcSignal'],'commented','on');
set_param([modelName,'/GStable'],'commented','off');
set_param([modelName,'/GStable'],'sys','GStable');
sim(modelName,[0 0.18]);
error2 = Err.signals.values;
%%
% method = 'zpetc';
% set_param([modelName,'/ilcSignal'],'commented','on');
% set_param([modelName,'/GStable'],'commented','off');
% set_param([modelName,'/GStable'],'sys','GStableNew');
% sim(modelName,[0 0.3]);
% error3 = Err.signals.values;
%%
figure;
h0 = plot(Err.time,[error1,error2]*1e9,'lineWidth',2);
h0(2).Color = 'g';
xlabel('time (s)');
ylabel('error (nm)');

accData = acc.signals.values;
ratio = max(max(abs([error1,error2]*1e9))) / max(abs(accData));
hold on;
plot(Err.time,ratio * accData,'linewidth',2,'color','r');
% h = legend('$e$','$\hat{e}$','scaled acc');
h = legend('$e_1$','$e_2$','scaled acceleration');
h.Interpreter = 'latex';
set(gca,'fontsize',16);
%%
figure;
h0 = plot(Err.time,error2*1e9,'lineWidth',2);
xlabel('time (s)');
ylabel('error (nm)');

accData = acc.signals.values;
ratio = max(max(abs(error2*1e9))) / max(abs(accData));
hold on;
plot(Err.time,ratio * accData,'linewidth',2);
h = legend('进一步采用额外补偿后跟踪误差','scaled acceleration');
h.Interpreter = 'latex';
set(gca,'fontsize',14);