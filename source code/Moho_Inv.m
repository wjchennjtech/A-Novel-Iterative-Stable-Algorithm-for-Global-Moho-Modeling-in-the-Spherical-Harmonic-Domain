function varargout = Moho_Inv(varargin)
% MOHO_INV MATLAB code for Moho_Inv.fig
%      MOHO_INV, by itself, creates a new MOHO_INV or raises the existing
%      singleton*.
%
%      H = MOHO_INV returns the handle to a new MOHO_INV or the handle to
%      the existing singleton*.
%
%      MOHO_INV('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOHO_INV.M with the given input arguments.
%
%      MOHO_INV('Property','Value',...) creates a new MOHO_INV or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Moho_Inv_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Moho_Inv_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Moho_Inv

% Last Modified by GUIDE v2.5 08-Apr-2025 10:10:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Moho_Inv_OpeningFcn, ...
                   'gui_OutputFcn',  @Moho_Inv_OutputFcn, ...
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


% --- Executes just before Moho_Inv is made visible.
function Moho_Inv_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Moho_Inv (see VARARGIN)

% Choose default command line output for Moho_Inv
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Moho_Inv wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Moho_Inv_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
resultdata=get(handles.uitable1,'data');
[filename,pathname,c]=uiputfile('*.txt','save');
if c==1
file=[pathname,filename];
dlmwrite(file,resultdata);
helpdlg('Successfully saved!')
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uitable1,'data','');
set(handles.uitable3,'data','');

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
interval=1;
h = figure('visible','off');
new_axes = copyobj(handles.axes2,h);
set(new_axes,'Units','default','Position','default');
hScatter = findobj(new_axes, 'Type', 'Scatter');
    p=2*interval;
    set(hScatter, 'SizeData',p );
    cb=colorbar;
    set(get(cb,'title'),'string','km');
    colormap(jet)
    [filename, pathname] = uiputfile({'*.png';'*.bmp';'*.jpg'},'The picture is saved as');
if filename ~= 0
        file = strcat(pathname,filename);
        saveas(h,file);
        msgbox('The image has been successfully saved','Attention','help');
else
        msgbox('The operation has been canceled','Attention','warn');
end

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes2, 'reset');

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = figure('visible','off');
new_axes = copyobj(handles.axes2,h);
set(new_axes,'Units','default','Position','default');
[filename, pathname] = uiputfile({'*.png';'*.bmp';'*.jpg'},'The picture is saved as');
if filename ~= 0
   file = strcat(pathname,filename);
   saveas(h,file);
   msgbox('The image has been successfully saved','Attention','help');
else
   msgbox('The operation has been canceled','Attention','warn');
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1, 'reset');

% --- Executes when entered data in editable cell(s) in uitable4.
function uitable4_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable4 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile('*.txt','open file');
if filename==0
    return
else
    file=[pathname,filename];
    table_data=csvread(file);
    set(handles.uitable4,'data',table_data);
end 


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uitable4,'data','');

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
resultdata=get(handles.uitable5,'data');
[filename,pathname,c]=uiputfile('*.txt','save');
if c==1
file=[pathname,filename];
dlmwrite(file,resultdata);
helpdlg('Successfully saved!')
end

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uitable5,'data','');
set(handles.uitable6,'data','');

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
interval=1;
h = figure('visible','off');
new_axes = copyobj(handles.axes3,h);
set(new_axes,'Units','default','Position','default');
hScatter = findobj(new_axes, 'Type', 'Scatter');
    p=2*interval;
    set(hScatter, 'SizeData',p );
    cb=colorbar;
    set(get(cb,'title'),'string','mGal');
    colormap(jet)
    [filename, pathname] = uiputfile({'*.png';'*.bmp';'*.jpg'},'The picture is saved as');
if filename ~= 0
        file = strcat(pathname,filename);
        saveas(h,file);
        msgbox('The image has been successfully saved','Attention','help');
else
        msgbox('The operation has been canceled','Attention','warn');
end

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes3, 'reset');

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
grav_attraction=get(handles.uitable4,'data');
height=str2double(get(handles.edit2,'string'));
tol=str2double(get(handles.edit3,'string'));
max_iter=str2double(get(handles.edit4,'string'));
deltarho=str2double(get(handles.edit5,'string'));
D0=str2double(get(handles.edit6,'string'));

if handles.checkbox1.Value == 1
    alpha=str2double(get(handles.edit7,'string'));
else
    alpha=1;
end

lon_min=-179.5;lon_max=179.5;lat_min=-89.5;lat_max=89.5;nlat=180;nlon=360;
Lon=linspace(lon_min,lon_max,nlon);Lat=linspace(lat_max,lat_min,nlat);
cumulative_hx=zeros(nlat*nlon,3);
cumulative_hx(:,1:2)=grav_attraction(:,1:2);
g_rms_values = zeros(max_iter, 1);
accumulated_hx = zeros(size(grav_attraction, 1), max_iter + 2);
accumulated_hx(:,1:2)=grav_attraction(:,1:2);

hWait = waitbar(0, 'Processing, please wait...'); 

