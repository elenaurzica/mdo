function fuel_weight = performance(x)

MTOW = (x()wing + x()fuel + weight_A-W);

LD_ratio = x()CLwingtarget/(x()CDwing + D_A_W/(0.5 * rho * V **2 * surface(x));

weight_ratio = exp((R*C_T)/(V*LD_ratio));

fuel_weight = (1-0.938*weight_ratio)*MTOW;

end