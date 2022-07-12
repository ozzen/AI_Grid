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
% A = readmatrix("Data\Trace_short.csv");
% B = readmatrix("Data\Trace_long.csv");
% 
% x_A = linspace(0,3,30000);
% x_B = linspace(0,60,600000);
% 
% plot(x_A,A(:,10))
% hold on
% plot(x_B,B(:,10))

%% Performance comparison between NC and BESS voltage controller
Vd2_original = readmatrix("Data\Trace_rtds.csv");
Vd2_learned = readmatrix("Data\Trace_matlab.csv");
% VBat_learned(30000,:) = VBat_learned(29999,:);
x = linspace(0,5,50000);

plot(x,Vd2_original(1:50000,1),'r')
hold on
plot(x,Vd2_learned(1:50000,1),'b')
% ylim([0.485,0.487])
% ylim([1.19003,1.19035])
xlabel('Time (s)')
ylabel('Voltage (kV)')
legend('RTDS','Matlab')
title('Vd2 Comparison')

% mse = immse(VBat_original(:,2),VBat_learned(:,2));

%% Data variance computation to determine model uncertainties
% n = 10;
% T = 6000;
% Z = n*(n-1)/2;
% 
% t1 = readmatrix("Data\Trends\Trace_trend_1.csv");
% t2 = readmatrix("Data\Trends\Trace_trend_2.csv");
% t3 = readmatrix("Data\Trends\Trace_trend_3.csv");
% t4 = readmatrix("Data\Trends\Trace_trend_4.csv");
% t5 = readmatrix("Data\Trends\Trace_trend_5.csv");
% t6 = readmatrix("Data\Trends\Trace_trend_6.csv");
% t7 = readmatrix("Data\Trends\Trace_trend_7.csv");
% t8 = readmatrix("Data\Trends\Trace_trend_8.csv");
% t9 = readmatrix("Data\Trends\Trace_trend_9.csv");
% t10 = readmatrix("Data\Trends\Trace_trend_10.csv");
% 
% Diff = (abs(t1 - t2) + abs(t1 - t3) + abs(t1 - t4) + abs(t1 - t5) + abs(t1 - t6)+ abs(t1 - t7) + abs(t1 - t8) + abs(t1 - t9) +...
%        abs(t1 - t10) + abs(t2 - t3) + abs(t2 - t4) + abs(t2 - t5) + abs(t2 - t6) + abs(t2 - t7) + abs(t2 - t8) + abs(t2 - t9) +...
%        abs(t2 - t10) + abs(t3 - t4) + abs(t3 - t5) + abs(t3 - t6) + abs(t3 - t7) + abs(t3 - t8) + abs(t3 - t9) + abs(t3 - t10) +...
%        abs(t4 - t5) + abs(t4 - t6) + abs(t4 - t7) + abs(t4 - t8) + abs(t4 - t9) + abs(t4 - t10) + abs(t5 - t6) + abs(t5 - t7) +...
%        abs(t5 - t8) + abs(t5 - t9) + abs(t5 - t10) + abs(t6 - t7) + abs(t6 - t8) + abs(t6 - t9) + abs(t6 - t10) + abs(t7 - t8) +...
%        abs(t7 - t9) + abs(t7 - t10) + abs(t8 - t9) + abs(t8 - t10) + abs(t9 - t10))/Z;
% Avg_diff(:,1:13) = mean(Diff(:,1:13));
