function write_load = write_load(x)
namefile    =    char('our_airfoil');

  
spanwise = res_loads(3)/(x(3)/2);

Lift = x(34:47) * (0.5 * 0.4135 * 233.22^2); 
Mom = x(48:61) * (MAC(x) * 0.5* 0.4135 * 233.22^2) ;

fid = fopen( 'our_airfoil.load','wt');
fprintf(fid, '%g %g %g \n',spanwise(1),Lift(1),Mom(1));
fprintf(fid, '%g %g %g \n',spanwise(2),Lift(2),Mom(3));
fprintf(fid, '%g %g %g \n',spanwise(3),Lift(3),Mom(3));
fprintf(fid, '%g %g %g \n',spanwise(4),Lift(4),Mom(4));
fprintf(fid, '%g %g %g \n',spanwise(5),Lift(5),Mom(5));
fprintf(fid, '%g %g %g \n',spanwise(6),Lift(6),Mom(6));
fprintf(fid, '%g %g %g \n',spanwise(7),Lift(7),Mom(7));
fprintf(fid, '%g %g %g \n',spanwise(8),Lift(8),Mom(8));
fprintf(fid, '%g %g %g \n',spanwise(9),Lift(9),Mom(9));
fprintf(fid, '%g %g %g \n',spanwise(10),Lift(10),Mom(10));
fprintf(fid, '%g %g %g \n',spanwise(11),Lift(11),Mom(11));
fprintf(fid, '%g %g %g \n',spanwise(12),Lift(12),Mom(12));
fprintf(fid, '%g %g %g \n',spanwise(13),Lift(13),Mom(13));
fprintf(fid, '%g %g %g \n',spanwise(14),Lift(14),Mom(14));
fclose(fid)
end