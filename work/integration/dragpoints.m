function dragpoints(app,xData,yData,xLower,xUpper,yLower,yUpper)
figure;
x = xData;
y = yData;

ax = axes('xlimmode','manual','ylimmode','manual');
ax.XLim = [xLower xUpper];
ax.YLim = [yLower yUpper];

%can change the marker size or marker type to make it more visible.
%Currently is set to small points at a size of 2 so is not very visible.
line(x,y,...
    'marker','o',...
    'markersize',5,...
    'LineWidth',2,...
    'hittest','on',...
    'buttondownfcn',@clickmarker)



function clickmarker(src,~)
set(ancestor(src,'figure'),'windowbuttonmotionfcn',{@dragmarker,src})
set(ancestor(src,'figure'),'windowbuttonupfcn',@stopdragging)
end


function dragmarker(~,~,src)

%get current axes and coords
h1=gca;
coords=get(h1,'currentpoint');

%get all x and y data 
x=h1.Children.XData;
y=h1.Children.YData;

%check which data point has the smallest distance to the dragged point
x_diff=abs(x-coords(1,1,1));
y_diff=abs(y-coords(1,2,1));
[~, index]=min(x_diff+y_diff);

%create new x and y data and exchange coords for the dragged point
x_new=x;
y_new=y;
x_new(index)=coords(1,1,1);
y_new(index)=coords(1,2,1);

assignin('base','x',x_new);
assignin('base','y',y_new);

app.x1EditField.Value = x_new(1);
app.x2EditField.Value = x_new(2);
app.x3EditField.Value = x_new(3);
app.x4EditField.Value = x_new(4);
app.x5EditField.Value = x_new(5);
app.x6EditField.Value = x_new(6);
app.x7EditField.Value = x_new(7);
app.x8EditField.Value = x_new(8);
app.x9EditField.Value = x_new(8);
app.x10EditField.Value = x_new(10);

app.y1EditField.Value = y_new(1);
app.y2EditField.Value = y_new(2);
app.y3EditField.Value = y_new(3);
app.y4EditField.Value = y_new(4);
app.y5EditField.Value = y_new(5);
app.y6EditField.Value = y_new(6);
app.y7EditField.Value = y_new(7);
app.y8EditField.Value = y_new(8);
app.y9EditField.Value = y_new(8);
app.y10EditField.Value = y_new(10);

%update plot
set(src,'xdata',x_new,'ydata',y_new);
end

function stopdragging(fig,ev)
set(fig,'windowbuttonmotionfcn','')
set(fig,'windowbuttonupfcn','')
end

end