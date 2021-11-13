%% Test optimization for the aerodynamic viscous analysis
clear all
close all
clc

%chord_root =    %1
%chord_tip =     %2
%wingspan =      %3
%twist_kink =    %4
%twist_tip =     %5
%sweep_LE_in =   %6
%sweep_LE_out =  %7

           %| ->     upper curve coeff.                           <-|   | ->       lower curve coeff.       <-| 
%CST_root = [0.3156    0.2076    0.2577    0.1669    0.2176   0.1868   -0.1133   -0.0853   -0.2094   -0.0577   -0.1707     -0.1192];    %(8-19)
%CST_tip = [0.2712    0.2148    0.1857    0.1861    0.1684   0.1727   -0.0957   -0.0388   -0.2101   -0.0114   -0.1612     -0.0911];     %(19-31) 
%CLdes =         %32 
%CDwing =        %33
%Cl =            %(34 - 47)
%Cm =            %(48-61) 
%weight_wing =   %62 
%weight_fuel =   %63

global ref;
ref = [4.24  0.98  20.04  4  -7  27  27  0.3156    0.2076    0.2577    0.1669    0.2176   0.1868   -0.1133   -0.0853   -0.2094   -0.0577   -0.1707     -0.1192  0.2712    0.2148    0.1857    0.1861    0.1684   0.1727   -0.0957   -0.0388   -0.2101   -0.0114   -0.1612     -0.0911];
 

global constants;
constants.y = 3.66;
constants.dih = 4;

global out
out = coordinates(ref,constants)

% = [3.66   4];
%1 is y_kink
%2 is dihedral angle



%x0=ones(63); 

%lb= 0.8 * ones(63);

%ub= 1.2 * ones(63);

% constants definition 
%global 

% Options for the optimization
options.Display         = 'iter';
options.Algorithm       = 'sqp';
options.FunValCheck     = 'off';
options.DiffMinChange   = 1e-2;         % Minimum change while gradient searching
options.DiffMaxChange   = 2e-1;         % Maximum change while gradient searching
%options.TolCon          = 1e-6;         % Maximum difference between two subsequent constraint vectors [c and ceq]
 options.TolFun          = 1e-3;         % Maximum difference between two subsequent objective value
 options.TolX            = 5e-4;         % Maximum difference between two subsequent design vectors
%options.PlotFcns       =  {@optimplotfval, @optimplotx, @optimplotfirstorderopt};
options.MaxIter         = 50;           % Maximum iterations


%global res0

%res0=-1*init_aero_fun(x0);


tic;
[x,FVAL,EXITFLAG,OUTPUT] = fmincon(@(x) Optim_IDF(x),x0,[],[],[],[],lb,ub,@(x) constraints_IDF(x),options);
toc;