clear; close all; clc

f_s = 10;
t = 3; % seconds per read
n_loops = 2;
output = zeros(f_s*t, n_loops);
m = zeros(1,n_loops);

if ~exist('thermocouple_fit_obj','var')
    try
        load('thermocouple_volts2celsius.mat','thermocouple_fit_obj')
    catch
        [thermocouple_fit_obj, ~] = create_fit_obj_volts2celsius();
    end
    o = thermocouple_fit_obj;
end

%% Parallel Stuff
% Start a parallel pool if not started
if isempty(gcp)
    p = parpool;
else
    p = gcp; % get current pool
end

% Start a timer
tic
% Run a function on workers in the pool
obj = [];
for idx = 1:n_loops
    f(idx) = parfeval(p,@get_some_data,1,obj,t,o,f_s,idx,n_loops); %pool, fun, n_out, in1, in2...
    if idx ~= n_loops
        pause(1);
    end
end

% Capture the results when they are ready
data = cell(1,n_loops);
y_filtered = zeros(t*f_s,n_loops);
for i = 1:n_loops
    [completed_index, output] = fetchNext(f);
    data{completed_index} = output;
end
for i = 1:n_loops
    y = data{i}.Board1_Ai4 * 1000; % convert to mV
    y_C = thermocouple_fit_obj(y) + 27; % correct for an offset
    y_filtered(:,i) = filter_stuff(y_C, f_s); % apply filter
end
%% Stop stuff
toc
%%
try
    stop(obj)
catch exception2
    exception2
end
%%
delete(p)
%% Non-parallel stuff
% for i = 1:n_loops
%     T(:,i) = get_some_data(t,o,f_s,1);
% end

plot(y_filtered); grid on
%%
% Specify the function to be run in parallel
function out = record_stuff(in)

t = in;
times = NaT(t,1);
T = zeros(t,1);
for i = 1:t
    times(i) = datetime('now');
    T(i) = randi([18 22]);
    pause(1)
end
out = timetable(times, T);

end

%%
function y_out = filter_stuff(y_in, sample_frequency)
% Setup for filter()
windowSize = 20*sample_frequency;
b = (1/windowSize)*ones(1,windowSize);
a = 1;

% Filter with base matlab filter
y2 = filter(b, a, y_in);

% Flip to prep for the 2nd filtering
y_out = zeros(size(y_in));
for i = 1:size(y2)
    y_out(i) = y2(end-i+1);
end

% Filter the flipped data to remove lateral offset
y_new = filter(b,a,y_out);

% Flip the data again so it's initial orientation
for i = 1:size(y_new)
    y_out(i) = y_new(end-i+1);
end

end