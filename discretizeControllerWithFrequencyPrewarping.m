function C = discretizeControllerWithFrequencyPrewarping(Gc,f,fs)
%%
% Gc: Continuous controller
% f: prewarping frequency
% fs: sampling frequency
w = f*2*pi;
Ts = 1/fs;
discopts = c2dOptions('Method','tustin','PrewarpFrequency',w);
C = c2d(Gc,Ts,discopts);
% bodeplot(C);
end
