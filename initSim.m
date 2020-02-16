%% model parameters
modelTypeName = {'rigidBody','doubleMassNonColocated','doubleMassColocated'};
modelInfo.mass = [5,20];
modelInfo.fr = 200;
modelInfo.dampRatio = 0.03;
modelInfo.type = modelTypeName{2};
fs = 5000;
Ts = 1/fs;
Gp = createPlantModel(modelInfo);

%% delay factor
delayCount = 2.5;
s = tf('s');
delayModel = exp(-delayCount*Ts*s);
delayModel = pade(delayModel,2);

%% generate plant model with delay
GpWithDelay = Gp * delayModel;
GpDis = c2d(GpWithDelay,Ts,'zoh');
figure;pzmap(GpDis);



%% ideal feedforward coefficients 
tau = (delayCount + 0.5) * Ts;
wn = modelInfo.fr * 2 * pi;
m = modelInfo.mass;
accCoef = sum(m);
jerkCoef = sum(m) * tau;
snapCoef = sum(m) * ( 1/wn.^2 + 0.5 * tau.^2);
% idealAccCoef = sum(m);
% idealJerkCoef = sum(m) * tau;
% idealSnapCoef = sum(m) * ( 1/wn.^2 + 0.5 * tau.^2);
%%
sigma = 2;%噪声的标准差，单位m
varNoise=sigma*sigma;%注意，白噪声的模块中的Noise Power 需要填成varNoise*Ts
noisePower=varNoise*Ts;
%%
A1 = 8;
A2 = 5;
A3 = 3;