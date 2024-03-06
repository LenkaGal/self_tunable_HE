load('ref_tracking23.mat')
%% Ordinary plots
% close all
figure(5)
hold on; grid minor; box on
plot(out.ScopeData(:,1),out.ScopeData(:,3),'LineWidth',1.5)
xlim([0 3000])

figure(6)
hold on; grid minor; box on
plot(out.ScopeData(:,1),out.ScopeData(:,2),'LineWidth',1.5)
plot(out.ScopeData(:,1),out.ScopeData(:,4),'LineWidth',1.5)
% title('R = 200, Q_x = 0.1, Q_{integrator} = 8')
legend('output','reference')
xlim([0 3000])

%% Paper
close all, clear
tuned = 1; %default 0 - for boundary controllers
load('ref_tracking23.mat') %1 -> Q_y = 1000
from = 801;
to = 6000;
time = out.ScopeData(1:to-from+1,1);
ref = out.ScopeData(from:to,4);
input1 = out.ScopeData(from:to,3);
output1 = out.ScopeData(from:to,2);
Th1 = out.ScopeData6(from:to,3); %heating medium temperature
W1 = out.ScopeData2(from:to,3); %electric power - spiral

load('ref_tracking24.mat') %2 -> Q_y = 100
input2 = out.ScopeData(from:to,3);
output2 = out.ScopeData(from:to,2);
Th2 = out.ScopeData6(from:to,3); %heating medium temperature
W2 = out.ScopeData2(from:to,3); %electric power - spiral

if tuned == 1
    load('ref_tracking27.mat') %2 -> Q_y = tuned
    input3 = out.ScopeData(from:to,3);
    output3 = out.ScopeData(from:to,2);
    Th3 = out.ScopeData6(from:to,3); %heating medium temperature
    W3 = out.ScopeData2(from:to,3); %electric power - spiral
end

set(0,'defaulttextinterpreter','latex')
lw = 1.5;
fs = 13;
green   = [0.2, 0.7, 0.1];

figure(3), hold on
plot(time,output1,time,output2,'LineWidth',lw) %only boundaries
try
    plot(time,output3,'LineWidth',lw,'Color',green)   
end
plot(time,ref,'--','LineWidth',lw,'Color','k') 
xlim([0 2600])
xlabel('time [s]')
set(gca, 'TickLabelInterpreter','latex','FontSize', fs)
xlabel('$t$ [s]')
ylabel('$T$ [$^{\circ}$C]','FontSize', fs)
if tuned == 1
    legend('$Q_\mathrm{y} = 1000$', '$Q_\mathrm{y} = 100$', '$Q_\mathrm{y}$ tuned', 'Interpreter','latex', 'FontSize', fs) %all
else
    legend('$Q_\mathrm{y} = 1000$', '$Q_\mathrm{y} = 100$', 'Interpreter','latex', 'FontSize', fs) %only boundaries
end
grid minor

figure(4), hold on
plot(time,input1,time,input2,'LineWidth',lw) %only boundaries 
try
    plot(time,input3,'LineWidth',lw,'Color',green) 
end
plot([0 2600],[20 20],'--','LineWidth',lw,'Color','k')
plot([0 2600],[100 100],'--','LineWidth',lw,'Color','k')
axis([0 2600 10 110])
xlabel('time [s]')
set(gca, 'TickLabelInterpreter','latex','FontSize', fs)
xlabel('$t$ [s]')
ylabel('$U$ [$\%$]','FontSize', fs)
if tuned == 1
    legend('$Q_\mathrm{y} = 1000$', '$Q_\mathrm{y} = 100$', '$Q_\mathrm{y}$ tuned', 'Interpreter','latex', 'FontSize', fs) %all
else
    legend('$Q_\mathrm{y} = 1000$', '$Q_\mathrm{y} = 100$', 'Interpreter','latex', 'FontSize', fs) %only boundaries
end
grid minor

figure(5), hold on
plot(time,Th1,time,Th2,'LineWidth',lw) %only boundaries
try
    plot(time,Th3,'LineWidth',lw,'Color',green)   
end
axis([0 2600 60 80])
xlabel('time [s]')
set(gca, 'TickLabelInterpreter','latex','FontSize', fs)
xlabel('$t$ [s]')
ylabel('$T_\mathrm{H}$ [$^{\circ}$C]','FontSize', fs)
if tuned == 1
    legend('$Q_\mathrm{y} = 1000$', '$Q_\mathrm{y} = 100$', '$Q_\mathrm{y}$ tuned', 'Interpreter','latex', 'FontSize', fs) %all
