%% Function for tunable explicit MPC - distance from initial condition
% x0,yref - parameters for explicit MPC
% ----------
% dref - change of the reference value - for indication whether it changed
% downwards or upwards
% ----------
% rho_prev - ratio rho from the previous step - if the reference does not
% change, we use the previous rho
% ----------
function result = MPC_fcn_yref_tunable_ic(x0,yref,dref,rho_prev) % interpolated control action
    dmax = 15; %maximal possible distance from initial condition/from steady state
               
    global mpc_l mpc_h
    u_l = mpc_l.evaluate(x0,'y.reference',yref); %R = 100
    u_h = mpc_h.evaluate(x0,'y.reference',yref); %R = 1000
      
        
    if dref == 0 %let's use the ratio rho from the previous step
        if nargin == 4
            rho = rho_prev;
            disp('using the previous one')
        else
            rho = 0;
        end
    elseif dref < 0 %reference step change downwards
                    %we want R=[550; 1000] -> we scale rho=[rho_middle; 1]=[0.5; 1]
                    % when rho_real=0 -> rho=1 -> R=1000
                    % when rho_real=1 -> rho=0.5 -> R=550
        rho_real = abs(yref/dmax); %real ratio that needs to be scaled for our purposes
        rho = 1-0.5*rho_real; %rho=1-rho_middle*rho_real
    else %reference step change upwards
         %we want R=[100; 500] -> we scale rho=[0; rho_middle]=[0; 0.5]
        rho_real = abs(yref/dmax); %real ratio that needs to be scaled for our purposes
        rho = 0.5*rho_real; %rho=rho_middle*rho_real
    end  
          
    
    u = (1-rho)*u_l+rho*u_h;   
    result = [u,rho];
    
end