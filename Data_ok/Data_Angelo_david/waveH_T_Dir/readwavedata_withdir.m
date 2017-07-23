clc
clear all
%% get data
%boundary data: 8m_array, x = 900m
Bd_data = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/8m-array/2016/FRF-ocean_waves_8m-array_201604.nc';
ncdisp(Bd_data)
%Inside date
awac_6 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/awac-6m/2016/FRF-ocean_waves_awac-6m_201604.nc';
%awac_45 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/awac-4.5m/2017/FRF-ocean_waves_awac-4.5m_201703.nc';
adop_35 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/adop-3.5m_tjh/2016/FRF-ocean_waves_adop-3.5m_201604.nc';

dateselected = datenum(2016, 04, 28);
%% save data 8m_array 

[hs, tp, dp, date] = Read_awac_adop(Bd_data, dateselected);
[dir, date] = Readwavedir_awac_adop(Bd_data, dateselected);
bdry = [hs, tp, dp, dir, date];
bdry(:, 5)
%% save data  awac_6

[hs, tp, dp, date] = Read_awac_adop(awac_6, dateselected);
[dir, date] = Readwavedir_awac_adop(awac_6, dateselected);
wave_awac6 = [hs, tp, dp, dir, date];
wave_awac6(:, 5)
%% save data  adop_35
[hs, tp, dp, date] = Read_awac_adop(adop_35, dateselected);
[dir, date] = Readwavedir_awac_adop(adop_35, dateselected);
wave_adop35 = [hs, tp, dp, dir, date];
wave_adop35(:, 5)

%% combined data as one matrix
%wavedata is a matrix with data at awac_8m, 6m, 5m each row
%[waveHs waveTp depth]
xid = [12, 12, 12];

wavedata = str2double([bdry(xid(1), [1:4]); wave_awac6(xid(2), [1:4]);...
           wave_adop35(xid(3), [1:4]);])
