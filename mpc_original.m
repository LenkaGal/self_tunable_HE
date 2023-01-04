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
ts = 1;
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

Ae = [Ad zeros(nx);ts*eye(nx) eye(nx)];
Be = [Bd;zeros(nx,nu)];
Ce = [Cd zeros(1,nx)];
De = 0;

%%
global N
N = 5;

us = 50;
ys = 35;

model = LTISystem('A', Ae, 'B', Be, 'C', Ce, 'D', De);
% model.y.min = 20-ys;
% model.y.max = 55-ys;
model.x.min = [20-ys;N*(20-ys)];
model.x.max = [55-ys;N*(55-ys)];
model.u.min = 20-us;
model.u.max = 100-us;
%
model.x.with('reference');
model.x.reference = 'free';
%
Q = [100 0; 0 0.1];
model.x.penalty = QuadFunction(Q);
R = 10;
model.u.penalty = QuadFunction(R);
%
global mpc
mpc = MPCController(model, N);

%% simulation
% Nsim = 30;
% x0 = [0; 0];
% A = Ae;
% B = Be;
% xref = [-10;N*(-10)];
% for i = 1:(Nsim)
%     if(i == 1)
%     u0 = mpc.evaluate(x0,'x.reference',xref);
%     x(:,i) = A*x0 + B*u0;
%     u(i) = mpc.evaluate([x(1,i);0],'x.reference',xref);
%     elseif(i == Nsim)
%     x(:,i) = A*x(:,i-1) + B*u(i-1);
%     else
%     x(:,i) = A*x(:,i-1) + B*u(i-1);
%     u(i) = mpc.evaluate([x(1,i);0],'x.reference',xref);
%     end
% end
% 
% figure()
% plot(1:Nsim-1,u(1:(Nsim-1)),'LineWidth',1.5)
% grid minor
% title('u')
% figure()
% plot(1:Nsim+1,[x0(1,:) x(1,:)],1:Nsim+1,[x0(2,:) x(2,:)],'LineWidth',1.5)
% grid minor
% title('x')
