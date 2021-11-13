function wing_surface = wing_surface(x)
global constants

x = [4.24  0.98  20.04  4  -7  27  27  0.3156    0.2076    0.2577    0.1669    0.2176   0.1868   -0.1133   -0.0853   -0.2094   -0.0577   -0.1707     -0.1192  0.2712    0.2148    0.1857    0.1861    0.1684   0.1727   -0.0957   -0.0388   -0.2101   -0.0114   -0.1612     -0.0911];

chord_kink = (x(1)+constants.y_kink*tand(0.1))-(constants.y_kink*tand(x(6)));   %chord_kink = (chord_root + constants.y_kink * tan(0.1)) - (y_kink * tan(sweep_LE_in);
wing_surface = (chord_kink + x(1))*constants.y_kink*0.5 + (x(2)+chord_kink)*(x(3)/2-constants.y_kink)*0.5;     %(chord_kink+chord_root)*y_kink*0.5 + (chord_tip+chord_kink)*(span/2 - y_kink)*0.5 ;

%function name = file name

