function [V_tank] = fuel_tank_volume

global data
%x = x .* data.x0;

import D_airfoil2.*
x = [4.24  0.98  20.04  4  -7  27  27  0.3156    0.2076    0.2577...
       0.1669    0.2176   0.1868   -0.1133   -0.0853   -0.2094   -0.0577...
       -0.1707     -0.1192  0.2712    0.2148    0.1857    0.1861  0.007801640961078...
       0.1684   0.1727   -0.0957   -0.0388   -0.2101   -0.0114   -0.1612...
       -0.0911   0.18206  0.5325  0.5655  0.6126  0.6634  0.7044...
       0.6999  0.6417  0.5542  0.4466  0.3245  0.1927  0.0568  -0.0717...
       -0.1574  -0.0196  -0.0177  -0.0162  -0.0147  -0.0127...
       -0.0110  -0.0105  -0.0105  -0.0107  -0.0110  -0.0116...
       -0.0128  -0.0157  -0.0228];

%Root Airfoil 
root_upper_CST = [x(8),  x(9),  x(10),  x(11),  x(12), x(13)];
root_lower_CST = [x(14), x(15), x(16), x(17), x(18), x(19)];

root_upper_CST = root_upper_CST';
root_lower_CST = root_lower_CST';

X = linspace(0,1,99)';

[Xtu_root, Xtl_root] = D_airfoil2(root_upper_CST,root_lower_CST,X);

x_u_root = Xtu_root(:,1);
y_u_root = Xtu_root(:,2);
x_l_root = Xtl_root(:,1);
y_l_root = Xtl_root(:,2);

%Tip Airfoil
tip_upper_CST = [x(20)   x(21)   x(22)   x(23)   x(24)   x(25)];
tip_lower_CST = [x(26)   x(27)   x(28)   x(29)   x(30)   x(31)];

tip_upper_CST = tip_upper_CST';
tip_lower_CST = tip_lower_CST';

[Xtu_tip, Xtl_tip] = D_airfoil2(tip_upper_CST,tip_lower_CST,X);

x_u_tip = Xtu_tip(:,1);
y_u_tip = Xtu_tip(:,2);
x_l_tip = Xtl_tip(:,1);
y_l_tip = Xtl_tip(:,2);

thickness_avg_root = 0;
thickness_avg_tip = 0;

for i=1:length(X)   
    thickness_avg_root = thickness_avg_root + (y_u_root(i)-y_l_root(i));
    thickness_avg_tip = thickness_avg_tip + (y_u_tip(i)-y_l_tip(i));
end

thickness_avg_tip = thickness_avg_tip/length(X);
thickness_avg_root = thickness_avg_root/length(X);


V_tank =(0.5*x(3)*0.85)*(x(1)+x(2))*(data.rearspar - data.frontspar)*0.5*(thickness_avg_root*x(1) + thickness_avg_tip*x(2));

end

