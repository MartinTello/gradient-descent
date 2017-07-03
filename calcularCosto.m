function J = calcularCosto(paramsRecta, handles)
    y = handles.y;
    x = handles.x;
    N = handles.N;

    errors = sum(((x * paramsRecta) - y).^2);
    J = (( 1 / (2 * N)) * errors);
end