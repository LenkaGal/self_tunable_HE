clc, close all, clear 
load('ref_tracking26.mat')
%% plots
figure(11)
hold on; grid minor; box on
plot(out.ScopeData(:,1),out.ScopeData(:,3),'LineWidth',1.5)
xlim([0 3000])

figure(12)
hold on; grid minor; box on
plot(out.ScopeData(:,1),out.ScopeData(:,2),'LineWidth',1.5)
plot(out.ScopeData(:,1),out.ScopeData(:,4),'LineWidth',1.5)
legend('output','reference')
xlim([0 3000])
%%
from = 801;
to = 6000;
time = out.ScopeData(1:to-from+1,1);
input = out.ScopeData(from:to,3);
output = out.ScopeData(from:to,2);
ref = out.ScopeData(from:to,4);
% figure(13)
% plot(time,output)

%time(401:1600),time(1601:2800),time(2801:4000),time(4001:end)
steps = [401, 1601, 2801, 4001];
step_length = 1199;
a = 0.1338; b = -1.8633; %flow = a*power+q
for k = 1:length(steps)
    t = time(1:(step_length+1));
    u(k,:) = input(steps(k):(steps(k)+step_length));
    y(k,:) = output(steps(k):(steps(k)+step_length));
    r(k,:) = ref(steps(k):(steps(k)+step_length));
end

references = [ref(1);r(:,1)];
dref = diff(references)  
for k = 1:length(steps)
    % ISE
    ISE(k) = sum(((y(k,:)-r(k,:)).^2)*Ts)
    % maximal overshoot/undershoot
    y_inf = mean(y(k,end-100:end));
    if dref(k)>0
        sigma(k) = (max(y(k,:))-y_inf)/(y_inf-y(k,1))
    else
        sigma(k) = (min(y(k,:))-y_inf)/(y_inf-y(k,1))
    end    
    % volume
    V(k) = sum((a*u(k,:)+b)*Ts) 
    % settling time t_reg
    delta = 0.05*r(k,:); 
    
    figure(k), hold on
    plot(t,y(k,:))
    plot(t,r(k,:)-delta,'--',t,r(k,:)+delta,'--')
    
    ie = find (abs(y(k,:)-r(k,:)) >= delta, 1, 'last')
    T005(k) = t(ie)
    plot(T005(k), y(k,ie),'*')
end



