function [wavehsid, wavetpid, depthid, datatime] = Read_xp(file, date)
%Input: file on FRF, datatime is date [datenum()]
%output: wavehight, wave Time period, depth, datestring


%% save data file
%Get time from it.
tt = ncread(file,'time');
time = tt/(24*3600) + datenum(1970,1,1);
tm = date;
id =find(floor(time) == tm);
datatime = string(datestr(time(id)));

%ncdisp(file)
%get wave height
waveHs = ncread(file, 'waveHs');
%get wave Time period
waveT = ncread(file, 'waveTpPeak');
%get wave depth
depth = ncread(file, 'depthP');

wavehsid = waveHs(id);
wavetpid = waveT(id);
depthid = depth(id);
end