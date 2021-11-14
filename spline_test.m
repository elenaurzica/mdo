xpos = [Res.Wing.Yst];
ypos1 = [Res.Wing.ccl];
ypos2 = [Res.Wing.cm_c4];

x(3) = x(3)/2;

xq = [0, x(3)/14, 2*x(3)/14,  3*x(3)/14, 4*x(3)/14, 5*x(3)/14, 6*x(3)/14, 7*x(3)/14 ...;
     8*x(3)/14, 9*x(3)/14, 10*x(3)/14, 11*x(3)/14, 12*x(3)/14,  13*x(3)/14, 14*x(3)/14];
 
output_ccl = spline(xpos,ypos1,xq)
output_cm_c4 = spline(xpos,ypos2,xq)