else
    legend('$Q_\mathrm{y} = 1000$', '$Q_\mathrm{y} = 100$', 'Interpreter','latex', 'FontSize', fs) %only boundaries
end
grid minor

figure(6), hold on
plot(time,W1,time,W2,'LineWidth',lw) %only boundaries
try
    plot(time,W3,'LineWidth',lw,'Color',green)   
end
axis([0 2600 -10 110])
xlabel('time [s]')
set(gca, 'TickLabelInterpreter','latex','FontSize', fs)
xlabel('$t$ [s]')
ylabel('$W$ [$\%$]','FontSize', fs)
if tuned == 1
    legend('$Q_\mathrm{y} = 1000$', '$Q_\mathrm{y} = 100$', '$Q_\mathrm{y}$ tuned', 'Interpreter','latex', 'FontSize', fs) %all
else
    legend('$Q_\mathrm{y} = 1000$', '$Q_\mathrm{y} = 100$', 'Interpreter','latex', 'FontSize', fs) %only boundaries
end
grid minor
%% Q
Q = [100, 400, 250, 700, 850];
t = out.ScopeData(1:5000,1);
Qt = [];
for i = 1:length(Q)
    if i == 1
        Qt = [Qt; Q(i)*ones(400,1)];
    else
        Qt = [Qt; Q(i)*ones(1200,1)];
    end
    
end
close all


set(0,'defaulttextinterpreter','latex')
lw = 1.5;
fs = 13;
green   = [0.2, 0.7, 0.1];

figure, hold on, grid minor
plot(t,Qt,'LineWidth',lw,'Color',green)
plot(t,ones(5000,1)*100,'--','LineWidth',lw,'Color','k')
plot(t,ones(5000,1)*1000,'--','LineWidth',lw,'Color','k')
ylim([0 1100])
set(gca, 'TickLabelInterpreter','latex','FontSize', fs)
xlabel('$t$ [s]')
ylabel('$Q_{\mathrm{y}}$','FontSize', fs)
legend('$Q_\mathrm{y}$ tuned', '$Q_\mathrm{y,L}, Q_\mathrm{y,U}$ ', 'Interpreter','latex', 'FontSize', fs) 

load('ref_tracking23.mat')
%% Ordinary plots
% close all
figure(5)
hold on; grid minor; box on
plot(out.ScopeData(:,1),out.ScopeData(:,3),'LineWidth',1.5)
xlim([0 3000])

figure(6)
hold on; grid minor; box on
plot(out.ScopeData(:,1),out.ScopeData(:,2),'LineWidth',1.5)
plot(out.ScopeData(:,1),out.ScopeData(:,4),'LineWidth',1.5)
% title('R = 200, Q_x = 0.1, Q_{integrator} = 8')
legend('output','reference')
xlim([0 3000])

%% Paper
close all, clear
tuned = 0; %default 0 - for boundary controllers
load('ref_tracking31.mat') %1 -> Q_y = 1000
from = 801;
to = 6000;
time = out.ScopeData(1:to-from+1,1);
ref = out.ScopeData(from:to,4);
input1 = out.ScopeData(from:to,3);
output1 = out.ScopeData(from:to,2);

load('ref_tracking32.mat') %2 -> Q_y = 100
input2 = out.ScopeData(from:to,3);
output2 = out.ScopeData(from:to,2);

if tuned == 1
    load('ref_tracking33.mat') %2 -> Q_y = tuned
    input3 = out.ScopeData(from:to,3);
    output3 = out.ScopeData(from:to,2);
end

set(0,'defaulttextinterpreter','latex')
lw = 1.5;
fs = 13;
green   = [0.2, 0.7, 0.1];

figure(3), hold on
plot(time,output1,time,output2,'LineWidth',lw) %only boundaries
try
    plot(time,output3,'LineWidth',lw,'Color',green)   
end
plot(time,ref,'--','LineWidth',lw,'Color','k') 
xlim([0 2600])
xlabel('time [s]')
set(gca, 'TickLabelInterpreter','latex','FontSize', fs)
xlabel('$t$ [s]')
ylabel('$T$ [$^{\circ}$C]','FontSize', fs)
if tuned == 1
    legend('$Q_\mathrm{y} = 1000$', '$Q_\mathrm{y} = 100$', '$Q_\mathrm{y}$ tuned', 'Interpreter','latex', 'FontSize', fs) %all
