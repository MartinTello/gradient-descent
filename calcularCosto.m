function J = calcularCosto(paramsRecta)

global y;
global x;

N = length(y); % numero de puntos (entrenamiento)
%X*paramsRecta es el (mx+b)
%h-y es (y-(mx+b))
errors = sum(((x * paramsRecta) - y).^2);

%la division por la cantidad
J = (( 1 / (2 * N)) * errors);

end