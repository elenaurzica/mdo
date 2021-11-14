namefile    =    char('our_airfoil');
x = [4.24  0.98  20.04  4  -7  27  27  0.3156    0.2076    0.2577...
       0.1669    0.2176   0.1868   -0.1133   -0.0853   -0.2094   -0.0577...
       -0.1707     -0.1192  0.2712    0.2148    0.1857    0.1861  0.007801640961078...
       0.1684   0.1727   -0.0957   -0.0388   -0.2101   -0.0114   -0.1612...
       -0.0911   0.18206  0.5248  0.5483  0.5931  0.6461  0.6957...
       0.7059  0.6517  0.5585  0.4412  0.3068  0.1619  0.0137  -0.1143...
       -0.1713  -0.0208  -0.0184  -0.0167  -0.0152  -0.0133  -0.0113...
       -0.0105  -0.0105  -0.0107  -0.0111  -0.0118  -0.0134  -0.0179...
       -0.0288];
  
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