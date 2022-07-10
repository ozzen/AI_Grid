clear;
clc;

% Initial States
Id2 = -0.618249003;
Iq2 = -2.68e-07;
Vd2 = 0.485249524;
Vq2 = -0.018170484;
VBat2ds = 0.246385332;
VBat2qs = 1.1901986;

dt = 0.0001;

% ODEsolver
for i = 1:600000
    t = 0:dt:2*dt;
    tic;
    [t,x] = ode45(@(t,x)der_dyn(t,x),t,[Id2;Iq2;Vd2;Vq2;VBat2ds;VBat2qs]);
    toc;
    s(i,:) = x(2,:);
    Id2 = x(2,1);
    Iq2 = x(2,2);
    Vd2 = x(2,3);
    Vq2 = x(2,4);
    VBat2ds = x(2,5);
    VBat2qs = x(2,6);
end

X = (linspace(0,i*dt,length(s))).';
plot(X,s(:,3))

% Dynamic Equations
function f = der_dyn(t,z)

R = 0.01;
L = 0.005;
C = 200;
K = 20;

Id2 = z(1);
Iq2 = z(2);
Vd2 = z(3);
Vq2 = z(4);
VBat2ds = z(5);
VBat2qs = z(6);

w = 1/(2*pi*60);
Id2_ref = -0.618;
Iq2_ref = 0.0;

f = zeros(size(z));

f(1) = -(R/L)*Id2 + w*Iq2 - (VBat2ds - Vd2)/L;
f(2) = -(R/L)*Iq2 - w*Id2 - (VBat2qs - Vq2)/L;
f(3) = w*Vd2 - (Id2_ref - Id2)/C;
f(4) = -w*Vq2 - (Iq2_ref - Iq2)/C;
f(5) = Vd2 + w*L*Iq2 - K*(Id2_ref - Id2);
f(6) = Vq2 - w*L*Id2 - K*(Iq2_ref - Iq2);

end
