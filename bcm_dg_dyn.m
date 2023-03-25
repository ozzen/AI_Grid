clear;
clc;

Tr = readmatrix('data/Trace_DG_analytics.csv');

% Duration
dt = 0.0001;
dur = 5;
T = dur/dt;

% DG constants
Ws = 2*pi*60;
Pref = 0.5;
Qref = 0.2;
Vref = 1.0;
m = 0;

k1 = 1/50;
k2 = 1/20;
k3 = 0.001;
k4 = 1/75;

H = 2.67;
D = 0.01;
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

% Initial States
Tm = 0.060946154;
W = 376.9936884/Ws;
Vcon = -0.037064465;
Efd = 1.058443204;
Eq1 = -1.408598162;
Ed1 = 0.138065683;
PsiD1 = 1.418440417;
PsiQ1 = 0.143443337;

% ODEsolver
for i = 1:T

%     if i < T/2
%         m = 0;
%     else
%         m = 1;
%     end

    t = 0:dt:2*dt;
    P = Tr(i,9);
    Q = Tr(i,10);
    Id = Tr(i,11);
    Iq = Tr(i,12);
    Vd = Tr(i,13)/12.47;
%     PsiD1 = Tr(i,7);
%     PsiQ1 = Tr(i,8);

    Pmech = W*Tm;
    Ed2 = Ed1*((Xq2 - Xl)/(Xq1 - Xl)) + PsiQ1*((Xq1 - Xq2)/(Xq1 - Xl));
    Vdterm = Ed2*(1 + Ws - W) - Rs*Id + Xq2*Iq;

    [t,x] = ode45(@(t,x) ...
        [(1 - m)*k1*(Pref - P) + m*k2*(1 - W); ...
         ((Tm*W - D*W)/(1 + W) - (PsiD1*Iq - PsiQ1*Id))/(2*H*1000); ...
         (1 - m)*k3*(Qref - Q) + m*(Vref - Vdterm); ...
          k4*(Vref - Vd - Vcon); ...
         (-PsiD1 + 1.42 - (Xd1 - Xl)*Id)/(Td1*Td1); ...
         (-PsiQ1 + 0.142 + (Xq1 - Xl)*Iq)/Tq1;], ...
         t,[Tm;W;Vcon;Efd;PsiD1;PsiQ1]);
    
    s(i,:) = x(2,:);
    Tm = x(2,1);
    W = x(2,2);
    Vcon = x(2,3);
    Efd = x(2,4);
%     Eq1 = x(2,5);
%     Ed1 = x(2,6);
    PsiD1 = x(2,5);
    PsiQ1 = x(2,6);

    Xxx(i,1) = Tm*W;
    Xxx(i,2) = D*W;
    Xxx(i,3) = (1 + W);
    Xxx(i,4) = Xxx(i,1) - Xxx(i,2);
    Xxx(i,5) = Xxx(i,4) / Xxx(i,3);
    Xxx(i,6) = (PsiD1*Iq - PsiQ1*Id);
    Xxx(i,7) = Xxx(i,5) - Xxx(i,6);
    
end

% Performance Metrics and Plot data
n = 2;

for i = 1:T
    Diff(i,1) = abs(s(i,n) - Tr(i,n));
    mean_diff = mean(Diff);
end

X = (linspace(0,i*dt,length(s))).';
plot(X,s(:,n),LineWidth=1)
hold on
plot(X,Tr(1:50000,n)/Ws,LineWidth=1)
legend('MATLAB','RTDS')