else
    legend('$Q_\mathrm{y} = 1000$', '$Q_\mathrm{y} = 100$', 'Interpreter','latex', 'FontSize', fs) %only boundaries
end
grid minor

figure(4), hold on
plot(time,input1,time,input2,'LineWidth',lw) %only boundaries 
try
    plot(time,input3,'LineWidth',lw,'Color',green) 
end
plot([0 2600],[20 20],'--','LineWidth',lw,'Color','k')
plot([0 2600],[100 100],'--','LineWidth',lw,'Color','k')
axis([0 2600 10 110])
xlabel('time [s]')
set(gca, 'TickLabelInterpreter','latex','FontSize', fs)
xlabel('$t$ [s]')
ylabel('$U$ [$\%$]','FontSize', fs)
if tuned == 1
    legend('$Q_\mathrm{y} = 1000$', '$Q_\mathrm{y} = 100$', '$Q_\mathrm{y}$ tuned', 'Interpreter','latex', 'FontSize', fs) %all
else
    legend('$Q_\mathrm{y} = 1000$', '$Q_\mathrm{y} = 100$', 'Interpreter','latex', 'FontSize', fs) %only boundaries
end
grid minor
%% Q
Q = [100, 400, 250, 700, 850];
t = out.ScopeData(1:5000,1);
Qt = [];
for i = 1:length(Q)
    if i == 1
        Qt = [Qt; Q(i)*ones(400,1)];
    else
        Qt = [Qt; Q(i)*ones(1200,1)];
    end
    
end
close all


set(0,'defaulttextinterpreter','latex')
lw = 1.5;
fs = 13;
green   = [0.2, 0.7, 0.1];

figure, hold on, grid minor
plot(t,Qt,'LineWidth',lw,'Color',green)
plot(t,ones(5000,1)*100,'--','LineWidth',lw,'Color','k')
plot(t,ones(5000,1)*1000,'--','LineWidth',lw,'Color','k')
ylim([0 1100])
set(gca, 'TickLabelInterpreter','latex','FontSize', fs)
xlabel('$t$ [s]')
ylabel('$Q_{\mathrm{y}}$','FontSize', fs)
legend('$Q_\mathrm{y}$ tuned', '$Q_\mathrm{y,L}, Q_\mathrm{y,U}$ ', 'Interpreter','latex', 'FontSize', fs) 

load('ref_tracking23.mat')
%% Ordinary plots
% close all
figure(5)
hold on; grid minor; box on
plot(out.ScopeData(:,1),out.ScopeData(:,3),'LineWidth',1.5)
xlim([0 3000])

figure(6)
hold on; grid minor; box on
plot(out.ScopeData(:,1),out.ScopeData(:,2),'LineWidth',1.5)
plot(out.ScopeData(:,1),out.ScopeData(:,4),'LineWidth',1.5)
% title('R = 200, Q_x = 0.1, Q_{integrator} = 8')
legend('output','reference')
xlim([0 3000])

%% Paper
close all, clear
tuned = 0; %default 0 - for boundary controllers
load('ref_tracking31.mat') %1 -> Q_y = 1000
from = 801;
to = 6000;
time = out.ScopeData(1:to-from+1,1);
ref = out.ScopeData(from:to,4);
input1 = out.ScopeData(from:to,3);
output1 = out.ScopeData(from:to,2);

load('ref_tracking32.mat') %2 -> Q_y = 100
input2 = out.ScopeData(from:to,3);
output2 = out.ScopeData(from:to,2);

if tuned == 1
    load('ref_tracking33.mat') %2 -> Q_y = tuned
    input3 = out.ScopeData(from:to,3);
    output3 = out.ScopeData(from:to,2);
end

set(0,'defaulttextinterpreter','latex')
lw = 1.5;
fs = 13;
green   = [0.2, 0.7, 0.1];

figure(3), hold on
plot(time,output1,time,output2,'LineWidth',lw) %only boundaries
try
    plot(time,output3,'LineWidth',lw,'Color',green)   
end
plot(time,ref,'--','LineWidth',lw,'Color','k') 
xlim([0 2600])
xlabel('time [s]')
set(gca, 'TickLabelInterpreter','latex','FontSize', fs)
xlabel('$t$ [s]')
ylabel('$T$ [$^{\circ}$C]','FontSize', fs)
if tuned == 1
    legend('$Q_\mathrm{y} = 1000$', '$Q_\mathrm{y} = 100$', '$Q_\mathrm{y}$ tuned', 'Interpreter','latex', 'FontSize', fs) %all
