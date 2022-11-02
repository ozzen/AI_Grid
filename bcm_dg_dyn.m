clear;
clc;

% Duration
dt = 0.0001;
dur = 5;
T = dur/dt;

% Initial States
Tm = 0.060946;
W = 2*pi*59.9999;
Vcon = -0.037065;
Efd = 1.00404;
Eq1 = -1.40674;
Ed1 = 0.155879;
PsiD1 = 1.41782;
PsiQ1 = 0.161502;

% ODEsolver
for i = 1:T
    t = 0:dt:2*dt;
    [t,x] = ode45(@(t,x)dg_dyn(t,x),t,[Tm;W;Vcon;Efd;Eq1;Ed1;PsiD1;PsiQ1]);
    s(i,:) = x(2,:);
    Tm = x(2,1);
    W = x(2,2);
    Vcon = x(2,3);
    Efd = x(2,4);
    Eq1 = x(2,5);
    Ed1 = x(2,6);
    PsiD1 = x(2,7);
    PsiQ1 = x(2,8);
end

% Plot Data
X = (linspace(0,i*dt,length(s))).';
plot(X,s(:,2),LineWidth=1)

% Dynamic Equations
function f = dg_dyn(t,z)

Ws = 2*pi*60;
Pref = 0.5;
Qref = 0.2;
Vref = 1.0;
m = 0;

k1 = 1/50;
k2 = 1000;
k3 = 1/10;
k4 = 1/30;

H = 0.267;
D = 0.1;
Rs = 0.10634;
Xd0 = 1.55;
Xd1 = 0.28;
Xd2 = 0.106;
Xq0 = 1.55;
Xq1 = 0.552;
Xq2 = 0.1676;
Xl = 0.01;
Td1 = 6.5;
Td2 = 0.0086;
Tq1 = 0.62;
Tq2 = 0.0065;

Id = 0.0246;
Iq = 0.0175;

Tm = z(1);
W = z(2);
Vcon = z(3);
Efd = z(4);
Eq1 = z(5);
Ed1 = z(6);
PsiD1 = z(7);
PsiQ1 = z(8);

Pmech = W*Tm;
Ed2 = Ed1*((Xq2 - Xl)/(Xq1 - Xl)) + PsiQ1*((Xq1 - Xq2)/(Xq1 - Xl));
Eq2 = Eq1*((Xd2 - Xl)/(Xd1 - Xl)) + PsiD1*((Xd1 - Xd2)/(Xd1 - Xl));
PsiD0 = -Id*Xd2 - Eq2;
PsiQ0 = -Iq*Xd2 - Ed2;
Vdterm = Ed2*(1 + Ws - W) - Rs*Id + Xq2*Iq;
Vqterm = Eq2*(1 + Ws - W) - Rs*Iq - Xd2*Id;

P = 0.45;
Q = 0.19;

f = zeros(size(z));

f(1) = (1 - m)*k1*(Pref - P) + m*k2*(1 - W/Ws);
f(2) = ((Pmech - D*W)/(1 + Ws - W) - (PsiD1*Iq - PsiQ1*Id))/(2*H);
f(3) = (1 - m)*k3*(Qref - Q) + m*(Vref - Vdterm);
f(4) = k4*(Vref + Vcon - Vdterm);
f(5) = (Efd - Eq1 - (Xd0 - Xd1)*(Id - ((Xd1 - Xd2)*(PsiD1 + (Xd1 - Xl)*Id - Eq1))/(Xd1 - Xl)^2))/Td1;
f(6) = (-Ed1 + (Xq0 - Xq1)*(Iq - ((Xq1 - Xq2)*(-PsiQ1 + (Xq1 - Xl)*Iq + Ed1))/(Xq1 - Xl)^2))/Tq1;
f(7) = (-PsiD1 - (Xd1 - Xl)*Id + Eq1)/Td2;
f(8) = (-PsiQ1 + (Xq1 - Xl)*Iq + Ed1)/Tq2;

end