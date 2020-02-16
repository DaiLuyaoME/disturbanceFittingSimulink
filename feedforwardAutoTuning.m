%% code section A: tuning of acc ff
feedbackControlSignal = ufb.signals.values;
accSignal = acc.signals.values;
simTime = ufb.time;

startTime = 0.008;
endTime = 0.042;

beginIndex = find(simTime > startTime);
endIndex = find(simTime > endTime);

A = accSignal(beginIndex:endIndex);
b = feedbackControlSignal(beginIndex:endIndex);
accCoefEstimated = inv(A'*A) * A' * b;
msgbox(sprintf('The tuned acceleration feedforward coefficient is %.4f kg',accCoefEstimated));
%% code section B: tuning of jerk ff
feedbackControlSignal = ufb.signals.values;
jerkSignal = jerk.signals.values;
simTime = ufb.time;

startTime = 0.0;
endTime = 0.0472;

beginIndex = find(simTime > startTime);
endIndex = find(simTime > endTime);

A = jerkSignal(beginIndex:endIndex);
b = feedbackControlSignal(beginIndex:endIndex);
jerkCoefEstimated = inv(A'*A) * A' * b;
msgbox(sprintf('The tuned jerk feedforward coefficient is %.4f kg.s',jerkCoefEstimated));
%% code section C: joint tuning of acc and jerk ff
feedbackControlSignal = ufb.signals.values;
accSignal = acc.signals.values;
jerkSignal = jerk.signals.values;
simTime = ufb.time;

startTime = 0.0;
endTime = 0.0472;

beginIndex = find(simTime > startTime);
endIndex = find(simTime > endTime);
dataIndex = beginIndex:endIndex;

A = [accSignal(dataIndex),jerkSignal(dataIndex)];
b = feedbackControlSignal(dataIndex);
deltaEstimated = inv(A'*A) * A' * b;
accCoefNew = accCoefEstimated + deltaEstimated(1);
jerkCoefNew = jerkCoefEstimated + deltaEstimated(2);
msgbox(sprintf('The tuned acc feedforward coefficient is %.4f kg, jerk feedforward coefficient is %.4f kg.s',accCoefNew, jerkCoefNew));
%% code section D: joint tuning of acc, jerk, snap ff
accSignal = acc.signals.values;
jerkSignal = jerk.signals.values;
snapSignal = snap.signals.values;
trajSignal = [accSignal,jerkSignal,snapSignal];

startTime = 0.0;
endTime = 0.0472;
beginIndex = find(simTime > startTime);
endIndex = find(simTime > endTime);

A = trajSignal(beginIndex:endIndex,:); 
% b = feedbackControlSignal(beginIndex:endIndex);
b = ufbF(beginIndex:endIndex,:);

coefEstimated = inv(A'*A) * A' * b;

accCoefLast = accCoefNew + coefEstimated(1);
jerkCoefLast = jerkCoefNew + coefEstimated(2);
snapCoefLast = coefEstimated(3);

msgbox(sprintf('The tuned acc feedforward coefficient is %.4f kg, jerk feedforward coefficient is %.4f kg.s, snap feedforward coefficient is %.4e kg.s^2',accCoefLast, jerkCoefLast,snapCoefLast));



