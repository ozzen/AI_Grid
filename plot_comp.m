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
VBat_original = readmatrix("Data\Original.csv");
VBat_learned = readmatrix("Data\Learned.csv");
VBat_learned(30000,:) = VBat_learned(29999,:);
x = linspace(0,3,30000);

plot(x,VBat_original(:,2),'r')
hold on
plot(x,VBat_learned(:,2),'b')
% ylim([0.2463,0.2468])
ylim([1.19003,1.19035])
xlabel('Time (s)')
ylabel('Voltage (kV)')
legend('Original','Learned')
title('VBat2qs Comparison')

mse = immse(VBat_original(:,2),VBat_learned(:,2));
