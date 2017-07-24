function [wavedir_id, datatime] = Readwavedir_awac_adop(file, date)
%Input: file on FRF, datatime is date [datenum()]
%output: wavehight, wave Time period, depth, datestring


%% save data file
%Get time from it.
tt = ncread(file,'time');
time = tt/(24*3600) + datenum(1970,1,1);
tm = date;
%get all needed time
id = find(time >= tm(1) & time <= tm(2));
datatime = string(datestr(time(id)));

%ncdisp(file)
%get wave height
wavedir = ncread(file, 'waveMeanDirection');
nan_id = find(isnan(wavedir) == 1);
wavedir(nan_id) = -1000;

wavedir_id = wavedir(id);
end