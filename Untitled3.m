optimalB = sortedMBuffer{1};
optimalA = sortedNBuffer{1};

%%
temp = filter(optimalB,optimalA,trajOrigin);
figure;plot([ilcData,temp]);
%%
G = tf(optimalB,optimalA,1/5000,'variable','z^-1');
method = 'zpetc';
figure;pzmap(G);
[GStable,forwardOrder] = stableApproximation(G,method);
figure;pzmap(GStable);
figure;bodeplot(G,GStable);
%%
z = tf('z',Ts);
compensator = 1 + 4.5 * (1 - z^-1);
GStableNew = GStable * compensator;
%%
ilcSignal.signals.values = temp;
sim(modelName,[0 0.3]);
%%
accData = acc.signals.values;
jerkData = jerk.signals.values;
snapData = snap.signals.values;
trajData = [accData,jerkData,snapData];
%%
fittedData = myNeuralNetworkFunction(accData);
figure;plot([ilcData,fittedData]);
%%
-3.6250e-06