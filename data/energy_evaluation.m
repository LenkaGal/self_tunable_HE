clc, clear all, close all
from = 801;
to = 6000;
figure(1), hold on

load('ref_tracking23.mat') %1000
P_per = out.ScopeData2(from:to+1,3);
P = P_per/100*2; %kJ/s
E_1000 = sum(P*Ts) %kJ
plot(P_per)

load('ref_tracking24.mat') %100
P_per = out.ScopeData2(from:to+1,3);
P = P_per/100*2; %kJ/s
E_100 = sum(P*Ts) %kJ
plot(P_per)

load('ref_tracking27.mat') %tuned
P_per = out.ScopeData2(from:to+1,3);
P = P_per/100*2; %kJ/s
E = sum(P*Ts) %kJ
plot(P_per)

% load('ref_tracking25.mat') %500
% P_per = out.ScopeData2(from:to+1,3);
% P = P_per/100*2; %kJ/s
% E_500 = sum(P*Ts) %kJ
% plot(P_per)


