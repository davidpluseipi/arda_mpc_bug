%% Start clean
clear; clc

%% Setup
harry = arda2();
harry.data = 0:20;
pool = gcp;
i = 1;
N = 10;
t_enter_loop = cell(N,1); 
skip_me = false;

%% Main loop
while 1==1
    
    disp(i)
    t_enter_loop{i} = datetime('now');
    
    if i == 1 
        F = parfeval(pool, @harry.check_stuff, 1);
    end
    
    if numel(F.OutputArguments) > 0 && skip_me == false
        
        t_got_results = datetime('now');
        B = fetchOutputs(F);
        
        if B.done && B.result >= 20
            notify(harry,'emergency')
        end
        
        disp("Used the pool")
        skip_me = true;
        
    elseif i >= 10
        
        disp("timed out")
        t_timed_out = datetime('now');
        B = fetchOutputs(F);
        break
        
    end
    
    pause(1)
    i = i + 1;
end
t_exit = datetime('now');

%% Results
disp(B)

time2loop = cell(numel(t_enter_loop) - 1,1);
for i = 1:length(t_enter_loop)-1
    time2loop{i} = duration(t_enter_loop{i+1} - t_enter_loop{i},'Format','s');
end
disp('time2loop')
disp(time2loop)

time2get_results = duration(t_got_results - t_enter_loop{1},'Format','s');
disp('time2get_results')
disp(time2get_results)