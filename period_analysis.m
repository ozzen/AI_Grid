clear; clc;

V = readmatrix("data/Trace_NC_PV.csv");
c = 1;

X1 = fft(V(1:6250,c));
X2 = fft(V(6251:12500,c));
X3 = fft(V(12501:18750,c));
X4 = fft(V(18751:25000,c));

x1 = X1(2:end,1);
x2 = X2(2:end,1);
x3 = X3(2:end,1);
x4 = X4(2:end,1);

X = x1;
X(length(x1)+1:length(x1)+length(x2),1) = x2;
X(length(x1)+length(x2)+1:length(x1)+length(x2)+length(x3),1) = x3;
X(length(x1)+length(x2)+length(x3)+1:length(x1)+length(x2)+length(x3)+length(x4),1) = x4;

% X = X1;
% X(length(X1)+1:length(X1)+length(X2),1) = X2;
% X(length(X1)+length(X2)+1:length(X1)+length(X2)+length(X3),1) = X3;
% X(length(X1)+length(X2)+length(X3)+1:length(X1)+length(X2)+length(X3)+length(X4),1) = X4;

dur = 40;
y = linspace(0,dur,length(X)).';
plot(y,X,'LineWidth',2)
xlim([-2,dur+2])

ylabel('Voltage')
xlabel('Time (sec)')
title('Magnitude Response')