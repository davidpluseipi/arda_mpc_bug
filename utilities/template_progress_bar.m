dialog_figure = uifigure('HandleVisibility', 'on');
% Handle visibility is on so that we can close it later with 
% close(figure_handle) or close all

dialog_box = uiprogressdlg(dialog_figure,...
    "Title", "This is at the top",...
    "Message", "This is in the middle",...
    "Cancelable", "on");
% This causes the window to appear
drawnow

t_start = tic;
t_final = 60;

% This is a timed loop
while toc(t_start) < t_final
    
    % Set the value of the progress bar
    dialog_box.Value = toc(t_start)/t_final;
    % Update the visible window
    drawnow
    % If the user presses cancel, exit the while loop
    if dialog_box.CancelRequested
        break
    end
end

delete(dialog_box)
close(dialog_figure)