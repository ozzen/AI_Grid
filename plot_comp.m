clear; clc;

%% Generating average traces for different lengths
% p1 = load("Trace_1.csv");
% p2 = load("Trace_2.csv");
% p3 = load("Trace_3.csv");
% p4 = load("Trace_4.csv");
% p5 = load("Trace_5.csv");
% p6 = load("Trace_6.csv");
% p7 = load("Trace_7.csv");
% p8 = load("Trace_8.csv");
% p9 = load("Trace_9.csv");
% p10 = load("Trace_10.csv");
% 
% for i = 1:12
%     for j = 1:length(p1)
%         A(j,i) = (p1(j,i) + p2(j,i) + p3(j,i) + p4(j,i) + p5(j,i)) / 5;
%     end
% end
% 
% for i = 1:12    
%     for j = 1:length(p6)
%         B(j,i) = (p6(j,i) + p7(j,i) + p8(j,i) + p9(j,i) + p10(j,i)) / 5;
%     end
% end

%% Plot performance comparing traces of different length
% A = readmatrix("Data/Trace_short.csv");
% B = readmatrix("Data/Trace_long.csv");
% 
% x_A = linspace(0,3,30000);
% x_B = linspace(0,60,600000);
% 
% plot(x_A,A(:,10))
% hold on
% plot(x_B,B(:,10))

%% Performance comparison between controllers
% Vd2_original = load("data/Trace_rtds.csv");
% Vd2_learned = load("data/Trace_matlab.csv");
% x = linspace(0,60,500);
% 
% plot(x,Vd2_original(1:100:50000,1),'r')
% hold on
% plot(x,Vd2_learned(1:100:50000,1),'b')
% ylim([0.48515,0.48535])
% xlabel('Time (s)')
% ylabel('Voltage (kV)')
% legend('RTDS','Matlab')
% title('Vd2 Comparison')
% 
% % mse = immse(VBat_original(:,2),VBat_learned(:,2));

%% Data variance computation to determine model uncertainties
% n = 10;
% T = 6000;
% Z = n*(n-1)/2;
% 
% t1 = readmatrix("Data/Trends/Trace_trend_1.csv");
% t2 = readmatrix("Data/Trends/Trace_trend_2.csv");
% t3 = readmatrix("Data/Trends/Trace_trend_3.csv");
% t4 = readmatrix("Data/Trends/Trace_trend_4.csv");
% t5 = readmatrix("Data/Trends/Trace_trend_5.csv");
% t6 = readmatrix("Data/Trends/Trace_trend_6.csv");
% t7 = readmatrix("Data/Trends/Trace_trend_7.csv");
% t8 = readmatrix("Data/Trends/Trace_trend_8.csv");
% t9 = readmatrix("Data/Trends/Trace_trend_9.csv");
% t10 = readmatrix("Data/Trends/Trace_trend_10.csv");
% 
% Diff = (abs(t1 - t2) + abs(t1 - t3) + abs(t1 - t4) + abs(t1 - t5) + abs(t1 - t6)+ abs(t1 - t7) + abs(t1 - t8) + abs(t1 - t9) +...
%        abs(t1 - t10) + abs(t2 - t3) + abs(t2 - t4) + abs(t2 - t5) + abs(t2 - t6) + abs(t2 - t7) + abs(t2 - t8) + abs(t2 - t9) +...
%        abs(t2 - t10) + abs(t3 - t4) + abs(t3 - t5) + abs(t3 - t6) + abs(t3 - t7) + abs(t3 - t8) + abs(t3 - t9) + abs(t3 - t10) +...
%        abs(t4 - t5) + abs(t4 - t6) + abs(t4 - t7) + abs(t4 - t8) + abs(t4 - t9) + abs(t4 - t10) + abs(t5 - t6) + abs(t5 - t7) +...
%        abs(t5 - t8) + abs(t5 - t9) + abs(t5 - t10) + abs(t6 - t7) + abs(t6 - t8) + abs(t6 - t9) + abs(t6 - t10) + abs(t7 - t8) +...
%        abs(t7 - t9) + abs(t7 - t10) + abs(t8 - t9) + abs(t8 - t10) + abs(t9 - t10))/Z;
% Avg_diff(:,1:13) = mean(Diff(:,1:13));

