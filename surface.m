function wing_surface = wing_surface(x)
global constants



chord_kink = (x(1)+constants.y_kink*tand(0.1))-(constants.y_kink*tand(x(6)));   %chord_kink = (chord_root + constants.y_kink * tan(0.1)) - (y_kink * tan(sweep_LE_in);
wing_surface = (chord_kink_x(1))*constants.y_kink*0.5     %(chord_kink+chord_root)*y_kink*0.5 + (chord_tip+chord_kink)*(span/2 - y_kink)*0.5 ;

%function name = file name

