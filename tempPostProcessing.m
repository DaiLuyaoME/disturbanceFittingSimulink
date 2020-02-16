error1 = Err.signals.values;
out1 = out.signals.values;
%%
error2 = Err.signals.values;
out2 = out.signals.values;
time = out.time;
%%
error3 = Err.signals.values;
out3 = out.signals.values;
%%
figure;
plot(time,1e6*error1);
hold on;
plot(time,1e6*error2);
%%
figure;
plot(time,1e6*out1);
hold on;
plot(time,1e6*out2);

%%
figure;
plot(time,1e6*error1);
hold on;
plot(time,1e6*error2);
plot(time,1e6*error3);
%%
figure;
plot(time,1e6*out1);
hold on;
plot(time,1e6*out2);
plot(time,1e6*out3);
%%
figure;
plot([alpha1,alpha2,alpha3,alpha4,alpha5,alpha6,alpha7,alpha8])
%%
time = noise.time;
noiseValue = noise.signals.values;
figure;
plot(time,noiseValue,'linewidth',2);
ylabel('\mu m');
xlabel('Ê±¼ä (s)');
grid on;
set(gca,'fontsize',14);
%%
fn = 700;
zeta = 0.06
wn = fn * 2 * pi;
m1 = 5; m2 = 20;
k = wn * wn * m1 * m2 /(m1+m2);
c = 2*zeta*wn*m1 * m2 /(m1+m2);
tempG = tf(1,[c,k]);

Op=bodeoptions;
Op.FreqUnits='Hz';
Op.xlim={[1  500]};
Op.PhaseVisible = 'on';
Op.Grid='on';

figure;
bodeplot(tempG,Op);