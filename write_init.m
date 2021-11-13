%%%_____Routine to write the input file for the EMWET procedure________% %%

global constants

%x = x .* constants.x0;

x = [4.24  0.98  20.04  4  -7  27  27  0.3156    0.2076    0.2577    0.1669    0.2176   0.1868   -0.1133   -0.0853   -0.2094   -0.0577   -0.1707     -0.1192  0.2712    0.2148    0.1857    0.1861    0.1684   0.1727   -0.0957   -0.0388   -0.2101   -0.0114   -0.1612     -0.0911];


x_LE_kink = constants.y_kink * tand(x(6)); 
y_LE_kink = constants.y_kink;
z_LE_kink = constants.y_kink * tand(constants.dihedral);

chord_kink = (x(1) + constants.y_kink * tand(0.1)) - x_LE_kink;

x_LE_tip = x_LE_kink + (0.5 * x(3) - constants.y_kink) * tand(x(7)); 
y_LE_tip = x(3)/2;
z_LE_tip = 0.5 * x(3) * tand(constants.dihedral);


namefile    =    char('Fokker50');
MTOW        =    (x(62) + x(63) + constants.weight_A-W);     %20820;         %[kg]
MZF         =    constants.weight_A-W + x(62);  % a-w minus w_str_wing         %[kg]
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
Airfoil_root     =    'b737a';
Airfoil_tip     =     'b737d';
section_num =    3;
airfoil_num =    2;
wing_surf   =    wing_surface(x) * 2; %0.5*x(1)*(1+(x(2)/x(1)))*span;

fid = fopen( 'Fokker50test.init','wt');
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