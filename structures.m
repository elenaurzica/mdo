function structures = structures(x)
%EMWET our_airfoil
global data
%x = x .* data.x0;

import D_airfoil2.*
import write_init.*

x = [4.24  0.98  20.04  4  -7  27  27  0.3156    0.2076    0.2577...
       0.1669    0.2176   0.1868   -0.1133   -0.0853   -0.2094   -0.0577...
       -0.1707     -0.1192  0.2712    0.2148    0.1857    0.1861  0.007801640961078...
       0.1684   0.1727   -0.0957   -0.0388   -0.2101   -0.0114   -0.1612...
       -0.0911   0.18206  2.3527  2.3583  2.3596  2.3455  2.3048  2.2127...
       2.0801  1.9136  1.7202  1.5041  1.2683  1.0142  0.7409  0.4378...
       -0.1335  -0.0932  -0.0694  -0.0536  -0.0424...
       -0.0287  -0.0226  -0.0197  -0.0177  -0.0161  -0.0145...
       -0.0128  -0.0107  -0.0066  1245.4  3500];

root_upper_CST = [x(8),  x(9),  x(10),  x(11),  x(12), x(13)];
root_lower_CST = [x(14), x(15), x(16), x(17), x(18), x(19)];

root_upper_CST = root_upper_CST';
root_lower_CST = root_lower_CST';

X = linspace(0,1,99)';

[Xtu_root, Xtl_root] = D_airfoil2(root_upper_CST,root_lower_CST,X);
root_airfoil_writer(Xtu_root, Xtl_root);

tip_upper_CST = [x(20)   x(21)   x(22)   x(23)   x(24)   x(25)];
tip_lower_CST = [x(26)   x(27)   x(28)   x(29)   x(30)   x(31)];

tip_upper_CST = tip_upper_CST';
tip_lower_CST = tip_lower_CST';

[Xtu_tip, Xtl_tip] = D_airfoil2(tip_upper_CST,tip_lower_CST,X);
tip_airfoil_writer(Xtu_tip, Xtl_tip);


x_LE_kink = data.y_kink * tand(x(6)); 
y_LE_kink = data.y_kink;
z_LE_kink = data.y_kink * tand(data.dihedral);

chord_kink = (x(1) + data.y_kink * tand(0.1)) - x_LE_kink;

x_LE_tip = x_LE_kink + (0.5 * x(3) - data.y_kink) * tand(x(7)); 
y_LE_tip = x(3)/2;
z_LE_tip = 0.5 * x(3) * tand(data.dihedral);

write_init(x)

L=x(34:47).*0.5*1.225*150^2; %L=c*Cl*q

M=MAC(x).*x(48:61).*0.5*1.225*150^2; %M=c*MAC*cm*q;

Y_loc=linspace(0,1,14);

mat=[Y_loc L M];

fid=fopen('our_airfoil.load','wt');
    fprintf(fid,'%g %g %g\n',0,L(1),M(1)); %Y_loc L M % JE MOET OP ROOT AND TIP LOCATIES EEN LIFT EN MOMENT HEBBEN, ANDERS VERKEERDE WING WEIGHT!!
    for i=1:length(Y_loc)
    fprintf(fid,'%g %g %g\n',Y_loc(i),L(i),M(i));  %Y_loc L M
    end
    fprintf(fid,'%g %g %g\n',1,L(end),M(end));  %Y_loc L M

fclose(fid); 

EMWET our_airfoil

weightfile = fileread("our_airfoil.weight");
floats = regexp(weightfile, '[+-]?([0-9]*[.])?[0-9]+', 'match');
structures  = str2double(floats(1,1));


end


