function B2 = pollable_queue_example()

% Create a pollable data queue
Q = parallel.pool.PollableDataQueue;

% Create a constant with Q in it's Value field
C = parallel.pool.Constant(Q);

% Task worker with sending Q obj back to client
F = parfeval(@(x) x.Value, 1, C);
B = fetchOutputs(F);

% We will use B to send messages to the worker

% Tell the worker what to do (wait for messages)
F2 = parfeval(@what2do, 1, C);
%output = what2do(C)

% Send message(s)
for i = 1:3
    send(B, 1)
end

% Tell worker to stop waiting for messages
send(B, [])

% Fetch the results
B2 = fetchOutputs(F2);


end

function output = what2do(C)
Q = C.Value;
output = 0;
while true
    timeout = 3;
    thing = poll(Q, timeout);
    if ~isnumeric(thing) && isempty(thing)
        return
    else
        output = output + thing;
    end
end
end