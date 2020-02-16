function [feedforwardController,forwardOrder] = stableApproximation(G,ffMethod)
[~,~,Ts] = tfdata(G,'v');

ffMethod = lower(ffMethod);

switch ffMethod
    case 'zpetc'
        feedforwardController = ZPETC(G);
    case 'zmetc'
        feedforwardController = ZMETC(G);
    case 'ignore'
        feedforwardController = nonminimumIgnore(G);
    case 'seriestruncation'
    otherwise
        
        
        
end

forwardOrder = numel(zero(feedforwardController)) - numel(pole(feedforwardController));


    function F = ZPETC(G)
        %%
        G = tf(G);
        G = minreal(G);
        G.Variable = 'z^-1';
        [z,p,k,Ts] = zpkdata(G,'v');
        % relativeDegree = numel(p) - numel(z);
        bound = 1;
        index = abs(p) >= bound;
        nonminimumPole = p( index );
        minimumPole = p( ~index );
        F = zpk(z,minimumPole,k,Ts,'Variable','z^-1');
%                 F = zpk(p,minimumZero,1,Ts,'Variable','z^-1');
        %%
        %         for i = 1:numel(nonminimumZero)
        %             temp = tf( [-1 * nonminimumZero(i),1] ,1 ,Ts,'variable','z^-1');
        %             F = F * temp * (1 / (abs(1 - nonminimumZero(i))).^2 );
        %         end
        i = 1;
        z = tf('z',Ts);
        while i <= numel(nonminimumPole)
            if(isreal(nonminimumPole(i)))
                %                 temp = tf( [-1 * nonminimumZero(i),1] ,1 ,Ts,'variable','z^-1');
                temp = 1 - nonminimumPole(i) * z;
                F = F * temp * (1 / (abs(1 - nonminimumPole(i))).^2 );
                i = i + 1;
            else
                %                 temp = tf( [ ( abs(nonminimumZero(i)) ).^2 ,-2 * real(nonminimumZero(i)) ,1] ,1 ,Ts,'variable','z^-1');
                temp = 1 - 2 * real(nonminimumPole(i)) * z + ( abs(nonminimumPole(i)) ).^2 * z^2;
                F = F * temp * (1 / ( 1 + ( abs(nonminimumPole(i)) ).^2 -2 * real(nonminimumPole(i))).^2);
                i = i + 2;
            end
            
        end
        %         [b,a,T] = tfdata(F,'v');
        %         F = tf(b,a,T,'variable',F.Variable);
        F = minreal(F * z^(-1*numel(nonminimumPole)));
        
    end

    function F = ZMETC(G)
        %%
        G = tf(G);
        G.Variable = 'z^-1';
        [z,p,k,Ts] = zpkdata(G,'v');
        % relativeDegree = numel(p) - numel(z);
        bound = 1;
        index = abs(z) >= bound;
        nonminimumZero = z( index );
        minimumZero = z( ~index );
        z = tf('z',Ts);
        F = zpk(p,minimumZero,1/k,Ts,'Variable','z^-1');   
        i = 1;

        while i <= numel(nonminimumZero)
            if(isreal(nonminimumZero(i)))
                %                 temp = tf( 1 ,[-1 * nonminimumZero(i),1] ,Ts,'variable','z^-1');
                temp = 1 / ( 1- nonminimumZero(i)* z);
                F = F * temp;
                i = i + 1;
            else
                %                 temp = tf( 1 ,[ ( abs(nonminimumZero(i)) ).^2 ,-2 * real(nonminimumZero(i)) ,1] ,Ts,'variable','z^-1');
                temp = 1 / ( 1 - 2 * real(nonminimumZero(i)) * z + ( abs(nonminimumZero(i)) ).^2 * z^2 );
                F = F * temp ;
                i = i + 2;
            end
            
        end
        
        F = minreal(F * z^(-1*numel(nonminimumZero)));
        %         [b,a,T] = tfdata(F,'v');
        %         F = tf(b,a,T,'variable',F.Variable);
    end

    function F = nonminimumIgnore(G)
        %%
        G = tf(G);
        G.Variable = 'z^-1';
        [z,p,k,Ts] = zpkdata(G,'v');
        % relativeDegree = numel(p) - numel(z);
        bound = 1;
        index = abs(z) > bound;
        nonminimumZero = z( index );
        minimumZero = z( ~index );
        z = tf('z',Ts);
        F = zpk(p,minimumZero,1/k,Ts,'Variable','z^-1');
        for i = 1:numel(nonminimumZero)
            %             temp = tf( [-1 * nonminimumZero(i),1] ,1 ,Ts,'variable','z^-1');
            F = F * (1 / (abs(1 - nonminimumZero(i))) );
        end

        F = minreal(F * z^(-1*numel(nonminimumZero)));
    end

    function F = seriesTruncation(G)
        
    end


end