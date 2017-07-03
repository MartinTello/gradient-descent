function toReset = plotter(paramsRecta, handles)
% paramsRecta = valor estimado || guess || theta
% J es la funcion que quiero minimizar. Es la funcion de costo.
% allPR son todos los parametros de las rectoas que va encontrando la iteracion

%   Esta funcion actualiza los parametros de la recta realizando iter pasos con
%   alpha como learning rate

toReset = [];

%% surfContour init
% Grilla sobre la cual se va a calcular la funcion
b_vals = linspace(-0.5, 0.5, 100);
m_vals = linspace(-0.5, 0.85, 100);

% inicializamos J en una matriz de 0's
%   J es la funcion del error
J_mesh = zeros(length(m_vals), length(b_vals));

% llenamos J con los errores correspondientes a cada punto en la grilla
for i = 1:length(m_vals)
    for j = 1:length(b_vals)
	  t = [b_vals(i); m_vals(j)];    
	  J_mesh(j, i) = calcularCosto(t, handles);
    end
end

%% Variables
% Handles
x = handles.x;
y = handles.y;
learningRate = handles.learningRate;
iterations = handles.iters;
N = handles.N;

% Variables locales
allPR = zeros(N,2);
J = zeros(iterations,1);

a=linspace(-10,50,60);
m=length(a);
a = [ones(m, 1), a'];

%% ploteoj.m
vector_x = [];
vector_y = [];
plotJ = [];
%% superficie.m
axes(handles.axes2);
toReset = [toReset, surf(handles.axes2, b_vals, m_vals, J_mesh,'FaceAlpha',0.5)];
shading interp
axis([-0.5 0.5 -0.5 0.9 -.5  5]);
hold on;
%% gradienteD.m
axes(handles.axes1);
gd_plot = plot(handles.axes1, a(:,2), a * paramsRecta,'xDataSource','a(:,2)','YDataSource','a*paramsRecta');
toReset = [toReset, gd_plot];

%% curvaNivel.m
axes(handles.axes4);
[C, h] = contour(b_vals, m_vals, J_mesh, 50);
toReset = [toReset, h];
axis([-0.5 0.5 -0.5 0.5]);
hold on;
    %% Bucle Principal
    for i = 1:iterations
        %% COMIENZO Ploteo recta gradiente descendiente
        axes(handles.axes1);
        % Guardamos los parametros en un arreglo para poder iterar en funciones posteriores
        allPR(i,:) = paramsRecta; 

        % Guardamos el costo de J en cada iteracion/ Guardamos antes de
        % iterarar para guardar los parametros con los que iniciamos
        J(i)= calcularCosto(paramsRecta, handles);

        % Derivada de la funcion de costo
        derivadaJ = (x' * ((x * paramsRecta) - y))/N;  

        % FIN Ploteo recta gradiente descendiente
        %% COMIENZO Ploteo de error por iteraciones
        vector_x = [vector_x i];
        vector_y =[vector_y J(i)];
        axes(handles.axes3);
        hold on;
        toReset = [toReset, plot(handles.axes3, vector_x,vector_y,'r-'), scatter(i, J(i), 100, 'b.')];
        drawnow
        % FIN Ploteo de error por iteraciones
        %% COMIENZO Ploteo Superficie de Error
        axes(handles.axes2);
        hold on; 
        toReset = [toReset, scatter3(handles.axes2, paramsRecta(1, 1), paramsRecta(2, 1), J(i),'rx', 'LineWidth', 2)];
        % FIN Ploteo Superficie de Error
        %% COMIENZO Ploteo en Curvas de Nivel
        axes(handles.axes4);
        toReset = [toReset, plot(paramsRecta(1, 1), paramsRecta(2, 1),'rx','MarkerSize',10,'LineWidth',2,'XDataSource','allPR(i)','YDataSource','allPR(i,2)')];
        drawnow
        % FIN Ploteo Superficie de Error
        %% End
        % Actualizamos pendiente scattery ordenada de la recta que mejor aproxima
        paramsRecta = paramsRecta-(learningRate * derivadaJ);
        refreshdata(gd_plot,'caller')
        drawnow
    end
end