function y = output_function(x,~)
% Output function — Calculates plant outputs in terms of state and input variables
y = zeros(3,1);
y(1) = x(1);
y(2) = x(8);
y(3) = x(12);

end