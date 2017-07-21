clc 
clear all

load('072216wavenumbers','wavenum');
load('072216wavefrequences','wavefreq');
load('timecolumn.mat', 'time_col');
load('Cbathy_xcoor.mat', 'x_coor');
load('Cbathy_ycoor.mat', 'y_coor');
%% Plot one piece
Z = squeeze(wavenum(1,:,:,12));
size(Z)
size(x_coor)
size(y_coor)
%Remove fake value (elements >1 or negative)
rm_id = find(Z < 0);
Z(rm_id) = 0;
[X, Y] = meshgrid(x_coor, y_coor);
% size(X)
% size(Y)
%plot wavenumbers
figure
%pay attension to dimensions
surf(X, Y, Z')
xlabel('Crossshore distance(m)')
ylabel('Alongshore distance(m)')
zlabel('wavenumber')
title('Wavenumber(Cbathy)')

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
y_1d = 2;

temp_Z = zeros(length(Stat_Z(:,1,1)) + 1, length(Stat_Z(1,1,:)));
for i = 1 : length(temp_Z(1,:))
    temp_Z(2:end, i) = Stat_Z(:, y_1d, i);
end
temp_Z(1,:) = time_col';
sz = size(temp_Z);
for i = 1 : sz(1)
    for j = 1 : sz(2)
        if temp_Z(i, j) < 0
            temp_Z(i,j) = NaN;
        end
    end
end
Z_csv = temp_Z;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%
%%%%%%%%

%For wavefrequency plot
%%%%%%%%
%%%%%%%%


W = squeeze(wavefreq(1,:,:,12));

%Remove fake value (elements >1 or negative)
rm_id = find(W < 0);
W(rm_id) = NaN;

[X, Y] = meshgrid(x_coor, y_coor);
% size(X)
% size(Y)
%plot wavefrequency
figure
%pay attension to dimensions
surf(X, Y, W')
xlabel('Crossshore distance(m)')
ylabel('Alongshore distance(m)')
zlabel('wavefrequency')
title('Wavefrequency (Cbathy)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%For statistic forcasting through time series
%take wavenum of four types of waves
%Denote as Stat_wavenum
Stat_wavefreq = 1/4 * (wavefreq(1,:,:,:) + wavefreq(2,:,:,:) + ...
                wavefreq(3,:,:,:) + wavefreq(4,:,:,:));
%squeeze it and denote as Stat_Z(3d matrix)            
Stat_W = squeeze(Stat_wavefreq(:,:,:,:));
%Let's fix y coordinate and do 1-d problem
%For the wavefrequency
y_1d = 1;

temp_W = zeros(length(Stat_W(:,1,1)) + 1, length(Stat_W(1,1,:)));
for i = 1 : length(temp_W(1,:))
    temp_W(2:end, i) = Stat_W(:, y_1d, i);
end
temp_W(1,:) = time_col';

sz = size(temp_W);
for i = 1 : sz(1)
    for j = 1 : sz(2)
        if temp_W(i, j) < 0
            temp_W(i,j) = NaN;
        end
    end
end
W_csv = temp_W;

% figure
% plot(W_csv)
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
Topo = reshape(T(:, 3), [76, 51]);
Topo_y1 = T([1:76], 3);
x_topo = [50:12:950]';
y_topo = [-100:24:1100]';

[X, Y] = meshgrid(x_topo, y_topo);

figure
surf(X, Y, Topo')
xlabel('Crossshore distance(m)')
ylabel('Alongshore distance(m)')
zlabel('Elevation')
title('Elevation')

figure
%Plot the depth_y1, one piece
plot(x_topo, Topo_y1)
xlabel('Crossshore distance(m)')
ylabel('Elevation')
title('Elevation (fixed y = y1)')











