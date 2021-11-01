clear; close all; clc
serialportlist("available")
c = serialport("COM5",9600)
configureTerminator(c,"CR/LF")
for i = 1:5
line = readline(c)
flush(c)
pause(1)
end