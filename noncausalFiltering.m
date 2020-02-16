function filteredData = noncausalFiltering(data,noncausalFilter,filteringMethod)
if nargin == 2
    filteringMethod = 'filter';
%     filteringMethod = 'conv';
end

if strcmp(filteringMethod ,'filter')
forwardOrder = numel(zero(noncausalFilter)) - numel(pole(noncausalFilter));
noncausalFilter.Variable = 'z^-1';
Ts = noncausalFilter.Ts;
z = tf('z',Ts);

causalFilter = noncausalFilter * z^(-1*forwardOrder);
casualFilter= minreal(causalFilter);
figure;impulse(causalFilter);
[b,a] = tfdata(causalFilter,'v');
filteredData = filter(b,a,data);
filteredData = circshift(filteredData,-1*forwardOrder);

elseif strcmp(filteringMethod,'conv')
forwardOrder = numel(zero(noncausalFilter)) - numel(pole(noncausalFilter));
noncausalFilter.Variable = 'z^-1';
Ts = noncausalFilter.Ts;
z = tf('z',Ts);

causalFilter = noncausalFilter * z^(-1*forwardOrder);
casualFilter= minreal(causalFilter);
num = numel(data);
[h,t] = impulse(causalFilter,(num -1) * Ts);
h = h * Ts;
filteredData = conv(h,data);
filteredData = filteredData(1:num);

filteredData = circshift(filteredData,-1*forwardOrder);
    
    
end




end