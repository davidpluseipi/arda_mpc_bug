clear; clc; close all

L = 40;
row_times = NaT(L,1);
v1 = zeros(L,1);
v2 = zeros(L,1);

for i = 1:L
    tic
    t = datetime("now");
    row_times(i) = t;
    
    v1(i) = i;
    v2(i) = i^2 - 1;
    
    if ~exist('TT','var')
        TT = timetable(row_times, v1, v2);
    else
        TT.row_times(i) = t;
        TT.v1(i) = v1(i);
        TT.v2(i) = v2(i);
    end
    
    %if rem(i,10) == 0
        
        save('TT.mat','TT')
        
    %end
    toc
    if i == 21
        keyboard
    end
end