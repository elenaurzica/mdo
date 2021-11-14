%%%_____Routine to write the input file for the EMWET procedure________% %%
function write_init = write_init(x)
global data

%x = x .* data.x0;

%x = x .* constants.x0;
x = [4.24  0.98  20.04  4  -7  27  27  0.3156    0.2076    0.2577...
       0.1669    0.2176   0.1868   -0.1133   -0.0853   -0.2094   -0.0577...
       -0.1707     -0.1192  0.2712    0.2148    0.1857    0.1861  0.007801640961078...
       0.1684   0.1727   -0.0957   -0.0388   -0.2101   -0.0114   -0.1612...
       -0.0911   0.18206  0.5248  0.5483  0.5931  0.6461  0.6957...
       0.7059  0.6517  0.5585  0.4412  0.3068  0.1619  0.0137  -0.1143...
       -0.1713  -0.0208  -0.0184  -0.0167  -0.0152  -0.0133  -0.0113...
       -0.0105  -0.0105  -0.0107  -0.0111  -0.0118  -0.0134  -0.0179...
       -0.0288];

x_LE_kink = data.y_kink * tand(x(6)); 
y_LE_kink = data.y_kink;
z_LE_kink = data.y_kink * tand(data.dihedral);

chord_kink = (x(1) + data.y_kink * tand(1)) - x_LE_kink;

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
sweep_le    =    5;             %[deg]
spar_front  =    0.15;
spar_rear   =    0.6;
ftank_start =    0.1;
ftank_end   =    0.85;
eng_num     =    0;
eng_ypos    =    0;
eng_mass    =    0;         %kg
E_al        =    7e10;       %N/m2
rho_al      =    2800;         %kg/m3
Ft_al       =    2.95e8;        %N/m2
Fc_al       =    2.95e8;        %N/m2
pitch_rib   =    0.5;          %[m]
eff_factor  =    0.96;             %Depend on the stringer type
Airfoil_root     =  'airfoil_root';
Airfoil_tip     =   'airfoil_tip';
section_num =    3;
airfoil_num =    2;
wing_surf   =     wing_surface(x) * 2;  %0.5*x(1)*(1+(x(2)/x(1)))*x(3);

fid = fopen( 'our_airfoil.init','wt');
fprintf(fid, '%g %g \n',MTOW,MZF);
fprintf(fid, '%g \n',nz_max);

fprintf(fid, '%g %g %g %g \n',wing_surf,span,section_num,airfoil_num);

fprintf(fid, '0 %s \n',Airfoil_root);
fprintf(fid, '1 %s \n',Airfoil_tip);
fprintf(fid, '%g %g %g %g %g %g \n',x(1),   0,  0,  0,  spar_front, spar_rear);  %done
fprintf(fid, '%g %g %g %g %g %g \n',    chord_kink,     x_LE_kink,  y_LE_kink,  z_LE_kink,  spar_front, spar_rear);  %done
fprintf(fid, '%g %g %g %g %g %g \n',x(2),   x_LE_tip,   y_LE_tip,   z_LE_tip,   spar_front, spar_rear);  %done

fprintf(fid, '%g %g \n',ftank_start,ftank_end);

fprintf(fid, '%g \n', eng_num);
%fprintf(fid, '%g  %g \n', eng_ypos,eng_mass);

fprintf(fid, '%g %g %g %g \n',E_al,rho_al,Ft_al,Fc_al);
fprintf(fid, '%g %g %g %g \n',E_al,rho_al,Ft_al,Fc_al);
fprintf(fid, '%g %g %g %g \n',E_al,rho_al,Ft_al,Fc_al);
fprintf(fid, '%g %g %g %g \n',E_al,rho_al,Ft_al,Fc_al);

fprintf(fid,'%g %g \n',eff_factor,pitch_rib)
fprintf(fid,'1 \n')
fclose(fid)
end