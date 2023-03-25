% X = (linspace(0,10,length(s))).';
% 
% n = 4;
% plot(X,s(:,n),LineWidth=1)
% hold on
% plot(X,Tr(1:50000,n),LineWidth=1)
% 
% ylim([1.058 1.0615])
% xlabel('Time (s)')
% ylabel('Efd (pu)')
% title('Field Voltage (input to the DG)')
% legend('MATLAB','RTDS')

% plot(Tr(:,1))
% hold on
% plot(Tr(:,2)/(2*pi*60))
% hold on
plot(Tr(:,3))
% hold on
% plot(Tr(:,4))
% hold on
% plot(Tr(:,5))
% hold on
% plot(Tr(:,6))
% hold on
% plot(Tr(:,7))
% hold on
% plot(Tr(:,8))