
% [x y] = ginput(2)

x = 1:10;
y = x;
dragpoints(x,y,min(x)-1,max(x)+1,min(y)-1,max(y)+1)