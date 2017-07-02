function [suma] = calcularError(X,Y,c)
m=length(Y);
suma=zeros(m,1);
% suma de los errores al cuadrado
    for i=1 : m
    %Valor estimado
    e=X(i)*c(1);
    ee=e+c(2);
    %Error
    error= ee-Y(i);
    %Error al cuadrado
    errorSqr= error.^2;
    %Sumatoria
    suma(i)=sqrt(errorSqr);
    end
end