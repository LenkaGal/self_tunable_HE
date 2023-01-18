# SP3
## Description of files

*Scripts:*
* `MPC_fcn.m` - function used in Simulink with only one input (x0) 
* `MPC_fcn_first.m` - original function we used in Simulink with two inputs (x0, xref)  
* `MPC_fcn_yref.m` - function used in `pct23_mpc_ref_tracking.slx` (for reference tracking)
* `mpc_modif.m` - script to run before simulation: `pct23_third_attempt.slx`
* `mpc_original.m` - original script we used before running simulations: `pct23_first_attempt.slx`, `pct23_second_attempt.slx`   
* `tunable_expmpc.m` - simulation of tunable explicit MPC in script
* `mpc_init.m` - initialization script to run before running `pct23_mpc.slx`
* `mpc_init_reference_tracking.m` - initialization script to run before running `pct23_mpc_ref_tracking.slx`
* `ploty.m` - script that can be used to visualize data

*Simulink schemes:*
* `pct23_first_attempt.slx` - first/original scheme we tried (with zero init. condition for integral part and function `MPC_fcn_first.m`)
* `pct23_second_attempt.slx` - difference form the `pct23_first_attempt.slx` scheme: we don't use zero init. condition for integral part
* `pct23_third_attempt.slx` - this scheme uses: delay blocks (because of the same Ts in script `mpc_modif.m`) and function `MPC_fcn.m` with only one input (x0)
* `pct23_P_reg.slx` - run this scheme to heat the water to the required temperature
* `pct23_mpc.slx` - latest version, uses: `MPC_fcn.m`, `mpc_init.m`
* `pct23_mpc_ref_tracking.slx` - reference tracking scheme

*Saved workspaces:*
* `ref_tracking1.mat`
* `ref_tracking2.mat`
* `ref_tracking3.mat`
* `ref_tracking4.mat`
* `ref_tracking5.mat`
* `ref_tracking6.mat`
