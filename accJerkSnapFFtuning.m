close all;
modelName = 'mainNewTraj';
set_param([modelName,'/ilcSignal'],'commented','on');
set_param([modelName,'/GStable'],'commented','on');
accCoef = 0;
jerkCoef = 0;
snapCoef = 0;
%% 第一次acc,jerk,snap前馈整定
sim(modelName,[0 0.18]);
RunSimZPETC;% 生成迭代学习信号
close all;

accData = acc.signals.values;
jerkData = jerk.signals.values;
snapData = snap.signals.values;
% 拟合迭代学习信号得到acc, jerk, snap前馈系数
A = [accData,jerkData,snapData];
b = ilcData;
x = A\b;
accCoef = x(1);
jerkCoef = x(2);
snapCoef = x(3);
%% 第二次acc,jerk,snap前馈整定
set_param([modelName,'/ilcSignal'],'commented','on');
set_param([modelName,'/GStable'],'commented','on');
sim(modelName,[0 0.18]);
RunSimZPETC; % 生成迭代学习信号；
close all;
accData = acc.signals.values;
jerkData = jerk.signals.values;
snapData = snap.signals.values;
% 拟合迭代学习信号；
A = [accData,jerkData,snapData];
b = ilcData;
x = A\b;
accCoef = x(1) + accCoef;
jerkCoef = x(2) + jerkCoef;
snapCoef = x(3) + snapCoef;
%% 测试整定好的acc,jerk,snap前馈效果
set_param([modelName,'/ilcSignal'],'commented','on');
set_param([modelName,'/GStable'],'commented','on');
sim(modelName,[0 0.18]);
%% 绘制在整定好的acc,jerk,snap前馈作用下，跟踪误差效果
figure;
h0 = plot(Err.time,Err.signals.values*1e9,'lineWidth',2);
xlabel('time (s)');
ylabel('error (nm)');

accData = acc.signals.values;
ratio = max(max(abs(error2*1e9))) / max(abs(accData));
hold on;
plot(Err.time,ratio * accData,'linewidth',2);
h = legend('$e$','scaled acc');
h.Interpreter = 'latex';
set(gca,'fontsize',14);