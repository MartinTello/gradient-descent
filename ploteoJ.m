function plotJ = ploteoJ(J, handles)


iterations = handles.iters;

vector_x = [];
vector_y = [];
plotJ = [];
    for i = 1 : iterations
        vector_x = [vector_x i];
        vector_y =[vector_y J(i)];
        axes(handles.axes3);
        hold on;
        plotJ = [plotJ, plot(handles.axes3, vector_x,vector_y,'r-'), scatter(i, J(i), 100, 'b.')];
        drawnow
    end
end