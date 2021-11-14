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
%cCl = [0.524874607466166,0.548320744826534,0.593089370768758,0.646088149959151,0.695727221107052,0.705942240866153,0.651767878959687,0.558536582440913,0.441203404701343,0.306883093976401,0.161893973542583,0.0137292634495788,-0.114297151149825,-0.171273404723309]]           %(34 - 47)
%Cm_c4 = [-0.0207920053865011,-0.0184823783325070,-0.0167621701339157,-0.0152574603745713,-0.0133017526337124,-0.0112845097359746,-0.0105211609575998,-0.0104947712141716,-0.0107112390556984,-0.0110596006926731,-0.0117991250792451,-0.0134395225454831,-0.0179380603456269,-0.0288047303048785]]           %(48-61) 
%weight_wing =   %62 
%weight_fuel =   %63

ref = [4.24  0.98  20.04  4  -7  27  27  0.3156    0.2076    0.2577...
       0.1669    0.2176   0.1868   -0.1133   -0.0853   -0.2094   -0.0577...
       -0.1707     -0.1192  0.2712    0.2148    0.1857    0.1861  0.007801640961078...
       0.1684   0.1727   -0.0957   -0.0388   -0.2101   -0.0114   -0.1612...
       -0.0911   0.18206  2.3527  2.3583  2.3596  2.3455  2.3048  2.2127...
       2.0801  1.9136  1.7202  1.5041  1.2683  1.0142  0.7409  0.4378...
       -0.1335  -0.0932  -0.0694  -0.0536  -0.0424...
       -0.0287  -0.0226  -0.0197  -0.0177  -0.0161  -0.0145...
       -0.0128  -0.0107  -0.0066  1245.4  3500];
 
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
