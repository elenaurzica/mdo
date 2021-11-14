%% Aerodynamic solver setting

global data;

x = [4.24  0.98  20.04  4  -7  27  27  0.3156    0.2076    0.2577    0.1669    0.2176   0.1868   -0.1133   -0.0853   -0.2094   -0.0577   -0.1707     -0.1192  0.2712    0.2148    0.1857    0.1861    0.1684   0.1727   -0.0957   -0.0388   -0.2101   -0.0114   -0.1612     -0.0911];

MTOW_ref = 19200; %value for EMB 145 

x_LE_kink = data.y_kink * tand(x(6)); 
y_LE_kink = data.y_kink;
z_LE_kink = data.y_kink * tand(data.dihedral);

chord_kink = (x(1) + data.y_kink * tand(1)) - x_LE_kink;

x_LE_tip = x_LE_kink + (0.5 * x(3) - data.y_kink) * tand(x(7)); 
y_LE_tip = x(3)/2;
z_LE_tip = 0.5 * x(3) * tand(data.dihedral);


% Wing planform geometry 
%                x    y     z   chord(m)    twist angle (deg)
AC.Wing.Geom =  [0               0              0       x(1)    0;
               x_LE_kink    y_LE_kink    z_LE_kink   chord_kink    4;
               x_LE_tip     y_LE_tip     z_LE_tip       x(2)     -7];
% Wing incidence angle (degree)
AC.Wing.inc  = 0;   
            
            
% Airfoil coefficients input matrix
%                    | ->     upper curve coeff.                <-|   | ->       lower curve coeff.       <-| 
AC.Wing.Airfoils   = [0.3156    0.2076    0.2577    0.1669    0.2176   0.1868   -0.1133   -0.0853   -0.2094   -0.0577   -0.1707     -0.1192;
                      0.2712    0.2148    0.1857    0.1861    0.1684   0.1727   -0.0957   -0.0388   -0.2101   -0.0114   -0.1612     -0.0911];
                  
AC.Wing.eta = [0;1];  % Spanwise location of the airfoil sections

% Viscous vs inviscid
AC.Visc  = 1;              % 0 for inviscid and 1 for viscous analysis
AC.Aero.MaxIterIndex = 150;    %Maximum number of Iteration for the
                                %convergence of viscous calculation
                                
                                
% Flight Condition
AC.Aero.V     = 150;            % flight speed (m/s)
AC.Aero.rho   = 1.225;         % air density  (kg/m3)
AC.Aero.alt   = 0;             % flight altitude (m)
AC.Aero.Re    = (MAC(x)*AC.Aero.V*1.225)/(1.8*10^-5);        % reynolds number (bqased on mean aerodynamic chord)
AC.Aero.M     = AC.Aero.V/343;           % flight Mach number 
AC.Aero.CL    = (MTOW_ref * 9.8 * 2.6)/(0.5*(AC.Aero.V^2)*2*wing_surface(x)*1.225);          % lift coefficient - comment this line to run the code for given alpha%
%AC.Aero.Alpha = 2;             % angle of attack -  comment this line to run the code for given cl 


%% 
tic

Res = Q3D_solver(AC);

L=Res.Wing.ccl.*0.5*AC.Aero.rho*AC.Aero.V.^2; %L=c*Cl*q


M=Res.Wing.chord.*MAC(x).*Res.Wing.cm_c4.*0.5*AC.Aero.rho*AC.Aero.V.^2; %M=c*MAC*cm*q;

Y_loc=Res.Wing.Yst./14;

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

toc