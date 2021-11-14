function structures = structures(x)
%EMWET our_airfoil
global data
%x = x .* data.x0;

import D_airfoil2.*
x = [4.24  0.98  20.04  4  -7  27  27  0.3156    0.2076    0.2577...
       0.1669    0.2176   0.1868   -0.1133   -0.0853   -0.2094   -0.0577...
       -0.1707     -0.1192  0.2712    0.2148    0.1857    0.1861  0.007801640961078...
       0.1684   0.1727   -0.0957   -0.0388   -0.2101   -0.0114   -0.1612...
       -0.0911   0.18206  0.5248  0.5483  0.5931  0.6461  0.6957...
       0.7059  0.6517  0.5585  0.4412  0.3068  0.1619  0.0137  -0.1143...
       -0.1713  -0.0208  -0.0184  -0.0167  -0.0152  -0.0133  -0.0113...
       -0.0105  -0.0105  -0.0107  -0.0111  -0.0118  -0.0134  -0.0179...
       -0.0288];

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


namefile    =    char('our_airfoil');
MTOW        =    19200; %(x(62) + x(63) + data.weight_A-W);     %20820;         %[kg]
MZF         =     17100;    %data.weight_A-W +x(62);  % a-w minus w_str_wing         %[kg]
nz_max      =    2.5;   
span        =    x(3);            %[m]
root_chord =    x(1);    %x()*x_Ref       %[m]
taper       =    x(2)/x(1) ;          
%sweep_le    =    5;             %[deg]
spar_front  =    0.15;
spar_rear   =    0.6;
ftank_start =    0;
ftank_end   =    0.85;
eng_num     =    0;
eng_ypos    =    0.25;
eng_mass    =    1200;         %kg
E_al        =    7E10;       %N/m2
rho_al      =    2800;         %kg/m3
Ft_al       =    2.95E8;        %N/m2
Fc_al       =    2.95E8;        %N/m2
pitch_rib   =    0.5;          %[m]
eff_factor  =    0.96;             %Depend on the stringer type
Airfoil_root     =    'airfoil_root';
Airfoil_tip     =     'airfoil_tip';
section_num =    3;
airfoil_num =    2;
wing_surf   =    wing_surface(x) * 2; %0.5*x(1)*(1+(x(2)/x(1)))*span;

fid = fopen( 'our_airfoil.init','wt');
fprintf(fid, '%g %g \n',MTOW,MZF);
fprintf(fid, '%g \n',nz_max);

fprintf(fid, '%g %g %g %g \n',wing_surf,span,section_num,airfoil_num);

fprintf(fid, '0 %s \n',Airfoil_root);
fprintf(fid, '1 %s \n',Airfoil_tip);
fprintf(fid, '%g %g %g %g %g %g \n',x(1),0,0,0,spar_front,spar_rear);  %done
fprintf(fid, '%g %g %g %g %g %g \n',chord_kink,x_LE_kink,y_LE_kink,z_LE_kink,spar_front,spar_rear);  %done
fprintf(fid, '%g %g %g %g %g %g \n',x(2),x_LE_tip,y_LE_tip,z_LE_tip,spar_front,spar_rear);  %done

fprintf(fid, '%g %g \n',ftank_start,ftank_end);

fprintf(fid, '%g \n', eng_num);
fprintf(fid, '%g  %g \n', eng_ypos,eng_mass);

fprintf(fid, '%g %g %g %g \n',E_al,rho_al,Ft_al,Fc_al);
fprintf(fid, '%g %g %g %g \n',E_al,rho_al,Ft_al,Fc_al);
fprintf(fid, '%g %g %g %g \n',E_al,rho_al,Ft_al,Fc_al);
fprintf(fid, '%g %g %g %g \n',E_al,rho_al,Ft_al,Fc_al);

fprintf(fid,'%g %g \n',eff_factor,pitch_rib)
fprintf(fid,'1 \n')
fclose(fid)

namefile    =    char('our_airfoil');

spanwise = res_loads(3)/(x(3)/2);

Lift = x(34:47) * (0.5 * 0.4135 * 233.22^2); 
Mom = x(48:61) * (MAC(x) * 0.5* 0.4135 * 233.22^2) ;

fid = fopen( 'our_airfoil.load','wt');
fprintf(fid, '%g %g %g \n',spanwise(1),Lift(1),Mom(1));
fprintf(fid, '%g %g %g \n',spanwise(2),Lift(2),Mom(3));
fprintf(fid, '%g %g %g \n',spanwise(3),Lift(3),Mom(3));
fprintf(fid, '%g %g %g \n',spanwise(4),Lift(4),Mom(4));
fprintf(fid, '%g %g %g \n',spanwise(5),Lift(5),Mom(5));
fprintf(fid, '%g %g %g \n',spanwise(6),Lift(6),Mom(6));
fprintf(fid, '%g %g %g \n',spanwise(7),Lift(7),Mom(7));
fprintf(fid, '%g %g %g \n',spanwise(8),Lift(8),Mom(8));
fprintf(fid, '%g %g %g \n',spanwise(9),Lift(9),Mom(9));
fprintf(fid, '%g %g %g \n',spanwise(10),Lift(10),Mom(10));
fprintf(fid, '%g %g %g \n',spanwise(11),Lift(11),Mom(11));
fprintf(fid, '%g %g %g \n',spanwise(12),Lift(12),Mom(12));
fprintf(fid, '%g %g %g \n',spanwise(13),Lift(13),Mom(13));
fprintf(fid, '%g %g %g \n',spanwise(14),Lift(14),Mom(14));
fclose(fid)

EMWET our_airfoil

weightfile = fileread("our_airfoil.weight");
floats = regexp(weightfile, '[+-]?([0-9]*[.])?[0-9]+', 'match');
weight  = str2double(floats(1,1));
end




