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
dur = 5;
T = dur/dt;

% ODEsolver
for i = 1:T
    t = 0:dt:2*dt;
    tic;
    [t,x] = ode45(@(t,x)bess_dyn(t,x),t,[Id2;Iq2;Vd2;Vq2;VBat2ds;VBat2qs]);
    toc;
    s(i,:) = x(2,:);
    Id2 = x(2,1);
    Iq2 = x(2,2);
    Vd2 = x(2,3);
    Vq2 = x(2,4);
    VBat2ds = x(2,5);
    VBat2qs = x(2,6);
end

% Plot Data
X = (linspace(0,i*dt,length(s))).';
plot(X,s(:,1),LineWidth=1)
hold on
plot(X,s(:,2),LineWidth=1)
hold on
plot(X,s(:,3),LineWidth=1)
hold on
plot(X,s(:,4),LineWidth=1)
hold on
plot(X,s(:,5),LineWidth=1)
hold on
plot(X,s(:,6),LineWidth=1)

legend('Id2','Iq2','Vd2','Vq2','VBat2ds','VBat2qs')

% Performance Metrics
for i = 1:6
    metric(1,i) = mean(s(:,i));
    metric(2,i) = std(s(:,i));
end

% Dynamic Equations
function f = bess_dyn(t,z)

R = 0.01;
L1 = 0.005;
L2 = 10;
C = 200;
K = 0.01;
w = 1/(2*pi*60);
I_mg_d = 0.16;
I_mg_q = 0.09;
V_mg_d = 12.47;
V_mg_q = 0.66;
Id2_ref = -0.618;
Iq2_ref = 0.0;

Id2 = z(1);
Iq2 = z(2);
Vd2 = z(3);
Vq2 = z(4);
VBat2ds = z(5);
VBat2qs = z(6);

f = zeros(size(z));

f(1) = -(R/L1)*Id2 + w*Iq2 + (Vd2 - V_mg_d)/L2;
f(2) = -(R/L1)*Iq2 - w*Id2 + (Vq2 - V_mg_q)/L2;
f(3) = w*Vd2 - (Id2_ref - Id2 + I_mg_d)/C;
f(4) = -w*Vq2 - (Iq2_ref - Iq2 + I_mg_q)/C;
f(5) = K*Vd2 + w*L1*Iq2 - K*(Id2_ref - Id2);
f(6) = K*Vq2 -w*L1*Id2 - K*(Iq2_ref - Iq2);

end