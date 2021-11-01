function surface = Wing_Surface(chord_root, chord_tip, sweep_LE_in, span, y_kink)
chord_kink = (chord_root + y_kink * tan(0.1)) - (y_kink * tan(sweep_LE_in);
surface = (chord_kink+chord_root)*y_kink*0.5 + (chord_tip+chord_kink)*(span/2 - y_kink)*0.5 ;

%function name = file name

