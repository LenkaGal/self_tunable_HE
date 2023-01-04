% function for Simulink implementation
function u_opt = MPC_fcn_yref(x0,yref) % optimal control action
    global mpc
    u_opt = mpc.evaluate(x0,'y.reference',yref);
end