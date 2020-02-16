close all;
%%
fn = 1000;
wn = fn * 2 * pi;
zeta = 0.7;
lp = tf(wn * wn, [1, 2 * zeta * wn, wn * wn]);
lpDis = c2d(lp,1/5000,'tustin');
figure;bodeplot(lpDis);
%% 设置伯德图绘制偏好
f_start = 1; 
f_end  = 2500; 
Op=bodeoptions;
Op.FreqUnits='Hz';
Op.xlim={[f_start  f_end]};
Op.PhaseVisible = 'on';
Op.Grid='on';
Op.PhaseMatching='on';
Op.PhaseMatchingFreq=10;
Op.PhaseMatchingValue=0;
%%
Sp = feedback(GpDis*GcDis,1);
figure;pzmap(Sp);
figure;bodeplot(Sp);
%%
method = 'ignore';
compensationOrder = 2;
[inverseSp,forwardOrder] = modelBasedFeedforward(Sp,method);
[delta,~] = extraCompensation(Sp,method,compensationOrder);
% inverseSp = inverseSp * lpDis;
figure;bodeplot(1/Sp,inverseSp,inverseSp*(1+delta),Op);
%%
% wout = logspace(0,3,10000);
% [mag1,phase1,wout] = bode(inverseSp,wout);
% [mag2,phase2,wout] = bode(1+delta,wout);
% mag1 = squeeze(mag1);
% mag2 = squeeze(mag2);
% phase1 = squeeze(phase1);
% phase2 = squeeze(phase2);
% mag = mag1 .* mag2;
% phase = phase1 + phase2;
% res = mag.* exp(1i * phase);
% inverseNew = frd(res,wout);
% figure;
% bodeplot(1/Sp,inverseSp,inverseNew,Op);




%% 预处理反馈控制信号
ufbSignal = ufb.signals.values;
figure;plot(ufbSignal);
fbFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', 2500, 'PassbandRipple', 0.01, 'SampleRate', 5000);
filterdUfb = filtfilt(fbFilter,ufbSignal);
figure;plot([ufbSignal,filterdUfb]);
%% 生成迭代学习信号
ilcSignal = noncausalFiltering(filterdUfb-filterdUfb(1),inverseSp);
figure;plot(ilcSignal);
% ilcSignalRevised = ilcSignal + noncausalFiltering(filterdUfb-filterdUfb(1),inverseSp * delta * alpha);
ilcSignalRevised =  ilcSignal + noncausalFiltering(ilcSignal,minreal(delta));
% ilcSignalRevised =  ilcSignal(1:end-2) + diff(diff(ilcSignal)) * alpha * 5000;
figure;plot([ilcSignal,ilcSignalRevised]);
filteredILCsignal = filtfilt(fbFilter,ilcSignal);
filteredILCsignalRevised = filtfilt(fbFilter,ilcSignalRevised);
figure;plot([filteredILCsignal,filteredILCsignalRevised]);
%% 分析迭代学习信号频谱
figure;powerSpectralAnalysis([filteredILCsignal,filteredILCsignalRevised],5000);
%% 对比不同迭代学习信号；
figure;plot([ufbSignal-ufbSignal(1),filteredILCsignal,filteredILCsignalRevised,filterdUfb - filterdUfb(1)],'linewidth',2);
%% 生成迭代学习文件
ilcSignal = ufb;
ilcSignal.signals.values = filteredILCsignalRevised;
% ilcSignal.signals.values = filteredILCsignal;
% ilcSignal.signals.values = filterdUfb-filterdUfb(1);

