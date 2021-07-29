%% Start clean
clear; clc; close all

%% Setup
bob = arda();
deadpool = gcp;
%% Main function
[bob] = main_fcn(bob, deadpool);
%% Results
% try
% disp('B')
% disp(B)
% 
% time2loop = cell(1, numel(t_enter_loop) - 1);
% for i = 1:length(t_enter_loop)-1
%     time2loop{i} = duration(t_enter_loop{i+1} - t_enter_loop{i},'Format','s');
% end
% disp('time2loop')
% disp(time2loop)
% 
% time2get_results = duration(t_got_results - t_enter_loop{1},'Format','s');
% disp('time2get_results')
% disp(time2get_results)
% 
% %% Plots
% for i = 1:length(t_enter_loop)
%    t(i) = t_enter_loop{i}; 
% end
% %%
% figure
% plot(t, ones(1, length(t_enter_loop)),...
%     'Marker', 'o',...
%     'MarkerFaceColor', '#0072BD',...
%     'LineStyle', 'none');
% ylim([0.9 1.2])
% set(gca,...
%     'GridColor',[0 0 1],...
%     'GridLineStyle','--',...
%     'XGrid','on',...
%     'Xtick', t,...
%     'XTickLabel',{'23','24','25','26','27','28','29','30','31','32','33'});
% hold on; grid on
% 
% plot(t_done, 1.1,...
%     'Marker', 'o',...
%     'MarkerFaceColor', '#D95319',...
%     'LineStyle', 'none');
% plot(t_got_results, 1.05,...
%     'Marker', 'o',...
%     'MarkerFaceColor', '#EDB120',...
%     'LineStyle', 'none');
% legend({'Loop re-entry', 'EMER_done','Got Results'},'Interpreter','none')
% catch
% end
