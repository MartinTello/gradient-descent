function [allPR paramsRecta J] = gradienteD(paramsRecta)
% paramsRecta = valor estimado || guess || theta
% J es la funcion que quiero minimizar. Es la funcion de costo.
% allPR son todos los parametros de las rectoas que va encontrando la iteracion

%   Esta funcion actualiza los parametros de la recta realizando iter pasos con
%   alpha como learning rate

% Inicializamos variables
global x;
global y;
global learningRate;
global iterations;

N=length(y);
allPR=zeros(N,2);
J=zeros(iterations,1);
fprintf('\n Iterando')
hold on;

a=linspace(-10,50,60);
m=length(a);
a = [ones(m, 1), a'];
%R = plot(x(:,2), x * paramsRecta,'xDataSource','x(:,2)','YDataSource','x*paramsRecta');
R = plot(a(:,2), a * paramsRecta,'xDataSource','a(:,2)','YDataSource','a*paramsRecta');

for i = 1:iterations
    %%Guardamos los parametros en un arreglo para poder iterar en funciones
    %posteriores
    allPR(i,:)=paramsRecta; 
    
     % Guardamos el costo de J en cada iteracion/ Guardamos antes de
     % iterarar para guardar los parametros con los que iniciamos
    
     J(i)= calcularCosto(paramsRecta);
    %%
     %% Derivada de la funcion de costo
    % 
    derivadaJ = (x' * ((x * paramsRecta) - y))/N;  
    %%
    
    % Actualizamos pendiente y ordenada de la recta que mejor aproxima
    paramsRecta=paramsRecta-(learningRate * derivadaJ);
    %%
    refreshdata(R,'caller')
    drawnow
    pause(0.0001)
end

  refreshdata(R,'caller')
    drawnow
    pause(0.1)
fprintf(' \n Fin Iteracion\n')
end