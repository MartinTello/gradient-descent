function surfContour(paramsRecta,allParamsRecta,J_paramsRecta)

% Grilla sobre la cual se va a calcular la funcion
b_vals = linspace(-0.5, 0.5, 100);
m_vals = linspace(-0.5, 0.85, 100);

% inicializamos J en una matriz de 0's
%   J es la funcion del error
J = zeros(length(m_vals), length(b_vals));

% llenamos J con los errores correspondientes a cada punto en la grilla
for i = 1:length(m_vals)
    for j = 1:length(b_vals)
	  t = [b_vals(i); m_vals(j)];    
	  J(j,i) = calcularCosto(t);
    end
end

% ploteo de la superficie
superficie(m_vals,b_vals,J,paramsRecta,allParamsRecta,J_paramsRecta);
fprintf('\n Presione enter para mostrar curvas de nivel \n')
%pause;
fprintf(' Ploteando...')
% ploteo de las curvas de nivel
curvaNivel(m_vals,b_vals,J,paramsRecta,allParamsRecta);





% Fin