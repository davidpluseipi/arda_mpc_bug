function progress_dialog(arda)

if arda.progress_bar
    
    arda.fig = uifigure('HandleVisibility', 'on');
    arda.dialog_box = uiprogressdlg(arda.fig,...
        "Title", "Thank you for your patience",...
        "Message", "Starting...", ...
        "Cancelable", "on");
    drawnow
    
end

end