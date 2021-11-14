function res_loads=loads(x)

MTOW = (x()wing + x()fuel + weight_A-W);
MTOW_lbs = MTOW * 2.2046;

nmax = 2.1 + (24000/MTOW_lbs+10000);

wing_surface = surface(x);

%% Aerodynamic solver setting

% Wing planform geometry 
%                x    y     z   chord(m)    twist angle (deg) 
AC.Wing.Geom = coordinates(x);

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
AC.Aero.Re    = ((wing_surface/x()wingspan) * AC.Aero.rho * AC.Aero.V)/(1.458e-5) ;        % reynolds number (bqased on mean aerodynamic chord)
AC.Aero.M     = 0.78;           % flight Mach number 
AC.Aero.CL    = (nmax * MTOW)/(0.5 * AC.Aero.V**2 * AC.Aero.rho * wing_surface);   % target lift coefficient - comment this line to run the code for given alpha%
% AC.Aero.Alpha = 2;             % angle of attack -  comment this line to run the code for given cl 


%% 

loads = Q3D_solver(AC);

xpos = [loads.Wing.Yst];
ypos1 = [loads.Wing.ccl];
ypos2 = [loads.Wing.cm_c4];

xq = [0, x(3)/14, 2*x(3)/14,  3*x(3)/14, 4*x(3)/14, 5*x(3)/14, 6*x(3)/14, 7*x(3)/14 ...;
     8*x(3)/14, 9*x(3)/14, 10*x(3)/14, 11*x(3)/14, 12*x(3)/14,  13*x(3)/14, 14*x(3)/14];
 
output_ccl = spline(xpos,ypos1,xq);
output_cm_c4 = spline(xpos,ypos2,xq);
res_loads = [output_ccl   output_cm_c4];



     