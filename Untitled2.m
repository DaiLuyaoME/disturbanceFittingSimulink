accData = acc.signals.values;
snapData = snap.signals.values;
ratioAcc = max(abs(ilcData)) / max(abs(accData));
ratioSnap = max(abs(ilcData)) / max(abs(snapData));
figure;
plot(acc.time,[ilcData,accData * ratioAcc,snapData * ratioSnap]);
%%
figure;
plot(acc.time,ilcData);