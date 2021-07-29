clear; clc

pool = gcp;

harry = calculator();
harry.data = 0:20;
listener_handle = addlistener(harry, 'done', 'PostSet',...
    @(x) fetch_stuff(x));
listener_handle.Enabled = true;


t = {}; t2 = {};
i = 1;
t = [t {datetime('now')}];
while 1==1
    t2 = [t2 {datetime('now')}];
    if i == 1
        F = parfeval(pool, @harry.change_stuff, 1);
    end
    
    if numel(F.OutputArguments) > 0
        thing = F.OutputArguments{:};
        
        if thing.done == true
            status = "data passed through parfeval";
            t = [t {datetime('now')}];
            B = fetchOutputs(F);
            t = [t {datetime('now')}];
            break
        end
    end
    if i >= 4
        status = "timed out";
        t = [t {datetime('now')}];
        B = fetchOutputs(F);
        t = [t {datetime('now')}];
        break
    end
    pause(1)
    i = i + 1;
end
t = [t {datetime('now')}];
disp(status)
disp(harry)
disp(B)
T = table(t', t2')

function B = fetch_stuff(F)
B = fetchOutputs(F);
end