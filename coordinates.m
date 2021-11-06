function coordinate = coordinates(x)

x_LE_kink = y_kink * tan(sweep_LE_in); 
y_LE_kink = y_kink;
z_LE_kink = y_kink * tan(dihedral);

chord_kink = (chord_root + y_kink * tan(0.1)) - x_LE_kink;

x_LE_tip = x_LE_kink + (0.5 * span - y_kink) * tan(sweep_LE_out); 
y_LE_tip = span/2;
z_LE_tip = 0.5 * span * tan(dihedral);

coordinate = [0               0              0      chord_root    0;
               x_LE_kink    y_LE_kink    z_LE_kink   chord_kink    4;
               x_LE_tip     y_LE_tip     z_LE_tip    chord_tip     -7];