function [figSurf] = superficie(m_vals, b_vals, J, paramsRecta, allParamsRecta, J_recta, handles)

    iterations = handles.iters;
    axes(handles.axes2);
    surf(handles.axes2, b_vals, m_vals, J,'FaceAlpha',0.5);
    shading interp
    axis([-0.5 0.5 -0.5 0.9 -.5  5]);
    xlabel('b-(ordenada)'); ylabel('m-(pendiente)');
    hold on;

    for i = 1:iterations
        scatter3(handles.axes2, allParamsRecta(i,1),allParamsRecta(i,2),J_recta(i),'rx')
        pause(0.1);
    end
    scatter3(handles.axes2, paramsRecta(1), paramsRecta(2), J_recta(end), 'go')
end