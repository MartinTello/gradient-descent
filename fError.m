function res = fError( b, m , cantDePuntos,X,y)
sumatoria = 0;

for indice = 1:cantDePuntos
  error_indice = m * X(indice) + b - y(indice); 
  sumatoria = sumatoria + error_indice.^2;
end
        
res = sumatoria;

end
