%programa principal ||  main


%inicializacion 
clear;  clc;   close all;
global iterations;
global learningRate;
global x;
global y;

fprintf(' Presione enter para comenzar')
%pause;
fprintf(' Ploteando datos...\n');

%cargando datos de archivo
datax = load('body.txt');
datay = load('brain.txt');
x = datax(:, 1);
y = datay(:, 1);
N = length(y);

figRecta = figure(); % abre una ventana 
figure(figRecta);
plot(x, y, 'rx', 'MarkerSize', 10); % ploteo

xlim([min(x)-.5 max(x)+.5])
ylim([min(y)-.5 max(y)+.5])
ylabel('body weights (g)');
xlabel('brain weights (g)');

fprintf('\n Ejecutando gradiente descendente');

x = [ones(N, 1), datax(:,1)]; % agregamos una columna de unos a los datos
% Modificando estos parametros podemos elegir el lugar de la superficie del
% error para comenzar a buscar la mejor solucion
paramsRecta = [-0.3; -0.5]; % inicializar parametros de fit (valor estimado)

% variables necesarias para el gradiente descendente
 iterations = 100;
 learningRate = 0.01;

% ejecutar gradiente descendiente
[allParamsRecta, paramsRecta, J] = gradienteD(paramsRecta);

%ploteo del error
ploteoJ(J);

% mostramos los valores de ve, pendiente y ordenada al origen respectivamente  
fprintf(' Valores de la recta encontrados mediante gradiente descendente: ');
fprintf('%f %f \n', paramsRecta(1), paramsRecta(2));

%Graficando la funcion error
fprintf('Presione enter para mostrar superficie del error')
pause;
surfContour(paramsRecta,allParamsRecta,J);



fprintf('\n FIN de Ejecución')

