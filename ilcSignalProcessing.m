ufbSignal = ufb.signals.values;
fbFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', 40, 'PassbandRipple', 0.01, 'SampleRate', 5000);
ufbF = filtfilt(fbFilter,ufbSignal);
figure;
plot([ufbSignal,ufbF]);
ilcSignal = ufb;
ilcSignal.signals.values = ufbF;
%%
ilcSignal = ufb;
figure;
plot(ilcSignal.signals.values);
