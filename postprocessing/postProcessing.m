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
plot(acc.time,ratio*acc.signals.values,'DisplayName','scaled acceleration','LineWidth',2);
% plot(snap.time,ratio31*snap.signals.values,'DisplayName','scaled snap','LineWidth',2);
% plot(jerk.time,ratio41*jerk.signals.values,'DisplayName','scaled jerk','LineWidth',2);


legend1 = legend(gca,'show');

%% Code section B: plot feedback control signal
data = [Err.signals.values,error4] * 1e9;
figure;
h = plot(Err.time,data,'linewidth',2);
h(2).Color = 'g';
accData = acc.signals.values;
ratio = max( max( abs(data) ) ) / max(accData);
hold on;
plot(Err.time,accData * ratio,'linewidth',2,'color','r');
xlabel('time (s)');
ylabel('error (nm)');
h = legend('$e_{1}$','$e_{2}$','scaled acceleration');
h.Interpreter = 'latex';
set(gca,'fontsize',16);
%% fitting error plot
fittingValues = [1.078, 0.3411, 0.3088, 0.2735, 0.01032, 0.0103, 0.0103,0.0103,0.01032];
xIndex = 1:numel(fittingValues);
xIndex = xIndex - 1;
figure;plot(xIndex,fittingValues,'linewidth',2);
h = xlabel('$d$');
h.Interpreter = 'latex';
ylabel('fitting error (N)');
%% fitting result plot
figure;
h = plot(Err.time,tempData,'linewidth',2);
h(2).LineStyle = '--';
h(2).Color = 'g';
accData = acc.signals.values;
ratio = max( max( abs(tempData) ) ) / max(accData);
hold on;
plot(Err.time,accData * ratio,'linewidth',2,'color','r');
xlabel('time (s)');
ylabel('fitting result (N)');
h = legend('ILC signal','fitting result','scaled acceleration');
h.Interpreter = 'latex';
set(gca,'fontsize',16);
%% bode plot of the inversion plant
z = tf('z',Ts);
differenceOperator = (z-1)/Ts;
F = accCoef * differenceOperator^2 + jerkCoef * differenceOperator^3 + snapCoef * differenceOperator^4;
FDeltaF = F + GStable * z^4 * differenceOperator^4;
figure;h = bodeplot(F,FDeltaF,1/GpDis);
p = getoptions(h); 
p.PhaseMatching = 'on'; 
p.PhaseMatchingFreq = 1; 
p.PhaseMatchingValue = -180;
setoptions(h,p);
%%
figure;h = bodeplot(minreal(GStable * z^4))
p = getoptions(h); 
p.PhaseMatching = 'on'; 
p.PhaseMatchingFreq = 1; 
p.PhaseMatchingValue = 0;
setoptions(h,p);
%%
% error1 = Err.signals.values;
% %%
% error2 = Err.signals.values;
% %%
error3 = Err.signals.values;

%%
errorData = [error1,error2,error3] * 1e9;
figure;
h = plot(Err.time,errorData,'linewidth',2);
h(2).Color = 'g';
accData = acc.signals.values;
ratio = max( max( abs(errorData) ) ) / max(accData);
hold on;
plot(Err.time,accData * ratio,'linewidth',2,'color','r');
xlabel('time (s)');
ylabel('error (nm)');
h = legend('$e_{1}$','$e_{2}$','$e_{3}$','scaled acceleration');
h.Interpreter = 'latex';
set(gca,'fontsize',16);