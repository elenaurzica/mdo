function res_loads=loads(x)

global data;

import MAC.*
x = [4.24  0.98  20.04  4  -7  27  27  0.3156    0.2076    0.2577...
       0.1669    0.2176   0.1868   -0.1133   -0.0853   -0.2094   -0.0577...
       -0.1707     -0.1192  0.2712    0.2148    0.1857    0.1861  0.007801640961078...
       0.1684   0.1727   -0.0957   -0.0388   -0.2101   -0.0114   -0.1612...
       -0.0911   0.18206  0.5248  0.5483  0.5931  0.6461  0.6957...
       0.7059  0.6517  0.5585  0.4412  0.3068  0.1619  0.0137  -0.1143...
       -0.1713  -0.0208  -0.0184  -0.0167  -0.0152  -0.0133  -0.0113...
       -0.0105  -0.0105  -0.0107  -0.0111  -0.0118  -0.0134  -0.0179...
       -0.0288];

MTOW = 19200; %reference
MTOW_lbs = MTOW * 2.2046;

nmax = 2.1 + (24000/MTOW_lbs+10000);


%% Aerodynamic solver setting
x_LE_kink = data.y_kink * tand(x(6)); 
y_LE_kink = data.y_kink;
z_LE_kink = data.y_kink * tand(data.dihedral);

chord_kink = (x(1) + data.y_kink * tand(0.1)) - x_LE_kink;

x_LE_tip = x_LE_kink + (0.5 * x(3) - data.y_kink) * tand(x(7)); 
y_LE_tip = x(3)/2;
z_LE_tip = 0.5 * x(3) * tand(data.dihedral);
% Wing planform geometry 
%                x    y     z   chord(m)    twist angle (deg) 
AC.Wing.Geom = [0               0              0       x(1)    0;
               x_LE_kink    y_LE_kink    z_LE_kink   chord_kink    4;
               x_LE_tip     y_LE_tip     z_LE_tip       x(2)     -7];

% Wing incidence angle (degree)
AC.Wing.inc  = 0;   
            
% Tavi add CST !!!!!!!!!! you fucking moron             
% Airfoil coefficients input matrix
%                    | ->     upper curve coeff.                           <-|   | ->       lower curve coeff.       <-| 
AC.Wing.Airfoils   = [0.3156    0.2076    0.2577    0.1669    0.2176   0.1868   -0.1133   -0.0853   -0.2094   -0.0577   -0.1707     -0.1192;
                      0.2712    0.2148    0.1857    0.1861    0.1684   0.1727   -0.0957   -0.0388   -0.2101   -0.0114   -0.1612     -0.0911];
                  
                  
                  
AC.Wing.eta = [0;1];  % Spanwise location of the airfoil sections

% Viscous vs inviscid
AC.Visc  = 0;              % 0 for inviscid and 1 for viscous analysis

% Flight Condition
AC.Aero.V     = 233.22;            % Vmo (max operating flight speed (m/s))
AC.Aero.rho   = 0.4135;         % cruise air density  (kg/m3)
AC.Aero.alt   = 10000;             % cruise flight altitude (m)
AC.Aero.Re    = (MAC(x)* AC.Aero.rho * AC.Aero.V)/(1.458e-5) ;        % reynolds number (bqased on mean aerodynamic chord)
AC.Aero.M     = 0.78;           % flight Mach number 
AC.Aero.CL    = (nmax * MTOW)/(0.5 * AC.Aero.V^2 * AC.Aero.rho * wing_surface);   % target lift coefficient - comment this line to run the code for given alpha%
% AC.Aero.Alpha = 2;             % angle of attack -  comment this line to run the code for given cl 


%% 

Res = Q3D_solver(AC);

%xpos = [loads.Wing.Yst];
%ypos1 = [loads.Wing.ccl];
%ypos2 = [loads.Wing.cm_c4];

%xq = [0, x(3)/14, 2*x(3)/14,  3*x(3)/14, 4*x(3)/14, 5*x(3)/14, 6*x(3)/14, 7*x(3)/14 ...;
    % 8*x(3)/14, 9*x(3)/14, 10*x(3)/14, 11*x(3)/14, 12*x(3)/14,  13*x(3)/14, 14*x(3)/14];
 
%output_ccl = spline(xpos,ypos1,xq);
%output_cm_c4 = spline(xpos,ypos2,xq);
%res_loads = [output_ccl   output_cm_c4];

%plot(Res.Wing.Yst,Res.Wing.ccl)

L=Res.Wing.ccl.*0.5*AC.Aero.rho*AC.Aero.V.^2; %L=c*Cl*q


M=Res.Wing.chord.*MAC.*Res.Wing.cm_c4.*0.5*AC.Aero.rho*AC.Aero.V.^2; %M=c*MAC*cm*q;

Y_loc=Res.Wing.Yst./14;

mat=[Y_loc L M];

fid=fopen('our_airfoil.load','wt');
    fprintf(fid,'%g %g %g\n',0,L(1),M(1)); %Y_loc L M % JE MOET OP ROOT AND TIP LOCATIES EEN LIFT EN MOMENT HEBBEN, ANDERS VERKEERDE WING WEIGHT!!
    for i=1:length(Y_loc)
    fprintf(fid,'%g %g %g\n',Y_loc(i),L(i),M(i));  %Y_loc L M
    end
    fprintf(fid,'%g %g %g\n',1,L(end),M(end));  %Y_loc L M

fclose(fid); 


     