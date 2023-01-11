load('ref_tracking28.mat')
%% plots
% close all
figure(1)
hold on; grid minor; box on
plot(out.ScopeData(:,1),out.ScopeData(:,3),'LineWidth',1.5)
xlim([0 3000])

figure(2)
hold on; grid minor; box on
plot(out.ScopeData(:,1),out.ScopeData(:,2),'LineWidth',1.5)
plot(out.ScopeData(:,1),out.ScopeData(:,4),'LineWidth',1.5)
% title('R = 200, Q_x = 0.1, Q_{integrator} = 8')
legend('output','reference')
xlim([0 3000])
