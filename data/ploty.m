load('ref_tracking23.mat')
%% Ordinary plots
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

%% Paper
close all, clear
load('ref_tracking30.mat') %1 -> Q_y = 1000
from = 801;
to = 5800;
time = out.ScopeData(1:to-from+1,1);
ref = out.ScopeData(from:to,4);
input1 = out.ScopeData(from:to,3);
output1 = out.ScopeData(from:to,2);

load('ref_tracking32.mat') %2 -> Q_y = 100
input2 = out.ScopeData(from:to,3);
output2 = out.ScopeData(from:to,2);

load('ref_tracking27.mat') %2 -> Q_y = tuned
input3 = out.ScopeData(from:to,3);
output3 = out.ScopeData(from:to,2);

set(0,'defaulttextinterpreter','latex')
lw = 1.5;
fs = 13;
green   = [0.2, 0.7, 0.1];

figure(3), hold on
plot(time,output1,time,output2,'LineWidth',lw) %only boundaries
% plot(time,output3,'LineWidth',lw,'Color',green) 
plot(time,ref,'--','LineWidth',lw,'Color','k') 
xlim([0 2600])
xlabel('time [s]')
set(gca, 'TickLabelInterpreter','latex','FontSize', fs)
xlabel('$t$ [s]')
ylabel('$T$ [$^{\circ}$C]','FontSize', fs)
legend('$Q_\mathrm{y} = 1000$', '$Q_\mathrm{y} = 100$', 'Interpreter','latex', 'FontSize', fs) %only boundaries
% legend('$Q_\mathrm{y} = 1000$', '$Q_\mathrm{y} = 100$', '$Q_\mathrm{y}$ tuned', 'Interpreter','latex', 'FontSize', fs) %all
grid minor

figure(4), hold on
plot(time,input1,time,input2,'LineWidth',lw) %only boundaries 
% plot(time,input3,'LineWidth',lw,'Color',green) 
plot([0 2600],[20 20],'--','LineWidth',lw,'Color','k')
plot([0 2600],[100 100],'--','LineWidth',lw,'Color','k')
axis([0 2600 10 110])
xlabel('time [s]')
set(gca, 'TickLabelInterpreter','latex','FontSize', fs)
xlabel('$t$ [s]')
ylabel('$U$ [$\%$]','FontSize', fs)
legend('$Q_\mathrm{y} = 1000$', '$Q_\mathrm{y} = 100$', 'Interpreter','latex', 'FontSize', fs) %only boundaries
% legend('$Q_\mathrm{y} = 1000$', '$Q_\mathrm{y} = 100$', '$Q_\mathrm{y}$ tuned', 'Interpreter','latex', 'FontSize', fs) %all
grid minor