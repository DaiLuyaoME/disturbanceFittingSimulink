modelName = 'main';
modelName = 'mainNewTraj';
%%
set_param([modelName,'/ilcSignal'],'commented','on')
sim(modelName,[0 0.3]);
ufbSignal = ufb.signals.values;
error1 = Err.signals.values;
Sp = feedback(GpDis*GcDis,1);
%%
method = 'zpetc';
set_param([modelName,'/ilcSignal'],'commented','off');
[inverseSp,forwardOrder] = modelBasedFeedforward(Sp,method);
% ufbSignal = ufb.signals.values;
% ilcData = noncausalFiltering(ufbSignal-ufbSignal(1),inverseSp);
ilcSignal = ufb;
sim(modelName,[0 0.3]);
error2 = Err.signals.values;
%%
method = 'zpetc';
set_param([modelName,'/ilcSignal'],'commented','off');
[inverseSp,forwardOrder] = modelBasedFeedforward(Sp,method);
ilcData = noncausalFiltering(ufbSignal-ufbSignal(1),inverseSp);
ilcSignal = ufb;
ilcSignal.signals.values = ilcData;
sim(modelName,[0 0.3]);
error3 = Err.signals.values;
%%
set_param([modelName,'/ilcSignal'],'commented','off');
compensationOrder = 1;
[inverseSp,forwardOrder] = modelBasedFeedforward(Sp,method);
[delta,~] = extraCompensation(Sp,method,compensationOrder);
ilcData = noncausalFiltering(ufbSignal-ufbSignal(1),inverseSp);
ilcData =  ilcData + noncausalFiltering(ilcData,minreal(delta));
ilcSignal = ufb;
ilcSignal.signals.values = ilcData;
sim(modelName,[0 0.3]);
error4 = Err.signals.values;
%%
figure;
h0 = plot(Err.time,[error1,error2,error3,error4]*1e6,'lineWidth',2);
h0(4).LineStyle = '--';
xlabel('time (s)');
ylabel('error (\mum)');
h = legend('$e$','$e_{u_{fb}}$','$\hat{e}$','$\hat{e}_{2}$');
h.Interpreter = 'latex';
set(gca,'fontsize',14);
% ylim([-15,15]);
