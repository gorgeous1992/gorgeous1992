function [waveHs, waveF, depth, datatime] = Readwavedata(file)
%Input: file on FRF
%output: wavehight, wave frequency, depth, datestring


%% save data file
%Get time from it.
tt = ncread(file,'time');
time = tt/(24*3600) + datenum(1970,1,1);
datatime = datestr(time);

%ncdisp(file)
%get wave height
waveHs = ncread(file, 'waveHs');
%get wave frequency
waveF = ncread(file, 'waveFrequency');
%get wave depth
depth = ncread(file, 'depth');

end