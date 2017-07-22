clc
clear all
ncfile = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/xp150m_tjh/xp150m.ncml';
%Get time from it.

ncdisp(ncfile)
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


datestr(time16_17(1))
datestr(time16_17(end))
%save('Time', 'time');

waveHs = ncread(ncfile,'waveHs');
waveHs16_17 = waveHs(ii(1):jj(end));

%ncdisp(ncfile)
% plot(time16_17,waveHs16_17)
% datetick('x')
%read period data
waveTm = ncread(ncfile,'waveTm');
waveTm16_17 = waveTm(ii(1):jj(end));
% 
%NO wave direction data!!!!!
%get depth data
depth = ncread(ncfile,'depthP');
depth16_17 = depth(ii(1):jj(end));

%save data
dlmwrite('WaveH_T_Dir_1617_xp150.csv', [hours16_17, waveHs16_17, waveTm16_17,...
        depth16_17]);
%dlmwrite('WaveH_T_Dir_1617_xp150.csv', [hours16_17, waveHs16_17, waveTm16_17]);