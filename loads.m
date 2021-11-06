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
%                    | ->     upper curve coeff.                <-|   | ->       lower curve coeff.       <-| 
AC.Wing.Airfoils   = [0.2171    0.3450    0.2975    0.2685    0.2893  -0.1299   -0.2388   -0.1635   -0.0476    0.0797;
                      0.2171    0.3450    0.2975    0.2685    0.2893  -0.1299   -0.2388   -0.1635   -0.0476    0.0797];
                  
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
res_loads = [loads.Wing.cl,loads.Wing.cm];



     