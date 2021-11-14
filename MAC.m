function MAC = MAC(x)

global data

%x = x .*data.x0;

taper = x(2)/x(1);

MAC = (2/3)*x(1)*((1+taper+taper^2)/(1+taper));
end

