function [f,vararg] = Optim_IDF(x)
      
    global constants;
    
    %vararg = {res_loads, res_aero, weight_fuel, weight_str_wing};
    
    constants.res_loads = loads(x);
    constants.res_aero = aerodynamics(x);
    constants.weight_fuel = performance(x);
    constants.weight_str_wing = structures(x);

    f = objective(constants.weight_fuel,constants.weight_str_wing);
    
end