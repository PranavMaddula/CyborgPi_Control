clear
clc
read_path = 'C:\Users\Pranav Maddula\Documents\RamanLab\raw_data\';
write_path = 'C:\Users\Pranav Maddula\Documents\RamanLab\mat_data\';
if ~(exist(write_path,'dir')==7)
    mkdir(write_path)
end
f_list = ls(read_path)
%read_Intan_RHD2000_file(read_path, f_list(3,:))
% find correct channels or denote channels manually
%ch_idx = find([amplifier_channels.electrode_impedance_magnitude]>2e+04 & [amplifier_channels.electrode_impedance_magnitude]<2e+06);
 ch_idx = [1];

%%
fc = 300;

[b,a] = butter(6,fc/(15000/2),'high'); % High pass filter coefficients for spike sorting
% rawData = zeros(length(f_list)-2,18*fs);
t1 = 1;
o1 = 0;
oldOdor = 'old';
data = zeros(15000*20,length(ch_idx),1);
% full_data2 = zeros(15000*30,length(ch_idx),10,6);
for f1 = 1:size(f_list,1)-2
    
    fname = f_list(f1+2,:);
    underscoreInd = strfind(fname,'_');
    odor = fname(1:underscoreInd(end-1)-1);
    if strcmp(odor,oldOdor)
        t1 = t1+1;
    else
        
        t1 = 1;
        o1 = o1+1;
        oldOdor = odor;
        disp(oldOdor)
    end
    read_Intan_RHD2000_file(read_path, fname)
    fs = round(frequency_parameters.amplifier_sample_rate);
    idx = find(t_amplifier>0, 1 ); % Time just after trigger
    temp = amplifier_data(ch_idx,idx:idx+20*fs-1);
    temp = temp';
    if fs ~= 15000
        temp = resample(temp,15000,fs);
    end
%     temp = int16(filtfilt(b,a,temp)); % High pass filtering for spikes
    temp = filtfilt(b,a,temp); % High pass filtering for spikes
    data(:,:,t1) = temp;
    if t1==1
        save([write_path oldOdor '.mat'],'data')
        figure
        plot(1/15000:1/15000:20,data(:,:,1))
        title(oldOdor)
        drawnow
%         full_data2(:,:,:,o1) = data;
    end
%     for ch = 1:length(ch_idx)
%         fid=fopen([write_path odor 't' num2str(t1,'%02.2d') '.' num2str(ch,'%02.2d')],'w','ieee-be');
%         fwrite(fid,squeeze(temp(:,ch)),'int16');
%         fclose(fid);
%     end
end
clear temp