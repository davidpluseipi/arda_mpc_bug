function B = par_stuff()
total_time = 10; % sec
p = parallel.pool.PollableDataQueue;
F = parfeval(@capture_data, 1, p, total_time);
t = tic;
k = 1;
pause(2)
while toc(t) < total_time
    try
        T(k) = poll(p)
        k = k + 1;
    catch er
        disp(er.message)
    end
    pause(1)
end
B = fetchOutputs(F);

end





