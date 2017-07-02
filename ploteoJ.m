function ploteoJ(J)

global iterations
figJ=figure();
figure(figJ);
hold on;
vector_x=[];
vector_y=[];

    for i = 1 : iterations
        vector_x=[vector_x i];
        vector_y=[vector_y J(i)];
        scatter(i,J(i),100,'.');     
        plot(vector_x,vector_y,'-');
        drawnow

    end
end