for  iter = 1:max_iter

    fprintf("Iteration %d\n", iter);
    
    progress = (iter / max_iter) * 100; 
    
    depth=inv_iter(grav_attraction,height,tol,max_iter,alpha,D0,deltarho);

    waitbar(iter / max_iter, hWait, sprintf('%.1f%% - Iteration %d of %d', progress, iter, max_iter));

    depth(:,3)=depth(:,3)/1e3;
    prev_g = grav_attraction;

    cumulative_hx(:,3)=cumulative_hx(:,3)+depth(:,3)-(iter > 1) * D0/1e3 ;

    accumulated_hx(:,iter+2) = cumulative_hx(:,3);
    
    upd_g= moho_forward(depth,height,deltarho,D0);

    grav_attraction(:,1:2)=grav_attraction(:,1:2);
    grav_attraction(:,3)=prev_g(:,3)-upd_g(:,3);
    gRMS=rms(grav_attraction(:,3));
    g_rms_values(iter) = gRMS;
   fprintf("Change in gravity anomaly RMS = %.6f\n", gRMS);

end
close(hWait);

fmin=min(accumulated_hx(:,max_iter+2));
fmax=max(accumulated_hx(:,max_iter+2));
fmean=mean(accumulated_hx(:,max_iter+2));
fstd=std(accumulated_hx(:,max_iter+2));
stastic=[fmin,fmax,fmean,fstd];
set(handles.uitable3,'data',stastic);

fresult(:,1:2)=accumulated_hx(:,1:2);
fresult(:,3)=accumulated_hx(:,max_iter+2);
set(handles.uitable1,'data',fresult);

set(handles.edit8,'string',fmean*1e3);

axes(handles.axes1);
plot(1:max_iter, g_rms_values, '-o');
xlabel('Iteration', 'FontName', 'Times New Roman');
ylabel('RMS Error', 'FontName', 'Times New Roman');
title('Gravity Anomaly RMS Curve', 'FontName', 'Times New Roman');
grid on;


axes(handles.axes2);
scatter(accumulated_hx(:,1),accumulated_hx(:,2),1,accumulated_hx(:,max_iter+2))
cb=colorbar;colormap(jet); 
set(get(cb, 'Title'), 'String', 'km', 'FontName', 'Times New Roman');
title('Depth Image of Iteration ', 'FontName', 'Times New Roman');

xlim([lon_min lon_max]);
ylim([lat_min lat_max]);

xlabel('Longitude (degree)', 'FontName', 'Times New Roman');
ylabel('Latitude (degree)', 'FontName', 'Times New Roman');








function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=get(handles.uitable4,'data');

if isempty(data)
   helpdlg('未加载数据，请先点击读取文件按钮', '警告');
    return; 
end
latmax=max(data(:,2));
latmin=min(data(:,2));
lonmax=max(data(:,1));
lonmin=min(data(:,1));   
datainterval=data(2,1)-data(1,1);
nlat = (latmax - latmin) / datainterval + 1;
nlon = (lonmax - lonmin) / datainterval + 1;
data1=reshape(data(:,3),nlon,nlat);
datap=data1';
datap=flipud(datap);
figure();  
imagesc([lonmin lonmax],[latmin latmax],datap);
set(gca, 'YDir', 'normal');
colormap(jet)
colorbar;
xlim([lonmin lonmax]);
ylim([latmin latmax]); 
xlabel('Longitude (degree)', 'FontName', 'Times New Roman');
ylabel('Latitude (degree)', 'FontName', 'Times New Roman');



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
lon_min=-179.5;lon_max=179.5;lat_min=-89.5;lat_max=89.5;nlat=180;nlon=360;
fresult=get(handles.uitable1,'data');
D0=str2double(get(handles.edit8,'string'));
deltarho=str2double(get(handles.edit12,'string'));
height=str2double(get(handles.edit11,'string'));


[new_attraction] = moho_forward(fresult,height,deltarho,D0);

axes(handles.axes3);
scatter(new_attraction(:,1),new_attraction(:,2),1,new_attraction(:,3))
cb=colorbar;colormap(jet); 
set(get(cb, 'Title'), 'String', 'mGal', 'FontName', 'Times New Roman');
title('Inverted gravity anomaly ', 'FontName', 'Times New Roman');

xlim([lon_min lon_max]);
ylim([lat_min lat_max]);

xlabel('Longitude (degree)', 'FontName', 'Times New Roman');
ylabel('Latitude (degree)', 'FontName', 'Times New Roman');

set(handles.uitable5,'data',new_attraction);

attraction_min=min(new_attraction(:,3));
attraction_max=max(new_attraction(:,3));
attraction_mean=mean(new_attraction(:,3));
attraction_std=std(new_attraction(:,3));
attraction_stastic=[attraction_min,attraction_max,attraction_mean,attraction_std];
set(handles.uitable6,'data',attraction_stastic);


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile('*.txt','open file');
if filename==0
    return
else
    file=[pathname,filename];
    table_data=csvread(file);
    set(handles.uitable1,'data',table_data);
end 

depth_min=min(table_data(:,3));
depth_max=max(table_data(:,3));
depth_mean=mean(table_data(:,3));
depth_std=std(table_data(:,3));
depth_stastic=[depth_min,depth_max,depth_mean,depth_std];
set(handles.uitable3,'data',depth_stastic);
set(handles.edit8,'string',depth_mean*1e3);


function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
