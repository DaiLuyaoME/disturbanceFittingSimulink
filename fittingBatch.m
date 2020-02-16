close all;
%% data preprocessing
% index = ilcSignal.time >= 0.02 & ilcSignal.time <= 0.07;
indexData = 95:360;
% indexU = [96:106,158:168,283:293,347:357];
indexU = [158:168,283:293,347:357];
disturbance = ilcData(indexData);
num = numel(disturbance);
figure;plot(disturbance);
figure;plot(ilcData);
%%
trajOrigin = snap.signals.values;
% trajOrigin = [diff(snap.signals.values);0];
trajOrigin = circshift(trajOrigin,-4);
traj = trajOrigin(indexData);
figure;plot(traj);
% traj = trajData(:,3) * 1e-3;
% traj = trajData(:,2) * 1e-3;
%% batch processing
numM = 20;
numN = 20;
optimalValue = 1e20;
mnBuffer = zeros(numM*numN,2);
valueBuffer = zeros(numM*numN,1);
count = 0;
LSMethod = 'ls';
% % LSMethod = 'weightedLS';
%
% Sp = feedback(GpDis,GcDis);
% tFinal =  (num - 1) * 1/5000;
% [y,t] = impulse(Sp,tFinal);
% y = y/5000;
% % figure;plot(y);
% SpToeplitz = tril( toeplitz(y) );


for i = 0:numM
    for j = 0:numN
        count = count + 1;
        m = i;
        n = j;
        mnBuffer(count,:) = [m,n];
        k0 = max(n,m);
        startPoint = 0;
        d = zeros(num-k0-startPoint,1);
        A = zeros(num-k0-startPoint,n+m+1);
        
        for k = 1:num-k0-startPoint
            d(k) = disturbance(k+k0 + startPoint);
            tempD = -1 * disturbance(k+k0 -1 + startPoint : -1 : k + k0 - n + startPoint)';
            tempR = traj(k+k0 + startPoint  : -1 : k+k0 - m + startPoint)';
            A(k,:) = [tempD,tempR];
        end
        switch LSMethod
            case 'ls'
                coef = A\d; % LS
                temp = ones(size(d));
                tempIndex = indexU - k0 - startPoint - 95;
                temp(tempIndex) = 1;
                W = diag(temp);
                coef = inv(A'*W*A) * (A'*W*d);
            case 'weightedLS'
                coef = A'*(SpToeplitz'*SpToeplitz)*A \ (A'*(SpToeplitz'*SpToeplitz)*d); % weighted LS
        end
        a = [1;coef(1:n)];
        b = coef(n+1:end);
        %%
        G = tf(b',a',1/5000,'variable','z^-1');
        method = 'zpetc';
        [GStable,forwardOrder] = stableApproximation(G,method);
        z = tf('z',1/5000);
        GStableCausal = minreal(GStable*z^(-1*forwardOrder));
        GStableCausal.Variable = 'z^-1';
        [b,a] = tfdata(GStableCausal,'value');
        mBuffer{count} = b;
        nBuffer{count} = a;
        %%
        fittedD = filter(b,a,traj);
        tempData = [disturbance,fittedD];
        tempData = tempData( startPoint+1:num+ startPoint,:);
        switch LSMethod
            case 'ls'
                tempValue = norm(tempData(:,1) - tempData(:,2));
            case 'weightedLS'
                tempValue = norm( SpToeplitz * (tempData(:,1) - tempData(:,2)) );
        end
        valueBuffer(count) = tempValue;
        if (tempValue < optimalValue)
            optimalValue = tempValue;
            optimalCoef = coef;
            optimalFittedD = fittedD;
            optimalGStableCausal = GStableCausal;
            optimalM = i;
            optimalN = j;
            optimalB = b;
            optimalA = a;
            
        end
    end
end
%%
figure;
tempData = [disturbance,optimalFittedD];
plot(tempData);

%%
[sortedValue,index] = sort(valueBuffer);
sortedMNBuffer = mnBuffer(index,:);
sortedMBuffer = mBuffer(index);
sortedNBuffer = nBuffer(index);
figure;plot(sortedValue(1:20));
%%
% tempValues = ufb.signals.values * 0;
% tempValues(indexData) = optimalFittedD;
% ilcSignal.signals.values = tempValues;
% sim('main',[0 0.1]);
