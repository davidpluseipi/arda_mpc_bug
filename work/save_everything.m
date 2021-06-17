function save_everything(varargin)

if nargin ~= 2
    error('The function save_everything.m requires 2 inputs.')
else
    if islogical(varargin{1}) && size(varargin{1},1) == 1 ...
            && size(varargin{1},2) == 1
        
        save_stuff = varargin{1};
    else
       error('First argument must be a logical datatype of size 1x1.')
    end
    
    if ischar(varargin{2})
        folder_name = varargin{2};
    else
        error('Second argument must be a char datatype.')
    end
end

if save_stuff
    try
        working_folder = pwd;
        dir_info = dir;
        make_folder = true;
        
        for i = 1:length(dir_info)
            if strcmpi(dir_info(i).name, folder_name)
                make_folder = false;
                break
            end
        end
        
        if make_folder
            mkdir(folder_name)
        end
        
        datetime_str = datestr(now,'yyyy-mm-dd_HHMMSS');
        
%         figure_filename = sprintf('step_response_%s.fig', ...
%             datetime_str);
%         savefig(fullfile(working_folder, 'arda_sim_results', ...
%             figure_filename));
%         close all
        
        variables_filename = sprintf([folder_name '_%s'], ...
            datetime_str);
        save(fullfile(working_folder, folder_name, ...
            variables_filename));
        
    catch
        warning('Unable to save simulation results.')
    end
end

end