%% Performance plotting
% v1 = readmatrix("data/Trace_full_isld.csv");
% 
% dur = 20;
% div = 10;
% vd2_ref = 0.4852;
% vd2_ub = vd2_ref + 0.05*vd2_ref;
% vd2_lb = vd2_ref - 0.05*vd2_ref;
% 
% x = linspace(0,dur,length(v1)/div).';
% 
% plot(x,v1(1:div:length(v1),3))
% 
% yline(vd2_ub,'-.k','LineWidth',2)
% yline(vd2_lb,'-.k','LineWidth',2)
% ylim([0.45 0.52])
% 
% xlim([0,dur])
% xlabel('Time (s)')
% ylabel('Voltage')
% title('BESS Voltage')

%% Subplot designing
v1 = readmatrix("data/Test_Trace_DG.csv");
% v2 = readmatrix("data/Trace.csv");

dur = 40;
div = 1;
% vd2_ref = 0.4852;
% vd2_ub = vd2_ref + 0.05*vd2_ref;
% vd2_lb = vd2_ref - 0.05*vd2_ref;
% v1(:,1) = -v1(:,1);

% col = 4;
% l = 1.3;
% u = 2.5;

x = linspace(0,dur,length(v1)/div).';

subplot(2,1,1);
plot(x,v1(1:div:length(v1),1),'r','LineWidth',1.2)
% yline(vd2_ub,'-.k','LineWidth',1)
% yline(vd2_lb,'-.k','LineWidth',1)
ylim([-0.2 0.8])
xlim([0,dur])
ylabel('p.u.')
title('GendisTM using NC')

subplot(2,1,2);
plot(x,v1(1:div:length(v1),2),'b','LineWidth',1.2)
% yline(vd2_ub,'-.k','LineWidth',1)
% yline(vd2_lb,'-.k','LineWidth',1)
ylim([-0.2 0.8])
xlim([0,dur])
ylabel('p.u.')
xlabel('Time (sec)')
title('GendisTM Using BC')

% subplot(2,2,3);
% plot(x,v1(1:div:length(v1),4),'b','LineWidth',1)
% % yline(vd2_ub,'-.k','LineWidth',1)
% % yline(vd2_lb,'-.k','LineWidth',1)
% ylim([-1.5044 -1.5031])
% xlim([0,dur])
% ylabel('PFAngleBC')
% % title('DG Active Power (\eta = 0.1 msec)')
% 
% subplot(2,2,4);
% plot(x,v1(1:div:length(v1),2),'r','LineWidth',1)
% % yline(vd2_ub,'-.k','LineWidth',1)
% % yline(vd2_lb,'-.k','LineWidth',1)
% ylim([-1.5044 -1.5031])
% xlim([0,dur])
% ylabel('PFAngleNC')
% title('DG Active Power (\eta = 10 msec)')

% subplot(3,2,5);
% plot(x,v1(1:div:length(v1),3),'b','LineWidth',1)
% % yline(vd2_ub,'-.k','LineWidth',1)
% % yline(vd2_lb,'-.k','LineWidth',1)
% % ylim([0.45 0.52])
% xlim([0,dur])
% ylabel('IPV5C')
% xlabel('Time (sec)')
% % title('BESS Volt. (\eta = 0.1 msec)')
% 
% subplot(3,2,6);
% plot(x,v1(1:div:length(v1),6),'r','LineWidth',1)
% % yline(vd2_ub,'-.k','LineWidth',1)
% % yline(vd2_lb,'-.k','LineWidth',1)
% % ylim([0.45 0.52])
% xlim([0,dur])
% ylabel('IPV5C')
% xlabel('Time (sec)')
% % title('BESS Volt. (\eta = 10 msec)')
% % 
% sgtitle('DG Controller Outputs for BC and NC')

%% Statistical Performance Comparison
var = 2;
osc = 0;
n = 40;
osc_div = length(v1)/n;
for i = 1:osc_div:length(v1)-osc_div
    osc = osc + (max(v1(i:i+osc_div,var)) - min(v1(i:i+osc_div,var)));
end
OM = osc/n;
meanval = mean(v1(:,var));
maxval = max(v1(:,var));
minval = min(v1(:,var));

%% Stability Measurement
% v1 = readmatrix("data/Trace_full_isld.csv");
% v1(:,2) = -v1(:,2);
% dur = 20;
% div = 1;
% x = linspace(0,dur,length(v1)/div).';
% 
% for i = 1:length(v1)
%     if i == length(v1)
%         v(i,1) = v(i-1,1);
%         v(i,2) = v(i-1,2);
%         v(i,3) = v(i-1,3);
%     else
%         v(i,1) = abs(v1(i+1,1) - v1(i,1));
%         v(i,2) = abs(v1(i+1,2) - v1(i,2));
%         v(i,3) = abs(v1(i+1,3) - v1(i,3));
%     end
% end
% 
% plot(x,v(:,2))
% xlim([0,dur])