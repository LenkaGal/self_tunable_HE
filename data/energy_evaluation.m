clc, clear all
from = 801;
to = 6000;

load('ref_tracking23.mat') %1000
P_per = out.ScopeData2(1:to-from+1,3);
P = P_per/100*2; %kJ/s
E_1000 = sum(P*Ts) %kJ

load('ref_tracking24.mat') %100
P_per = out.ScopeData2(1:to-from+1,3);
P = P_per/100*2; %kJ/s
E_100 = sum(P*Ts) %kJ

load('ref_tracking27.mat') %tuned
P_per = out.ScopeData2(1:to-from+1,3);
P = P_per/100*2; %kJ/s
E = sum(P*Ts) %kJ


