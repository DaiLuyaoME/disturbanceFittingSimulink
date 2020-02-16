function [delta,forwardOrder] = calculateDelta(mv,ma,mj,md,Ts,methodType)
z = tf('z',Ts);
switch lower(methodType)
    case 'zpetc'
        delta = 1+ mv * 0.5 * (1 + z) * ((1-z^-1)/Ts) + ma * z * ((1-z^-1)/Ts)^2 + mj * z * (z+1) * 0.5 * ((1-z^-1)/Ts)^3 + md * z^2 * ((1-z^-1)/Ts)^4;
    case 'zmetc'
        %         delta = 1 + mv *((1-z^-1)/Ts) + ma * ((1-z^-1)/Ts)^2 + mj * z * (z+1) * 0.5 * ((1-z^-1)/Ts)^3 + md * ((1-z^-1)/Ts)^4;
%         delta = 1 + mv *((1-z^-1)/Ts) + ma * ((1-z^-1)/Ts)^2 + mj * ((1-z^-1)/Ts)^3 + md * ((1-z^-1)/Ts)^4;
        delta = 1 + mv * z * ((1-z^-1)/Ts) + ma * z^2 * ((1-z^-1)/Ts)^2 + mj * z^3 * ((1-z^-1)/Ts)^3 + md * z^4 * ((1-z^-1)/Ts)^4;
    case 'ignore'
        delta = 1 + mv *  ((1-z^-1)/Ts) + ma * ((1-z^-1)/Ts)^2 + mj * ((1-z^-1)/Ts)^3 + md * ((1-z^-1)/Ts)^4;
    otherwise
        
end
forwardOrder = numel(zero(delta))  - numel(pole(delta));
% delta = delta * z^(-1 * forwardOrder);
delta = minreal(delta);


end
