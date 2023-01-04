clc, clear all;
%% Setup
% define sampling time
Ts = 1; 
% define COM port address
address = 'http://192.168.1.108:3030';
% set automatic data logging
logging = 0;

%%
K = 0.2418;
T = 5.6809;

%%
A = -1/T;
B = K/T;
C = 1;
D = 0;
ts = 1;
sysc = ss(A,B,C,D);
sysd = c2d(sysc,ts);
Ad = sysd.A;
Bd = sysd.B;
Cd = sysd.C;
Dd = sysd.D;

%%
ny = size(Cd,1); 
nx = size(Ad,1);
nu = size(Bd,2);

Ae = [Ad zeros(nx);-ts*Cd eye(nx)];
Be = [Bd;zeros(nx,nu)];
Ce = [Cd zeros(1,nx)];
De = 0;

%%
global N
N = 30;

us = 50;
ys = 35;

model = LTISystem('A', Ae, 'B', Be, 'C', Ce, 'D', De);
model.y.min = 20-ys;
model.y.max = 55-ys;
% model.x.min = [20-ys;N*(20-ys)];
% model.x.max = [55-ys;N*(55-ys)];
model.u.min = 20-us;
model.u.max = 100-us;

%
Q = [0.1 0; 0 100];
model.x.penalty = QuadFunction(Q);
R = 1;
model.u.penalty = QuadFunction(R);
%
global mpc
mpc = MPCController(model, N);

