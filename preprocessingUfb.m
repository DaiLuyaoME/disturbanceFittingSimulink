feedbackControlSignal = ufb.signals.values;
fbFilter = designfilt('lowpassiir', 'FilterOrder', 4, 'PassbandFrequency', 40, 'PassbandRipple', 0.01, 'SampleRate', 5000);
ufbF = filtfilt(fbFilter,feedbackControlSignal);
figure;
plot([feedbackControlSignal,ufbF]);
% %%
% errorTuned = Err;
% %%
% plotError(Err.time,Err.signals.values*1e9,'tracking error under ideal feedforward');
% xlim([acc.time(1),acc.time(end)]);
% hold on;
% plot(errorTuned.time,errorTuned.signals.values*1e9,'linewidth',2,'displayname','tracking error under tuned feedforward','linestyle','--');
% legend1 = legend(gca,'show');
% legend1.FontSize = 10;
