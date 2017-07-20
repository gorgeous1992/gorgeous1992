clc
clear all
load('072216wavenumbers','wavenum');
load('072216wavefrequences','wavefreq');

%% Plot one piece

Z = squeeze(wavenum(1,:,:,12));
%Remove fake value (elements >1 or negative)
rm_id = find(abs(Z) > 1);
Z(rm_id) = NaN;

figure
surf(Z)

%For statistic forcasting through time series
%take wavenum of four types of waves
%Denote as Stat_wavenum
Stat_wavenum = 1/4 * (wavenum(1,:,:,:) + wavenum(2,:,:,:) + ...
                wavenum(3,:,:,:) + wavenum(4,:,:,:));
%squeeze it and denote as Stat_Z(3d matrix)            
Stat_Z = squeeze(Stat_wavenum(:,:,:,:));

W = squeeze(wavefreq(1,:,:,12));

%Remove fake value (elements >1 or negative)
rm_id = find(W < 0);
W(rm_id) = NaN;

figure
surf(W)

%% Plot wave Height
%Load Height data
load('072216Height.mat', 'T')
size(T)
%Height row is Depth on [x, y].
%Coordinate x is 50:12:950,
%Coordinate y is -100:24:1100
length(T(:, 3))
Depth = reshape(T(:, 3), [76, 51])

surf(Depth)











