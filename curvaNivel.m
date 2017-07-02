function curvaNivel(m_vals,b_vals,J,paramsRecta,allPR)

global iterations;

figContour=figure;
contour(b_vals, m_vals, J,50)
axis([-0.5 0.5 -0.5 0.5]);
xlabel('b(ordenada)'); ylabel('m(pendiente)');
hold on;

for i=1:iterations
    figure(figContour);
    plot(allPR(i,1), allPR(i,2),'rx','MarkerSize',10,'LineWidth',2,'XDataSource','allPR(i)','YDataSource','allPR(i,2)');
    drawnow
end
plot(paramsRecta(1), paramsRecta(2), 'gx', 'MarkerSize', 10, 'LineWidth', 2);
end

