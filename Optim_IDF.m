function [f,vararg] = Optim_IDF(x)
      
    global actual_results;
    
    vararg = {res_loads, res_aero, weight_fuel, weight_str_wing};
    actual_results.res_loads = loads(x);
    actual_results.res_aero = aerodynamics(x);
    actual_results.weight_fuel = performance(x);
    actual_results.weight_str_wing = structures(x);

    f = objective(actual_results.weight_fuel,actual_results.weight_str_wing);
    
end