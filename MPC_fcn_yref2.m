% function for Simulink implementation
function u_opt = MPC_fcn_yref2(x0,yref,time) % optimal control action
    
    global mpc1 mpc2
    if time<3000
        u_opt = mpc1.evaluate(x0,'y.reference',yref);
        disp('prvy')
    else
        u_opt = mpc2.evaluate(x0,'y.reference',yref);
        disp('druhy')
end