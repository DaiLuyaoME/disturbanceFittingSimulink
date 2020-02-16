function [compensationPart,forwardOrder] = extraCompensation(G,ffMethod,compensationOrder)
if nargin == 2
    compensationOrder = 1;
end


[~,~,Ts] = tfdata(G,'v');




ffMethod = lower(ffMethod);

switch ffMethod
    case 'zpetc'
        compensationPart = ZPETC(G,compensationOrder);
    case 'zmetc'
        compensationPart = ZMETC(G,compensationOrder);
    case 'ignore'
        compensationPart = nonminimumIgnore(G,compensationOrder);
    case 'seriestruncation'
    otherwise
        
        
        
end

forwardOrder = numel(zero(compensationPart)) - numel(pole(compensationPart));


    function F = ZPETC(G,compensationOrder)
        %%
        [z,p,k,Ts] = zpkdata(G,'v');
        % relativeDegree = numel(p) - numel(z);
        bound = 1;
        index = abs(z) >= bound;
        nonminimumZero = z( index );
        alpha1 = -1 * Ts * Ts * sum( nonminimumZero./(1 - nonminimumZero).^2 );
        z = tf('z',Ts);
        phai1 = (1-z^-1)/Ts;
        phai2 = phai1^2;
        F = minreal(-alpha1 * z * phai2);

        
        
    end

    function F = ZMETC(G,compensationOrder)
        %%
        [z,p,k,Ts] = zpkdata(G,'v');
        % relativeDegree = numel(p) - numel(z);
        bound = 1;
        index = abs(z) >= bound;
        nonminimumZero = z( index );
        num = numel(nonminimumZero);
        alpha1 =  Ts * sum( 2 * nonminimumZero ./ (1 - nonminimumZero) );
        alpha2 = 0;
        for i = num:-1:2
            for j = 1:i-1
                    alpha2 = alpha2 + 4 * Ts * Ts * nonminimumZero(i) *  nonminimumZero(j) / ( (1-nonminimumZero(i)) * (1 - nonminimumZero(j)) );
                
            end
            
        end
        for i = 1:num
                beta = nonminimumZero(i);
                alpha2 = alpha2 + (3*beta^2-beta)*Ts^2 / (beta - 1)^2;
        end
        
        z = tf('z',Ts);
        phai1 = (1-z^-1)/Ts;
        phai2 = phai1^2;
        if(compensationOrder == 1)
            F = minreal( -alpha1 *  phai1);
        elseif (compensationOrder == 2)
            
            alpha2 = real(alpha2);
            F = minreal( -alpha1 * z * phai1 + (alpha1^2 - alpha2) * z^2 * phai2 );
        else
        end
        
    end

    function F = nonminimumIgnore(G,compensationOrder)
        %%
        [z,p,k,Ts] = zpkdata(G,'v');
        % relativeDegree = numel(p) - numel(z);
        bound = 1;
        index = abs(z) >= bound;
        nonminimumZero = z( index );
        num = numel(nonminimumZero);
        alpha1 = Ts * sum( nonminimumZero ./ (1 - nonminimumZero) );
        alpha2 = 0;
        for i = num:-1:2
            for j = 1:i-1
                if ( j~=i)
                    alpha2 = alpha2 +  Ts * Ts * nonminimumZero(i) *  nonminimumZero(j) / ( (1-nonminimumZero(i)) * (1 - nonminimumZero(j)) );
                end
            end
        end
        z = tf('z',Ts);
        phai1 = (1-z^-1)/Ts;
        phai2 = phai1^2;
        alpha2 = real(alpha2);
        if(compensationOrder == 1)
            F = minreal( -alpha1 *  phai1);
        elseif (compensationOrder == 2)
            F = minreal( -alpha1 * phai1 + (alpha1^2 - alpha2) * phai2 );
        else
        end
        
    end

    function F = seriesTruncation(G)
        
    end


end