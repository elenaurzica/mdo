
function coordinate = coordinates(ref,constants)



y_kink = constants.y;
dihedral = constants.dih;

x_LE_kink = y_kink * tand(ref(6)); 
y_LE_kink = y_kink;
z_LE_kink = y_kink * tand(dihedral);

chord_kink = (ref(1) + y_kink * tan(0.1)) - x_LE_kink;

x_LE_tip = x_LE_kink + (0.5 * ref(3) - y_kink) * tan(ref(7)); 
y_LE_tip = ref(3)/2;
z_LE_tip = 0.5 * ref(3) * tan(dihedral);

coordinate = [0               0              0       ref(1)    0;
               x_LE_kink    y_LE_kink    z_LE_kink   chord_kink    4;
               x_LE_tip     y_LE_tip     z_LE_tip    ref(2)     -7];