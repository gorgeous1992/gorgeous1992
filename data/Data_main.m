clc
clear all
load('072216wavenumbers','wavenum');
load('072216wavefrequences','wavefreq');
load('timecolumn.mat', 'time_col');
%% Plot one piece

Z = squeeze(wavenum(1,:,:,12));
%Remove fake value (elements >1 or negative)
rm_id = find(abs(Z) > 1);
Z(rm_id) = NaN;

figure
surf(Z)

%%%%%%%%
%%%%%%%%
%For statistic forcasting through time series
%take wavenum of four types of waves
%Denote as Stat_wavenum
Stat_wavenum = 1/4 * (wavenum(1,:,:,:) + wavenum(2,:,:,:) + ...
                wavenum(3,:,:,:) + wavenum(4,:,:,:));
%squeeze it and denote as Stat_Z(3d matrix)            
Stat_Z = squeeze(Stat_wavenum(:,:,:,:));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Let's fix y coordinate and do 1-d problem
%For the wavenumber
y_1d = 1;

temp_Z = zeros(length(Stat_Z(:,1,1)) + 1, length(Stat_Z(1,1,:)));
for i = 1 : length(temp_Z(1,:))
    temp_Z(2:end, i) = Stat_Z(:, y_1d, i);
end
temp_Z(1,:) = time_col';
rm_id = find(abs(temp_Z(2:end, :)) > 1);
temp_Z(rm_id) = NaN;
Z_csv = temp_Z;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%
%%%%%%%%

%For wavefrequency plot
%%%%%%%%
%%%%%%%%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Let's fix y coordinate and do 1-d problem
%For the wavefrequency
y_1d = 1;

temp_W = zeros(length(Stat_W(:,1,1)) + 1, length(Stat_W(1,1,:)));
for i = 1 : length(temp_W(1,:))
    temp_W(2:end, i) = Stat_W(:, y_1d, i);
end
temp_W(1,:) = time_col';
rm_id = find(temp_W(2:end, :) < 0);
temp_W(rm_id) = NaN;
W_csv = temp_W;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%
%%%%%%%%




%% Plot wave Height
%Load Height data
load('072216Height.mat', 'T')
size(T)
%Height row is Depth on [x, y].
%Coordinate x is 50:12:950,
%Coordinate y is -100:24:1100
Depth = reshape(T(:, 3), [76, 51]);

surf(Depth)











