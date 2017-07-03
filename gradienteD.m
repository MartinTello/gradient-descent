function [allPR paramsRecta J gd_plot] = gradienteD(paramsRecta, handles)
% paramsRecta = valor estimado || guess || theta
% J es la funcion que quiero minimizar. Es la funcion de costo.
% allPR son todos los parametros de las rectoas que va encontrando la iteracion

%   Esta funcion actualiza los parametros de la recta realizando iter pasos con
%   alpha como learning rate

% Variables en Handles
x = handles.x;
y = handles.y;
learningRate = handles.learningRate;
iterations = handles.iters;
N = handles.N;

% Variables locales
allPR = zeros(N,2);
J = zeros(iterations,1);
fprintf('\n Iterando')
hold on;

a=linspace(-10,50,60);
m=length(a);
a = [ones(m, 1), a'];

axes(handles.axes1);
gd_plot = plot(handles.axes1, a(:,2), a * paramsRecta,'xDataSource','a(:,2)','YDataSource','a*paramsRecta');

for i = 1:iterations
    % Guardamos los parametros en un arreglo para poder iterar en funciones posteriores
    allPR(i,:) = paramsRecta; 

    % Guardamos el costo de J en cada iteracion/ Guardamos antes de
    % iterarar para guardar los parametros con los que iniciamos
    J(i)= calcularCosto(paramsRecta);

    % Derivada de la funcion de costo
    derivadaJ = (x' * ((x * paramsRecta) - y))/N;  
    
    % Actualizamos pendiente y ordenada de la recta que mejor aproxima
    paramsRecta = paramsRecta-(learningRate * derivadaJ);
    refreshdata(gd_plot,'caller')
    drawnow
    pause(0.0001)
end

refreshdata(gd_plot, 'caller')
drawnow
pause(0.1)
fprintf(' \n Fin Iteracion\n')
end