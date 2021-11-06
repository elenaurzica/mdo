function [c,ceq] = constraints_IDF(x)
%function computing constraints of the sellar problem
global actual_results;
res_loads = actual_results.res_loads; 
res_aero = actual_results.res_aero; 
weight_fuel = actual_results.weight_fuel;
weight_str_wing = actual_results.weight_str_wing; 


%consistency constraints = target-actual variables
cc_cl = abs(res_loads[1:14] - x(34:47));  
cc_cm = abs(res_loads[15:28]- x(48:61));

cc_CL = abs(res_aero[1] - x(32));
cc_CD = abs(res_aero[2] - x(33));

cc_fuel = abs(weight_fuel - x(63));
cc_wing = abs(weight_str_wing - x(62));


%inequality constraints - fuel volume and wing loading
c1 = fuel_volume(x) - ERJ145_required_fuel_volume;
c2 = wing_loading(x)/wing_loading_ref - 1;   
c = [c1,c2];
ceq = [cc_cl, cc_cm, cc_CL, cc_CD, cc_fuel, cc_wing];
end