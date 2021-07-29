function pollable_queue_example2()

p = parallel.pool.PollableDataQueue;

parfor i = 1
    send(p, i); 
end

poll(p)

end