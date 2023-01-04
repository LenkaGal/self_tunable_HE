%% Function for tunable explicit MPC 
% x0,yref - parameters for explicit MPC
% ----------
% dref - change of the reference value - for indication whether it changed
% downwards or upwards
% ----------
% rho_prev - ratio rho from the previous step - if the reference does not
% change, we use the previous rho
% ----------
function result = MPC_fcn_yref_tunable(x0,yref,dref,rho_prev) % interpolated control action
    dmax = 15; %maximal possible step change of reference 
               %try 10
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
                    %we want R=[500; 1000] -> we scale rho=[rho_middle; 1]=[4/9; 1]
        rho_real = abs(dref/dmax); %real ratio that needs to be scaled for our purposes
        rho = 4/9+(5/9*rho_real); %rho=(1-rho_middle)*rho_real+rho_middle
    else %reference step change upwards
         %we want R=[100; 500] -> we scale rho=[0; rho_middle]=[0; 4/9]
        rho_real = dref/dmax; %real ratio that needs to be scaled for our purposes
        rho = 4/9*rho_real; %rho=rho_middle*rho_real
    end  
          
    
    u = (1-rho)*u_l+rho*u_h;   
    result = [u,rho];
    
end