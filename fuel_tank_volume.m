function fuel_tank_volume(x)

global data
x = x .* data.x0;

chord_kink = (x(1)+data.y_kink*tand(0.1))-(data.y_kink*tand(x(6)));
V_tank_inboard = 0.5 * data.y_kink * (x(1)+chord_kink) * (data.rearspar - data.frontspar) ;