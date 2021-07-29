function a = queue_example2()

D = parallel.pool.DataQueue;
h = waitbar(0,'Please wait...');
afterEach(D, @update_waitbar)
N = 200;
p = 1;

parfor i = 1:N
    a(i) = max(abs(eig(rand(400))));
    send(D,i)
end

    function update_waitbar(~)
        waitbar(p/N, h)
        p = p + 1;
    end

end