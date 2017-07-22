clc 
clear all

%We are going to use the average wave here. 
%Average wave type: Here are origninally 4 different types of wave. For
%easy use, we will take the average values of them.

load('072216wavenumbers','wavenum');
load('072216wavefrequences','wavefreq');
load('timecolumn.mat', 'time_col');
load('Cbathy_xcoor.mat', 'x_coor');
load('Cbathy_ycoor.mat', 'y_coor');

%% Statistic data (wavespeed)
%%%%%%%%
%%%%%%%%
%For statistic forcasting through time series
%take wavenum of four types of waves
%Denote as Stat_wavenum
Stat_wavenum = 1/4 * (wavenum(1,:,:,:) + wavenum(2,:,:,:) + ...
                wavenum(3,:,:,:) + wavenum(4,:,:,:));
%squeeze it and denote as Stat_Z(3d matrix)            
Stat_Z = squeeze(Stat_wavenum(:,:,:,:));
%Remove fake values(negative values)
rm_id = find(Stat_Z < 0);
Stat_Z(rm_id) = NaN;

%For statistic forcasting through time series
%take wavenum of four types of waves
%Denote as Stat_wavenum
Stat_wavefreq = 1/4 * (wavefreq(1,:,:,:) + wavefreq(2,:,:,:) + ...
                wavefreq(3,:,:,:) + wavefreq(4,:,:,:));
%squeeze it and denote as Stat_Z(3d matrix)            
Stat_W = squeeze(Stat_wavefreq(:,:,:,:));
%Remove fake values(negative values)
rm_id = find(Stat_W < 0);
Stat_W(rm_id) = NaN;

%wave speed is C, C = \sigma/k, where \sigma is angular frequency
Stat_wavespeed = Stat_W./Stat_Z;

%% Plot wavespeed at time_col(t_fix)
t_fix = 1;
Z = Stat_wavespeed(:,:,t_fix)
size(Z)
size(x_coor)
size(y_coor)

[X, Y] = meshgrid(x_coor, y_coor);
% size(X)
% size(Y)
%plot wavenumbers
figure
subplot(2,1,1)
%pay attension to dimensions
surf(X, Y, Z')
xlabel('Crossshore distance(m)')
ylabel('Alongshore distance(m)')
zlabel('wavespeed')
title('Wave speed (Cbathy, average)')

hold on


%% Plot 1-d wavespeed fixed y at time_col(1)
y_fix = 1;
Z_1d = Stat_wavespeed(:, y_fix, t_fix)


subplot(2,1,2)
plot(x_coor, Z_1d)
xlabel('crossshore (m)')
ylabel('wave speed (m/s)')
title('wave speed (1-D)')

