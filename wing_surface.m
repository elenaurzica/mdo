function wing_surface = wing_surface(x)
global data;

chord_kink = (x(1)+data.y_kink*tand(1))-(data.y_kink*tand(x(6)));  
wing_surface = (chord_kink + x(1))*data.y_kink*0.5 + (x(2)+chord_kink)*(x(3)/2-data.y_kink)*0.5;   
end
%function name = file name

