outBuffer = [outBuffer,out.signals.values];
%%
num = size(outBuffer,1);
tempTime = ((1:num) - 1) * 1/5000;
figure;
plot(tempTime * 1000,outBuffer(:,1:3) * 1e6);
%%
figure;
plot(out.time,out.signals.values * 1e6,'linewidth',2);
hold on;
plot(out.time,ones(size(out.time)) * 30);
ylabel('step response (\mum)');
xlabel('time (s)');
set(gca,'fontsize',16);