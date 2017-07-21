clc
clear all
ncfile = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/8m-array/8m-array.ncml';

%Get time from it.
tt = ncread(ncfile,'time');
time = tt/(24*3600) + datenum(1970,1,1);
length(time)
%pick particular time 20081.1-2008.12.31
temptime1 = datenum(2010,1,1);
temptime2 = datenum(2011,12,31);
ii = find(floor(time) == temptime1);
jj = find(floor(time) == temptime2);

time10_11 = time(ii(1) : jj(end));
hours10_11 = (time10_11 - time10_11(1))*24;


datestr(time10_11(1))
datestr(time10_11(end))
%save('Time', 'time');

waveHs = ncread(ncfile,'waveHs');
waveHs10_11 = waveHs(ii(1):jj(end));

%ncdisp(ncfile)
% plot(time10_11,waveHs10_11)
% datetick('x')
%read period data
waveTp = ncread(ncfile,'waveTp');
waveTp10_11 = waveTp(ii(1):jj(end));

%read wave direction data
waveDir = ncread(ncfile,'waveMeanDirection');
waveDir10_11 = waveDir(ii(1):jj(end));

%save data
dlmwrite('WaveH_T_Dir_10_11.csv', [hours10_11, waveHs10_11, waveTp10_11,...
        waveDir10_11]);

figure
subplot(3,1,1)
plot(time10_11,waveHs10_11)
datetick('x')
subplot(3,1,2)
plot(time10_11,waveTp10_11)
datetick('x')
subplot(3,1,3)
plot(time10_11,waveDir10_11)
datetick('x')