
function tip_airfoil_writer(Xtu,Xtl)

airfoil_root = fopen('airfoil_tip.dat','wt');

x_u_tip = Xtu(:,1);
y_u_tip = Xtu(:,2);
x_l_tip = Xtl(:,1);
y_l_tip = Xtl(:,2);

x_u_tip = flip(x_u_root);
y_u_tip = flip(y_u_root);


for point = 1:length(x_u_root)
    format_line = '%f %f \n';
    fprintf(airfoil_root, format_line, x_u_root(point), y_u_root(point));
end

for point = 1:length(x_l_root)
    format_line = '%f %f \n';
    fprintf(airfoil_root, format_line, x_l_root(point), y_l_root(point));
end

fclose('airfoil_tip.dat')


    