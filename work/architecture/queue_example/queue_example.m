clear; clc; close all
% 
% Q = parallel.pool.PollableDataQueue
% 
% 
% 
% % Get the worker to construct a data queue on which it can receive messages
% % from the client
% C = parallel.pool.Constant(@Q)
% 
% % Get the worker to send the queue object back to the client
% F1 = parfeval(p, @(x) x.Value,1,C)
% B1 = fetchOutputs(F1)
% 
% % Get the worker to start waiting for messages
% F2 = parfeval(@do_stuff, 1, C)
% 
% % Send message(s)
% send(B1, 1)
% 
% % Send stop
% send(B1, [])
% 
% % Get results
% B = fetchOutputs(F2)
% 
% function out = do_stuff(q_const)
% 
% q = q_const.Value
% out = 0;
% while true
%     thing = poll(q, 3)
%     if ~isnumeric(thing) & isempty(thing)
%         return
%     else
%         out = out + thing;
%     end
% end
% end