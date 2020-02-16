function tempFilter = notchFilter(f,z1,z2)
w = 2*pi*f;
num = [1, 2*z1*w, w*w];
den = [1, 2*z2*w, w*w];
tempFilter = tf(num,den);
end
