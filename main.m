%% Test optimization for the aerodynamic viscous analysis
clear all
close all
clc

global data
import wing_area.* %to import wing AREA FUNCTION AND ALL FUNCTIONS
import constraints.*

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
%CLdes = 0.182060000000000       %32 
%CDwing = 0.007801640961078      %33
%cCl = [0.532500000000000;0.565500000000000;0.612600000000000;0.663400000000000;0.704400000000000;0.699900000000000;0.641700000000000;0.554200000000000;0.446600000000000;0.324500000000000;0.192700000000000;0.0568000000000000;-0.0717000000000000;-0.157400000000000]           %(34 - 47)
%Cm_c4 = [-0.0196000000000000;-0.0177000000000000;-0.0162000000000000;-0.0147000000000000;-0.0127000000000000;-0.0110000000000000;-0.0105000000000000;-0.0105000000000000;-0.0107000000000000;-0.0110000000000000;-0.0116000000000000;-0.0128000000000000;-0.0157000000000000;-0.0228000000000000]           %(48-61) 
%weight_wing =   %62 
%weight_fuel =   %63

ref = [4.24  0.98  20.04  4  -7  27  27  0.3156    0.2076    0.2577...
       0.1669    0.2176   0.1868   -0.1133   -0.0853   -0.2094   -0.0577...
       -0.1707     -0.1192  0.2712    0.2148    0.1857    0.1861  0.007801640961078...
       0.1684   0.1727   -0.0957   -0.0388   -0.2101   -0.0114   -0.1612...
       -0.0911   0.18206  0.5325  0.5655  0.6126  0.6634  0.7044...
       0.6999  0.6417  0.5542  0.4466  0.3245  0.1927  0.0568  -0.0717...
       -0.1574  -0.0196  -0.0177  -0.0162  -0.0147  -0.0127...
       -0.0110  -0.0105  -0.0105  -0.0107  -0.0110  -0.0116...
       -0.0128  -0.0157  -0.0228];
 
data.x0 = abs(ref)

x0 = ref./abs(ref)

%lb= 0.8 * ones(63);

%ub= 1.2 * ones(63);



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
