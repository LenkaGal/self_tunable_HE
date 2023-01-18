clc, clear all;
%% Setup
% define sampling time
Ts = 0.5; 
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
ts = 0.5;
sysc = ss(A,B,C,D);
sysd = c2d(sysc,ts);
Ad = sysd.A;
Bd = sysd.B;
Cd = sysd.C;
Dd = sysd.D;

%%
% figure()
% step(sysc,sysd)

%%
ny = size(Cd,1); 
nx = size(Ad,1);
nu = size(Bd,2);

Ae = [Ad zeros(nx); -ts*Cd eye(nx)];
Be = [Bd;zeros(nx,nu)];
Ce = [Cd zeros(1,nx)];
De = 0;

%%
us = 35;
ys = 35;

model = LTISystem('A', Ae, 'B', Be, 'C', Ce, 'D', De);
% model.y.min = 20-ys;
% model.y.max = 55-ys;
model.u.min = 20-us;
model.u.max = 100-us;
%
% model.x.with('reference');
% model.x.reference = 'free';
%
Q = [10 0; 0 1];
model.x.penalty = QuadFunction(Q);
R = 200;
model.u.penalty = QuadFunction(R);
%
N = 60;
global mpc
mpc = MPCController(model, N);

%%
Tref = 50;

%% Filter
Tf = 0.6;
G = tf([1],[Tf 1]);
G_d = c2d(G,Ts);
[cit,men] = tfdata(G_d);
cit = cit{1};
men = men{1};

