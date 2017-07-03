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
    
    % Seteamos los labels de todos los ejes
    axes(handles.axes1);
    ylabel('data y'); xlabel('data x');
    axes(handles.axes2);
    xlabel('y insersect'); ylabel('slope');
    axes(handles.axes3);
    xlabel('iterations'); ylabel('error');
    axes(handles.axes4);
    xlabel('y intesect'); ylabel('slope');
    
    % Agregamos columna de 1s a x
    handles.x = [ones(handles.N, 1), handles.datax(:,1)];

    handles.output = hObject;
    guidata(hObject, handles);
    
    handles.reset_grad_desc.Enable = 'off';
% uiwait(handles.figure1);

% --- Executes on button press in start_grad_desc.
function start_grad_desc_Callback(hObject, eventdata, handles)
    
    b = str2double(get(handles.b_input, 'String'));
    m = str2double(get(handles.m_input, 'String'));
    handles.paramsRecta = [b; m];
    handles.learningRate = str2double(get(handles.learning_rate_input, 'String'));
    handles.iters = str2double(get(handles.iterations_input, 'String'));
    
    handles.reset_grad_desc.Enable = 'off';
    handles.start_grad_desc.Enable = 'off';
    
    % Ploteamos recta aproximada por gradiente descendente
    handles.toReset = plotter(handles.paramsRecta, handles);
    
    handles.reset_grad_desc.Enable = 'on';
    
    handles.output = hObject;
    guidata(hObject, handles);
    

% Checkbox de minimos cuadrados por metodo de Gauss.
function mincuad_chk_Callback(hObject, eventdata, handles)
    checked = get(hObject,'Value');
    if(checked == 1)
        set(handles.mincuad,'Visible','on')
    else
        set(handles.mincuad,'Visible','off')
    end
    
    handles.output = hObject;
    guidata(hObject, handles);

% --- Executes on button press in reset_grad_desc.
function reset_grad_desc_Callback(hObject, eventdata, handles)
    delete(handles.toReset);
    handles.paramsRecta = [handles.b_input.Value; handles.m_input.Value];
    
    handles.reset_grad_desc.Enable = 'off';
    handles.start_grad_desc.Enable = 'on';
    handles.output = hObject;
    guidata(hObject, handles);
    

function b_input_Callback(hObject, eventdata, handles)
    handles.output = hObject;
    guidata(hObject, handles);
    
function m_input_Callback(hObject, eventdata, handles) %#ok<*DEFNU>
    handles.output = hObject;
    guidata(hObject, handles);
    
% De aca para abajo no usamos nada
% --- Outputs from this function are returned to the command line.
function varargout = main_GUI_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;

function m_input_CreateFcn(hObject, eventdata, handles)
function b_input_CreateFcn(hObject, eventdata, handles)
function iterations_input_CreateFcn(hObject, eventdata, handles)
function learning_rate_input_CreateFcn(hObject, eventdata, handles)
function animation_speed_CreateFcn(hObject, eventdata, handles)
function axes2_CreateFcn(hObject, eventdata, handles)
function axes1_CreateFcn(hObject, eventdata, handles)



function learning_rate_input_Callback(hObject, eventdata, handles)
% hObject    handle to learning_rate_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of learning_rate_input as text
%        str2double(get(hObject,'String')) returns contents of learning_rate_input as a double



function iterations_input_Callback(hObject, eventdata, handles)
% hObject    handle to iterations_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iterations_input as text
%        str2double(get(hObject,'String')) returns contents of iterations_input as a double
