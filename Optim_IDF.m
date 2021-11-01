function [f,vararg] = Optim_IDF(x)
    CHORD_ROOT = x(1);
    TIP_ROOT = x(2);
    z2 = x(3);
    %Initial guess for output of discipline 2
    y1_c = x(4);  %wstr_wing_T din design vector
    y2_c = x(5);
        
    w_fuel = performance(chord_ROOT,z1,z2,y2_c);
    w_str_wing = structures(z1,z2,y1_c);

    f = objective(w_fuel,w_str_wing);
    
      
    global couplings;
    
    vararg = {y1,y2,y2_c,y1_c};
    couplings.y1 = y1;
    couplings.y2 = y2;
    
end