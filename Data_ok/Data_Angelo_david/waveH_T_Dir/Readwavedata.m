clc
clear all
%% get data
%boundary data: 8m_array, x = 900m
Bd_data = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/8m-array/2016/FRF-ocean_waves_8m-array_201605.nc';
%ncdisp(Bd_data)
%Inside date
awac_6 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/awac-6m/2016/FRF-ocean_waves_awac-6m_201605.nc';
%awac_45 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/awac-4.5m/2017/FRF-ocean_waves_awac-4.5m_201703.nc';
adop_35 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/adop-3.5m_tjh/2016/FRF-ocean_waves_adop-3.5m_201605.nc';
xp150 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/xp150m_tjh/2016/FRF-ocean_waves_xp150m_201605.nc';
xp125 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/xp125m_tjh/2016/FRF-ocean_waves_xp125m_201605.nc';
xp200 = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/oceanography/waves/xp200m_tjh/2016/FRF-ocean_waves_xp200m_201605.nc';
%ncdisp(xp150)


var = 'https://chlthredds.erdc.dren.mil/thredds/dodsC/frf/projects/bathyduck/data/cbathy/Bathyduck-ocean_bathy_argus_201605.nc';
%% Get wavenum from cBathy data
% %ncdisp(var)
% tt = ncread(var,'time');
% time = tt/(24*3600) + datenum(1970,1,1);
% %pick tm
% tm = datenum(2016, 05, 27);
% id = find(floor(time) == tm);
% datestr(time(id))
% %Pick 03/11/2016 at 11am
% timeneed_id = id(11);
% wavenum = ncread(var, 'k', [1,1,1,min(id)], [inf , inf, inf, length(id)]);
% temp = 1/4*(wavenum(1,:,:,12) + wavenum(2,:,:,12) + ...
%     wavenum(3,:,:,12) + wavenum(4,:,:,12));
% wavenum = squeeze(temp);
% xm = ncread(var, 'xm');
% ym = ncread(var, 'ym');
% yjd = find(ym == 950);
% wavenum_1d = (wavenum(:, yjd));
% wavenum_data = [xm, wavenum_1d];
% save('wavenum20160527_11am', 'wavenum_data');

dateselected = datenum(2016, 05, 25);
%% save data 8m_array 

[hs, tp, dp, date] = Read_awac_adop(Bd_data, dateselected);
bdry = [hs, tp, dp, date];
bdry(:, 4)

%% save data  awac_6

[hs, tp, dp, date] = Read_awac_adop(awac_6, dateselected);
wave_awac6 = [hs, tp, dp, date];
wave_awac6(:, 4)
%% save data  adop_35
[hs, tp, dp, date] = Read_awac_adop(adop_35, dateselected);
wave_adop35 = [hs, tp, dp, date];
wave_adop35(:, 4)
%% save data  xp150

[hs, tp, dp, date] = Read_xp(xp150, dateselected);
wave_xp150 = [hs, tp, dp, date];
wave_xp150(:, 4)
%% save data  xp125

[hs, tp, dp, date] = Read_xp(xp125, dateselected);
wave_xp125 = [hs, tp, dp, date];
wave_xp125(:, 4)

%% save data  xp200

[hs, tp, dp, date] = Read_xp(xp200, dateselected);
wave_xp200 = [hs, tp, dp, date];
wave_xp200(:, 4)
%% combined data as one matrix
%wavedata is a matrix with data at awac_8m, 6m, 5m each row
%[waveHs waveTp depth]
xid = [13, 13, 13, 13, 13, 13];

wavedata = str2double([bdry(xid(1), [1:3]); wave_awac6(xid(2), [1:3]);...
           wave_adop35(xid(3), [1:3]); wave_xp200(xid(4), [1:3]);...
            wave_xp150(xid(5), [1:3]); wave_xp125(xid(6), [1:3])])
%save('wavedata20160525_11am', 'wavedata')