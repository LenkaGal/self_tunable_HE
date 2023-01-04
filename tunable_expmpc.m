%%
clc,clear all
%% LOWER BOUND ON PENALTY MATRIX R = 0.1
model = LTISystem('A', [1 1; 0 1], 'B', [1; 0.5]);
model.x.min = [-5; -5];
model.x.max = [5; 5];
model.u.min = -1;
model.u.max = 1;
%
model.x.with('reference');
model.x.reference = 'free';
%
Q = [1 0; 0 1];
model.x.penalty = QuadFunction(Q);
RL = 0.1;
model.u.penalty = QuadFunction(RL);
%
N = 5;
mpc_L = MPCController(model, N);
expmpc_L = mpc_L.toExplicit();

%% UPPER BOUND ON PENALTY MATRIX R = 100
RU = 50;
model.u.penalty = QuadFunction(RU);
%
mpc_U = MPCController(model, N);
expmpc_U = mpc_U.toExplicit();

%% 
Nsim = 30;
A = model.A;
B = model.B;
x0 = [0; 0];
xref1 = [1; 0];
xref2 = [2; 0];
xref3 = [3; 0];
xref = [repmat(xref1, 1, 10), repmat(xref2, 1, 10), repmat(xref3, 1, 10)];
d_max = max(max(abs(model.x.min),model.x.max));
%d_max = 3;

for i = 1:Nsim
    if(i == 1)
    % lower
    u_L0 = expmpc_L.evaluate(x0,'x.reference', xref(:,i));
    x_L(:,i) = A*x0 + B*u_L0;
    u_L(i) = expmpc_L.evaluate(x_L(:,i),'x.reference', xref(:,i+1));
    % upper
    u_U0 = expmpc_U.evaluate(x0,'x.reference', xref(:,i));
    x_U(:,i) = A*x0 + B*u_U0;
    u_U(i) = expmpc_U.evaluate(x_U(:,i),'x.reference', xref(:,i+1));
    % parameters
    a0 = (u_L0-u_U0)/(RL-RU);
    b0 = (RL*u_U0-RU*u_L0)/(RL-RU);
    a(i) = (u_L(i)-u_U(i))/(RL-RU);
    b(i) = (RL*u_U(i)-RU*u_L(i))/(RL-RU);
    elseif(i == Nsim)
    x_L(:,i) = A*x_L(:,i-1) + B*u_L(i-1);
    x_U(:,i) = A*x_U(:,i-1) + B*u_U(i-1);
    else
    % lower
    x_L(:,i) = A*x_L(:,i-1) + B*u_L(i-1);
    u_L(i) = expmpc_L.evaluate(x_L(:,i),'x.reference', xref(:,i+1));
    % upper
    x_U(:,i) = A*x_U(:,i-1) + B*u_U(i-1);
    u_U(i) = expmpc_U.evaluate(x_U(:,i),'x.reference', xref(:,i+1));
    % parameters
    a(i) = (u_L(i)-u_U(i))/(RL-RU);
    b(i) = (RL*u_U(i)-RU*u_L(i))/(RL-RU);
    end
end

u_L = [u_L0 u_L];
u_U = [u_U0 u_U];
x_L = [x0 x_L];
x_U = [x0 x_U];
% a = [a0 a];
% b = [b0 b];

%%
for i = 1:Nsim
    if(i == 1)
    p0 = max(abs(xref(:,i))/d_max);
    p(i) = max(abs(xref(:,i+1))/d_max);
    R0 = (RU-RL)*(1-p0)+RL;
    R(i) = (RU-RL)*(1-p(i))+RL;
    %model.u.penalty = QuadFunction(R(i));
    %mpc(i) = MPCController(model, N)
    %expmpc(i) = mpc(i).toExplicit();
    %u(i) = expmpc(i).evaluate(x0,...);
    u0 = R0*a0+b0;
    x(:,i) = A*x0 + B*u0;
    u(i) = R(i)*a(i)+b(i);
    elseif(i == Nsim)
    x(:,i) = A*x(:,i-1) + B*u(i-1);
    else
    p(i) = max(abs(xref(:,i+1))/d_max);
    R(i) = (RU-RL)*(1-p(i))+RL;
    x(:,i) = A*x(:,i-1) + B*u(i-1);
    u(i) = R(i)*a(i)+b(i);
    end
end

u = [u0 u];
x = [x0 x];

%% Plots
figure()
hold on;grid on
plot(1:Nsim,x(:,1:Nsim),'linewidth', 1.5)
stairs(1:Nsim, xref(1,:), 'k--', 'linewidth', 1.5)
ylim([-1 3.5])

figure()
hold on;grid on
plot(1:Nsim,u(1:Nsim),'linewidth', 1.5)

%%
figure()
hold on;grid on
plot(1:Nsim,x_U(:,1:Nsim),'linewidth', 1.5)
plot(1:Nsim,x_L(:,1:Nsim),'linewidth', 1.5)
stairs(1:Nsim, xref(1,:), 'k--', 'linewidth', 1.5)
ylim([-1 3.5])
legend('x1 upper','x2 upper','x1 lower','x2 lower')

figure()
hold on;grid on
plot(1:Nsim,u_U(1:Nsim),'linewidth', 1.5)
plot(1:Nsim,u_L(1:Nsim),'linewidth', 1.5)
legend('upper','lower')