else
    legend('$Q_\mathrm{y} = 1000$', '$Q_\mathrm{y} = 100$', 'Interpreter','latex', 'FontSize', fs) %only boundaries
end
grid minor

figure(4), hold on
plot(time,input1,time,input2,'LineWidth',lw) %only boundaries 
try
    plot(time,input3,'LineWidth',lw,'Color',green) 
end
plot([0 2600],[20 20],'--','LineWidth',lw,'Color','k')
plot([0 2600],[100 100],'--','LineWidth',lw,'Color','k')
axis([0 2600 10 110])
xlabel('time [s]')
set(gca, 'TickLabelInterpreter','latex','FontSize', fs)
xlabel('$t$ [s]')
ylabel('$U$ [$\%$]','FontSize', fs)
if tuned == 1
    legend('$Q_\mathrm{y} = 1000$', '$Q_\mathrm{y} = 100$', '$Q_\mathrm{y}$ tuned', 'Interpreter','latex', 'FontSize', fs) %all
else
    legend('$Q_\mathrm{y} = 1000$', '$Q_\mathrm{y} = 100$', 'Interpreter','latex', 'FontSize', fs) %only boundaries
end
grid minor
%% Q
Q = [100, 400, 250, 700, 850];
t = out.ScopeData(1:5200,1);
Qt = [];
for i = 1:length(Q)
    if i == 1
        Qt = [Qt; Q(i)*ones(400,1)];
    else
        Qt = [Qt; Q(i)*ones(1200,1)];
    end
    
end
close all


set(0,'defaulttextinterpreter','latex')
lw = 1.5;
fs = 13;
green   = [0.2, 0.7, 0.1];

figure, hold on, grid minor
plot(t,Qt,'LineWidth',lw,'Color',green)
plot(t,ones(5200,1)*100,'--','LineWidth',lw,'Color','k')
plot(t,ones(5200,1)*1000,'--','LineWidth',lw,'Color','k')
axis([0 2600 0 1100])
set(gca, 'TickLabelInterpreter','latex','FontSize', fs)
xlabel('$t$ [s]')
ylabel('$Q_{\mathrm{y}}$','FontSize', fs)
legend('$Q_\mathrm{y}$ tuned', '$Q_\mathrm{y,L}, Q_\mathrm{y,U}$ ', 'Interpreter','latex', 'FontSize', fs) 

%% rho
ro = [0, 0.333, 0.167, 0.667, 0.833];
t = out.ScopeData(1:5200,1);
rho = [];
for i = 1:length(ro)
    if i == 1
        rho = [rho; ro(i)*ones(400,1)];
    else
        rho = [rho; ro(i)*ones(1200,1)];
    end
    
end
close all


set(0,'defaulttextinterpreter','latex')
lw = 1.5;
fs = 13;
green   = [0.2, 0.7, 0.1];
blue = [0.3010 0.7450 0.9330];

figure, hold on, grid minor
plot(t,rho,'LineWidth',lw,'Color',green)
plot(t,ones(5200,1)*0.5,'--','LineWidth',lw,'Color',blue)
plot(t,ones(5200,1)*0,'--','LineWidth',lw,'Color','k')
plot(t,ones(5200,1)*1,'--','LineWidth',lw,'Color','k')
axis([0 2600 -0.1 1.1])
set(gca, 'TickLabelInterpreter','latex','FontSize', fs)
xlabel('$t$ [s]')
ylabel('$\widetilde{\rho}$','FontSize', fs)
legend('$\widetilde{\rho}$', '$\rho_\mathrm{s}$ ', 'Interpreter','latex', 'FontSize', fs) 
%% Partitions
load('expmpc_L.mat')
load('expmpc_U.mat')
%%
set(0,'defaulttextinterpreter','latex')
fs = 13;

figure(1)
expmpc_L.partition.plot

set(gca, 'TickLabelInterpreter','latex','FontSize', fs)
xlabel('$x$','FontSize', fs)
ylabel('$x_{\mathrm{I}}$','FontSize', fs)
zlabel('$y_{\mathrm{ref}}$','FontSize', fs)
axis tight


figure(2)
expmpc_U.partition.plot

set(gca, 'TickLabelInterpreter','latex','FontSize', fs)
xlabel('$x$','FontSize', fs)
ylabel('$x_{\mathrm{I}}$','FontSize', fs)
zlabel('$y_{\mathrm{ref}}$','FontSize', fs)
axis tight