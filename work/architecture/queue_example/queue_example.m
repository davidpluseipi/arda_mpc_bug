function queue_example()

for i = 1:5
    f(i) = parfeval(@capture_data, 1);
    B = afterEach(f, @disp, 0)
end

end

function output = capture_data(~)
TT = timetable(NaT(10,1), zeros(10,1), 'VariableNames', {'T_g'});
for i = 1:10
    TT.T_g(i) = 25;
    TT.Time(i) = datetime('now');
    pause(0.1)
end
output = TT;
end