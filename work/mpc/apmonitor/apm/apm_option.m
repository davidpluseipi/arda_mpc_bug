function response = apm_option(server, app, name, value)
% APM Options
   aline = ['option ' deblank(char(name)) ' = ' num2str(value)];
   response = apm(server, app, aline);
end

