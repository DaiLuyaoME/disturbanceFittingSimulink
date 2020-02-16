method = 'zpetc';
[invGp,forwardOrder] = modelBasedFeedforward(GpDis,method);

[delta,~,alpha] = extraCompensation(GpDis,method);

figure;
bodeplot(1/GpDis,invGp,invGp * (1+delta*alpha),Op);
%%
%%
Sp = feedback(GpDis*GcDis,1);
figure;pzmap(Sp);
figure;bodeplot(Sp);
method = 'zpetc';
compensationOrder = 1;
[inverseSp,forwardOrder] = modelBasedFeedforward(Sp,method);
[delta,~] = extraCompensation(Sp,method,compensationOrder);
% inverseSp = inverseSp * lpDis;
figure;bodeplot(1/Sp,inverseSp,inverseSp*(1+delta),Op);
%%
Sp = feedback(GpDis*GcDis,1);
figure;pzmap(Sp);
figure;bodeplot(Sp);
method = 'zmetc';
compensationOrder = 1;
[inverseSp,forwardOrder] = modelBasedFeedforward(Sp,method);
[delta,~] = extraCompensation(Sp,method,compensationOrder);
% inverseSp = inverseSp * lpDis;
compensationOrder = 2;
[inverseSp,forwardOrder] = modelBasedFeedforward(Sp,method);
[delta2,~] = extraCompensation(Sp,method,compensationOrder);
figure;bodeplot(1/Sp,inverseSp,inverseSp*(1+delta),inverseSp*(1+delta2),Op);
%%
Sp = feedback(GpDis*GcDis,1);
figure;pzmap(Sp);
figure;bodeplot(Sp);
method = 'ignore';
compensationOrder = 1;
[inverseSp,forwardOrder] = modelBasedFeedforward(Sp,method);
[delta,~] = extraCompensation(Sp,method,compensationOrder);
% inverseSp = inverseSp * lpDis;
compensationOrder = 2;
[inverseSp,forwardOrder] = modelBasedFeedforward(Sp,method);
[delta2,~] = extraCompensation(Sp,method,compensationOrder);
figure;bodeplot(1/Sp,inverseSp,inverseSp*(1+delta),inverseSp*(1+delta2),Op);