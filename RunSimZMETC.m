close all;
set_param('main/ilcSignal','commented','on')
sim('main',[0 0.5]);
ufbSignal = ufb.signals.values;
error1 = Err.signals.values;
%%
method = 'zmetc';
set_param('main/ilcSignal','commented','off');
[inverseSp,forwardOrder] = modelBasedFeedforward(Sp,method);
% ufbSignal = ufb.signals.values;
% ilcData = noncausalFiltering(ufbSignal-ufbSignal(1),inverseSp);
ilcSignal = ufb;
sim('main',[0 0.5]);
error2 = Err.signals.values;
%%
set_param('main/ilcSignal','commented','off');
[inverseSp,forwardOrder] = modelBasedFeedforward(Sp,method);
ilcData = noncausalFiltering(ufbSignal-ufbSignal(1),inverseSp);
ilcSignal = ufb;
ilcSignal.signals.values = ilcData;
sim('main',[0 0.5]);
error3 = Err.signals.values;
%%
set_param('main/ilcSignal','commented','off');
compensationOrder = 1;
[inverseSp,forwardOrder] = modelBasedFeedforward(Sp,method);
[delta,~] = extraCompensation(Sp,method,compensationOrder);
ilcData = noncausalFiltering(ufbSignal-ufbSignal(1),inverseSp);
ilcData =  ilcData + noncausalFiltering(ilcData,minreal(delta));
ilcSignal = ufb;
ilcSignal.signals.values = ilcData;
sim('main',[0 0.5]);
error4 = Err.signals.values;
%%
set_param('main/ilcSignal','commented','off');
compensationOrder = 2;
[inverseSp,forwardOrder] = modelBasedFeedforward(Sp,method);
[delta,~] = extraCompensation(Sp,method,compensationOrder);
ilcData = noncausalFiltering(ufbSignal-ufbSignal(1),inverseSp);
ilcData =  ilcData + noncausalFiltering(ilcData,minreal(delta));
ilcSignal = ufb;
ilcSignal.signals.values = ilcData;
sim('main',[0 0.5]);
error5 = Err.signals.values;
%%
figure;
h0 = plot(Err.time,[error1,error2,error3,error4,error5]*1e6,'lineWidth',2);
% h0(4).LineStyle = '--';
xlabel('time (s)');
ylabel('error (\mum)');
h = legend('$e$','$e_{u_{fb}}$','$\hat{e}$','$\hat{e}_{1}$','$\hat{e}_{2}$');
h.Interpreter = 'latex';
set(gca,'fontsize',14);
ylim([-15,15]);
