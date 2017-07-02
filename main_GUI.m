function varargout = main_GUI(varargin)
    % MAIN_GUI MATLAB code for main_GUI.fig
    %   Comentarios aquí
    % See also: GUIDE, GUIDATA, GUIHANDLES

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @main_GUI_OpeningFcn, ...
                       'gui_OutputFcn',  @main_GUI_OutputFcn, ...
                       'gui_LayoutFcn',  [] , ...
                       'gui_Callback',   []);
    if nargin && ischar(varargin{1})
        gui_State.gui_Callback = str2func(varargin{1});
    end

    if nargout
        [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
    else
        gui_mainfcn(gui_State, varargin{:});
    end
    % End initialization code - DO NOT EDIT


% Función inicializadora . 
function main_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
    clc;
    
    handles.path = 'data';
    handles.dataFile1 = '';
    handles.dataFile2 = '';
    
    % Cargamos los datos desde archivos
    handles.datax = load('data/body.txt');
    handles.datay = load('data/brain.txt');
    
    % Ploteamos los datos
    handles.x = handles.datax(:, 1);
    handles.y = handles.datay(:, 1);
    handles.N = length(handles.y);
    
    axes(handles.axes1);
    plot(handles.axes1, handles.x, handles.y, 'rx', 'MarkerSize', 10);
    axis([0 10 0 2]);
    hold('on');
    
    % Graficamos aproximacion por metodo de Gauss
    fitted = polyfit(handles.x, handles.y, 1);
    x1 = (0:0.1:10);
    y1 = polyval(fitted, x1);
    handles.mincuad = plot(handles.axes1, x1, y1);
    
    % Labels de ejes
    ylabel('body weights');
    xlabel('brain weights');
    
    % Parámetros para aprendizaje de gradiente descendente
    handles.iterations = 1500;
    handles.learning_rate = 0.01;

    % inicializar parametros de fit (valor estimado)
    handles.recta_params = zeros(2, 1);
    
    
    % TESTING
    axes(handles.axes2);
    [X,Y] = meshgrid(-5:.5:5);
    Z = Y.*sin(X) - X.*cos(Y);
    s = surf(handles.axes2, X,Y,Z,'FaceAlpha',0.5)
    set(rotate3d,'Enable','on');
    handles.output = hObject;
    guidata(hObject, handles);

% uiwait(handles.figure1);

% --- Executes on button press in start_grad_desc.
function start_grad_desc_Callback(hObject, eventdata, handles)
    handles.x = [ones(handles.N, 1), handles.datax(:,1)];
    calcularCosto(handles.x, handles.y, handles.recta_params)
    

% Checkbox de minimos cuadrados por metodo de Gauss.
function mincuad_chk_Callback(hObject, eventdata, handles)
    checked = get(hObject,'Value');
    if(checked == 1)
        set(handles.mincuad,'Visible','on')
    else
        set(handles.mincuad,'Visible','off')
    end

% --- Outputs from this function are returned to the command line.
function varargout = main_GUI_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;


% --- Executes on button press in select_data.
function select_data_Callback(hObject, eventdata, handles)
    prompt = {'Training data file 1:', 'Training data file 2:'};
    dlg_title = 'Select training data';
    num_lines = 1;
    defaultans = {'path/to/data', 'data1.txt','data2.txt'};
    answer = inputdlg(prompt, dlg_title, num_lines, defaultans);


% --- Executes on button press in plot_data.
function plot_data_Callback(hObject, eventdata, handles)
% hObject    handle to plot_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function data_Callback(hObject, eventdata, handles)
% hObject    handle to data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function select_training_data_Callback(hObject, eventdata, handles)
% hObject    handle to select_training_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function animation_speed_Callback(hObject, eventdata, handles)
% hObject    handle to animation_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of animation_speed as text
%        str2double(get(hObject,'String')) returns contents of animation_speed as a double


% --- Executes during object creation, after setting all properties.
function animation_speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to animation_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function iterations_Callback(hObject, eventdata, handles)
% hObject    handle to iterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iterations as text
%        str2double(get(hObject,'String')) returns contents of iterations as a double


% --- Executes during object creation, after setting all properties.
function iterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reset_grad_desc.
function reset_grad_desc_Callback(hObject, eventdata, handles)
% hObject    handle to reset_grad_desc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
