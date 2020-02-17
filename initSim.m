%% 模型参数
modelTypeName = {'rigidBody','doubleMassNonColocated','doubleMassColocated'};
modelInfo.mass = [5,20]; % 质量分布
modelInfo.fr = 700; % 共振频率
modelInfo.dampRatio = 0.03; % 结构阻尼比
modelInfo.type = modelTypeName{2}; % 选用non-collocated形式的双质量块模型
fs = 5000; % 采样频率
Ts = 1/fs;
Gp = createPlantModel(modelInfo); % 生成模型

%% 延时环节
delayCount = 2.5; % 加入2.5个伺服周期的延时环节
s = tf('s');
delayModel = exp(-delayCount*Ts*s);
delayModel = pade(delayModel,2); % 采用二阶帕德逼近近似延时环节

%% generate plant model with delay， 生成含延时的模型
GpWithDelay = Gp * delayModel;
GpDis = c2d(GpWithDelay,Ts,'zoh');
figure;pzmap(GpDis); % 绘制零极点分布图

%% 载入反馈控制器
load GcDis176Hz.mat;

% %% ideal feedforward coefficients 
% tau = (delayCount + 0.5) * Ts;
% wn = modelInfo.fr * 2 * pi;
% m = modelInfo.mass;
% accCoef = sum(m);
% jerkCoef = 2/3 * sum(m) * tau;
% snapCoef = sum(m) * ( 1/wn.^2 + 0.5 * tau.^2)-3.6250e-06;
% % idealAccCoef = sum(m);
% % idealJerkCoef = sum(m) * tau;
% % idealSnapCoef = sum(m) * ( 1/wn.^2 + 0.5 * tau.^2);
% %%
% sigma = 2;%噪声的标准差，单位m
% varNoise=sigma*sigma;%注意，白噪声的模块中的Noise Power 需要填成varNoise*Ts
% noisePower=varNoise*Ts;
% %%
% A1 = 8;
% A2 = 5;
% A3 = 3;