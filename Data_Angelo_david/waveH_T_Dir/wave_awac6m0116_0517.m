clc
clear all
ncfile = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/awac-6m/awac-6m.ncml';

ncdisp(ncfile)
%Get time from it.
tt = ncread(ncfile,'time');
time = tt/(24*3600) + datenum(1970,1,1);
%length(time)
%pick particular time 2016.1.1-2017.12.31
temptime1 = datenum(2016,1,1);
temptime2 = datenum(2017,05,31);
ii = find(floor(time) == temptime1);
jj = find(floor(time) == temptime2);

time16_17 = time(ii(1) : jj(end));
hours16_17 = (time16_17 - time16_17(1))*24;

dtt = string(datestr(time16_17));

datestr(time16_17(1))
datestr(time16_17(end))
%save('Time', 'time');

waveHs = ncread(ncfile,'waveHs');
waveHs16_17 = waveHs(ii(1):jj(end));

%ncdisp(ncfile)
% plot(time16_17,waveHs16_17)
% datetick('x')
%read period data
waveTp = ncread(ncfile,'waveTp');
waveTp16_17 = waveTp(ii(1):jj(end));

%read wave direction data
waveDir = ncread(ncfile,'waveMeanDirection');
waveDir16_17 = waveDir(ii(1):jj(end));

%read depth data
depth = ncread(ncfile, 'depth');
depth16_17 = depth(ii(1):jj(end));

%save data
% dlmwrite('WaveH_T_Dir_1617_awac6m.csv', [hours16_17, waveHs16_17, waveTp16_17,...
%         waveDir16_17, depth16_17]);
T = table(dtt, [waveHs16_17, waveTp16_17,...
       waveDir16_17, depth16_17])
writetable(T, 'WaveH_T_Dir_1617_awac6m.csv')    
    
