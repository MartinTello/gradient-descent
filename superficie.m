function [figSurf] = superficie(m_vals,b_vals,J,paramsRecta,allParamsRecta,J_recta)

global iterations

figSurf=figure;
    figure(figSurf);
    surf(b_vals, m_vals, J,'FaceAlpha',0.5);
    shading interp
    axis([-0.5 0.5 -0.5 0.9 -.5  5]);
    xlabel('b-(ordenada)'); ylabel('m-(pendiente)');
    hold on;
    
    for i = 1:iterations
        scatter3(allParamsRecta(i,1),allParamsRecta(i,2),J_recta(i),'rx')
    end
    scatter3(paramsRecta(1),paramsRecta(2),J_recta(end),'go')
end