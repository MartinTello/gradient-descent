function [c] = MinimoCuadrado(X,Y,K)

%%codigo para numeros al azar
%no respeta la definicion de funcion
%esta porcion de codigo no necesita las variables locales X e Y
%y solo retorna c
%r=randi(40);
%r1=randi(10);
%r2=randi([10 50]);
%X = randi([10 50],1,r);
%Y = randi([r1 r2],1,r);
%%
Minx=min(X);
Maxx=max(X);

Miny=min(Y);
Maxy=max(Y);

c=polyfit(X,Y,K);
plot(X,Y,'r*');
xlim([Minx-2 Maxx+2]);
ylim([Miny-2 Maxy+2]);
xp=linspace(0,60,20);
yp=polyval(c,xp);
hold on
plot(xp,yp);

%function end
