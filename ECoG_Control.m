%{
1. Get baseline

2. Loop
    i.   Get latest signal
    ii.  Process data (RMS?)
    iii. Send command to pi
 ~Should take no longer than 1.0 sec~
%}


clear all

%pi = raspi(ip,usr,pass);



read_baseline
baseline = rms(x1)
% 
% while true
%     read_new
%     new = rms(xn)         
%     
%     if ( (abs(baseline)) < (abs(new)) )
%         system(rpi, 'echo "1" > command.txt')
%     else
%         system(rpi, 'echo "0" > command.txt')
%     end
%     
% end