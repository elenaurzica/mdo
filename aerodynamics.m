function res_aero=aerodynamics(x)
%% Aerodynamic solver setting
global constants

x = x .* constants.x0;  %DENORMALIZING DESIGN VECTOR BC x0 is normalised

MTOW = x(62) + x(63) + constants.ctw; %(x()wing + x()fuel + constants.ctw);  %des_vec =normalized. times absolute nonormalized reference data vector
MTOW_lbs = MTOW * 2.2046;

x_LE_kink = constants.y_kink * tand(x(6)); 
y_LE_kink = constants.y_kink;
z_LE_kink = constants.y_kink * tand(constants.dihedral);

chord_kink = (x(1) + constants.y_kink * tand(0.1)) - x_LE_kink;

x_LE_tip = x_LE_kink + (0.5 * x(3) - constants.y_kink) * tand(x(7)); 
y_LE_tip = x(3)/2;
z_LE_tip = 0.5 * x(3) * tand(constants.dihedral);

% Wing planform geometry 
%                x           y               z           chord(m)            twist angle (deg) 
AC.Wing.Geom =  [0           0              0           x(1)                constants.root_kink;
               x_LE_kink    y_LE_kink    z_LE_kink      chord_kink           x(4);
               x_LE_tip     y_LE_tip     z_LE_tip       x(2)                x(5)];

% Wing incidence angle (degree)
AC.Wing.inc  = 0;          
% Airfoil coefficients input matrix
%                    | ->     upper curve coeff.                           <-|   | ->       lower curve coeff.       <-| 
AC.Wing.Airfoils   =  [x(8)  x(9)  x(10)  x(11)  x(12) x(13) x(14) x(15) x(16) x(17) x(18) x(19);
                        x(20)   x(21)   x(22)   x(23)   x(24)   x(25)   x(26)   x(27)   x(28)   x(29)   x(30)   x(31)];
    
%[0.3156    0.2076    0.2577    0.1669    0.2176   0.1868   -0.1133   -0.0853   -0.2094   -0.0577   -0.1707     -0.1192;
                      %0.2712    0.2148    0.1857    0.1861    0.1684   0.1727   -0.0957   -0.0388   -0.2101   -0.0114   -0.1612     -0.0911];
                  
                  
                  
AC.Wing.eta = [0;1];  % Spanwise location of the airfoil sections

% Viscous vs inviscid
AC.Visc  = 1;              % 0 for inviscid and 1 for viscous analysis

% Flight Condition
AC.Aero.V     = 194.35;            % Vmo (max operating flight speed (m/s))
AC.Aero.rho   = 0.4135;            % cruise air density  (kg/m3)
AC.Aero.alt   = 10000;             % cruise flight altitude (m)
AC.Aero.Re    = ((wing_surface(x)/x(3)) * AC.Aero.rho * AC.Aero.V)/(1.458E-5) ;  % reynolds number (based on mean aerodynamic chord)
AC.Aero.M     = 0.65;              % flight Mach number 
AC.Aero.CL    = x(32); %x()clwingtarget;   % target lift coefficient - comment this line to run the code for given alpha%
% AC.Aero.Alpha = 2;               % angle of attack -  comment this line to run the code for given cl 


%% 

aero = Q3D_solver(AC);
res_aero = [aero.Wing.CL, aero.Wing.CD];




     