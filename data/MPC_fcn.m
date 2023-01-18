% function for Simulink implementation
function u_opt = MPC_fcn(x0) % optimal control action
    global mpc
    u_opt = mpc.evaluate(x0);
end