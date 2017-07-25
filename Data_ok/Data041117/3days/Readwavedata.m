clc
clear all

%var = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/cbathy/Bathyduck-ocean_bathy_argus_201604.nc';
Bd_data = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/8m-array/2017/FRF-ocean_waves_8m-array_201701.nc';
%ncdisp(Bd_data)
%Inside date
awac_6 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/awac-6m/2017/FRF-ocean_waves_awac-6m_201701.nc';
awac_45 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/awac-4.5m/2017/FRF-ocean_waves_awac-4.5m_201701.nc';
adop_35 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/adop-3.5m_tjh/2017/FRF-ocean_waves_adop-3.5m_201701.nc';
xp150 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/xp150m_tjh/2017/FRF-ocean_waves_xp150m_201701.nc';
xp125 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/xp125m_tjh/2017/FRF-ocean_waves_xp125m_201701.nc';
%xp200 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/xp200m_tjh/2016/FRF-ocean_waves_xp200m_201704.nc';

DateString = [[2017,01,01,12,00,00];[2017,01,31,21,00,00]];
dateselected = datenum(DateString);
%% save data 8m_array f

[hs, tp, dp, date] = Read_awac_adop(Bd_data, dateselected);
[dir, date] = Readwavedir_awac_adop(Bd_data, dateselected)
bdry = [hs, tp, dp, dir, date];
bdry(:, 5)

boundary_3days = str2double(bdry(:, [1,2,3,4]));
%% save data  awac_6

[hs, tp, dp, date] = Read_awac_adop(awac_6, dateselected);
[dir, date] = Readwavedir_awac_adop(awac_6, dateselected);
wave_awac6 = [hs, tp, dp, dir, date];
wave_awac6(:, 5)

%lack of 04/12/2017 6am,7am
wave_awac6_3days = str2double([wave_awac6(1:18, [1,2,3,4]);
                              zeros(2, 4);
                              wave_awac6(19:end, [1,2,3,4])]);
%% save data  awac_45

[hs, tp, dp, date] = Read_awac_adop(awac_45, dateselected);
[dir, date] = Readwavedir_awac_adop(awac_45, dateselected);
wave_awac45 = [hs, tp, dp, dir, date];
wave_awac45(:, 5)

%lack of 04/11/2017 13-15pm
wave_awac45_3days = str2double([zeros(4, 4);
                               wave_awac45(:, [1,2,3,4])]);
%% save data  adop_35
[hs, tp, dp, date] = Read_awac_adop(adop_35, dateselected);
[dir, date] = Readwavedir_awac_adop(adop_35, dateselected);
wave_adop35 = [hs, tp, dp, dir, date];
wave_adop35(:, 5)






wave_adop35_3days = str2double(wave_adop35(1:(length(wave_adop35(:, 5))-1),...
                              [1,2,3,4]));
%% save data  xp150

[hs, tp, dp, date] = Read_xp(xp150, dateselected);
wave_xp150 = [hs, tp, dp, date];
wave_xp150(:, 4)


wave_xp150_3days = str2double(wave_xp150(:, [1,2,3]));
%% save data  xp125

[hs, tp, dp, date] = Read_xp(xp125, dateselected);
wave_xp125 = [hs, tp, dp, date];
wave_xp125(:, 4)
wave_xp125_3days = str2double(wave_xp125(:, [1,2,3]));


%% combined data as one matrix
%wavedata is a matrix with data at awac_8m, 6m, 5m each row
%[waveHs waveTp depth]
xid = find(date);

%% Longitude and latitude for sensors
alpha = [ncread(Bd_data, 'longitude'); ncread(awac_6, 'longitude'); ...
    ncread(awac_45, 'longitude'); ncread(adop_35, 'longitude'); ...
    ncread(xp150, 'lon'); ncread(xp125, 'lon')];

beta = [ncread(Bd_data, 'latitude'); ncread(awac_6, 'latitude'); ...
    ncread(awac_45, 'latitude'); ncread(adop_35, 'latitude');  ...
    ncread(xp150, 'lat'); ncread(xp125, 'lat')];


wavedata = str2double([bdry(xid, [1:3]); wave_awac6(xid, [1:3]);...
           wave_awac6(xid, [1:3]); wave_adop35(xid, [1:3]); ...
            wave_xp150(xid, [1:3]); wave_xp125(xid, [1:3])]);

wavedata_global = [alpha, beta, wavedata]    
%save('wavedata20160525_11am', 'wavedata');