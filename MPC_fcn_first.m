% function for Simulink implementation
function u_opt = MPC_fcn_first(x0,xref) % optimal control action
    global mpc N
    xref = [xref;N*xref];
    u_opt = mpc.evaluate(x0,'x.reference',xref);
end