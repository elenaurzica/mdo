%% Aerodynamic solver setting
clear all
close all
clc

% Wing planform geometry 
%                x    y     z   chord(m)    twist angle (deg) 

global out
outputt = out;
%= [4.24  0.98  20.04  4  -7  27  27  0.3156    0.2076    0.2577    0.1669    0.2176   0.1868   -0.1133   -0.0853   -0.2094   -0.0577   -0.1707     -0.1192  0.2712    0.2148    0.1857    0.1861    0.1684   0.1727   -0.0957   -0.0388   -0.2101   -0.0114   -0.1612     -0.0911];
AC.Wing.Geom = outputt %coordinates(ref,constants);
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
AC.Aero.V     = 68;            % flight speed (m/s)
AC.Aero.rho   = 1.225;         % air density  (kg/m3)
AC.Aero.alt   = 0;             % flight altitude (m)
AC.Aero.Re    = 1.14e7;        % reynolds number (bqased on mean aerodynamic chord)
AC.Aero.M     = 0.2;           % flight Mach number 
% AC.Aero.CL    = 0.4;          % lift coefficient - comment this line to run the code for given alpha%
AC.Aero.Alpha = 2;             % angle of attack -  comment this line to run the code for given cl 


%% 
tic

Res = Q3D_solver(AC);
%plot(Res.Wing.Yst,Res.Wing.cl,Res.Section.Y, Res.Section.Cl)

toc