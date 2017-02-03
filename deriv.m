function d=deriv(x)

y = x;
y = [x(1), y(1:end-1)];

d = abs(x-y);

end