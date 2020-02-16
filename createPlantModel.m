function Gp = createPlantModel(modelInfo)
mass = modelInfo.mass;
fr = modelInfo.fr;
dampingRatio = modelInfo.dampRatio;
modelType = lower(modelInfo.type);
switch modelType
    case 'rigidbody'
        num = 1;
        den = [sum(mass),0,0];
        Gp = tf(num,den);
    case 'doublemassnoncolocated'
        
        m1=mass(1);
        m2=mass(2);
        m=m1+m2;%双质量块模型共振频率
        f1=fr(1);
        w1=f1*2*pi;
        z1=dampingRatio;
        G1=tf(1,[m,0,0]);
        G2=tf([2*z1*w1 w1*w1],[1,2*z1*w1,w1*w1]);
        Gp=G1*G2;
    case 'doublemasscolocated'
        m1=mass(1);
        m2=mass(2);
        m=m1+m2;%双质量块模型共振频率
        f1=fr(1);
        w1=f1*2*pi;
%         k = w1*w1*m1*m2/m;
        z1 = dampingRatio;
%         c1 = 2*z1*sqrt(m1*m2*k/m);
%         w2 = sqrt(k/m2);
        num = [(1+m2/m1),2*z1*w1,w1*w1];
        den = (m1+m2)*[1,2*z1*w1,w1*w1,0,0];
        Gp = tf(num,den);
        
        
end

end
