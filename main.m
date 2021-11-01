%% Test optimization for the aerodynamic viscous analysis
clear all
close all
clc

x0=design_Vector; %hardcoded ? function?

lb=[0.5,0];

ub=[3,2.5];


% Options for the optimization
options.Display         = 'iter';
options.Algorithm       = 'sqp';
options.FunValCheck     = 'off';
options.DiffMinChange   = 1e-2;         % Minimum change while gradient searching
options.DiffMaxChange   = 2e-1;         % Maximum change while gradient searching
%options.TolCon          = 1e-6;         % Maximum difference between two subsequent constraint vectors [c and ceq]
 options.TolFun          = 1e-3;         % Maximum difference between two subsequent objective value
 options.TolX            = 5e-4;         % Maximum difference between two subsequent design vectors
options.PlotFcns       =  {@optimplotfval, @optimplotx, @optimplotfirstorderopt};
options.MaxIter         = 50;           % Maximum iterations


%global res0

%res0=-1*init_aero_fun(x0);

tic;
[x,FVAL,EXITFLAG,OUTPUT] = fmincon(@(x) Optim_IDF(x),x0,[],[],[],[],lb,ub,@(x) constraints_IDF(x),options);
toc;