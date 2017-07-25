adop35 = wave_adop35;
awac45 = wave_awac45;

time35 = wave_adop35(:, 5);
n35 = length(time35);
time45 = wave_awac45(:, 5);

for i = 1 : (n35-1)
    if time45(i) ~= time35(i + 1)
        missingid = i
        missinghour = time35(i+1)
        time45(i);
        break
    end
end

awac45_al_H = str2double(wave_awac45(:, [4,1]));
adop35_al_H = str2double(wave_adop35([2:(missingid-1), missingid+1:(n35-1)],...
                              [4,1]));
                          
common_al_H = [awac45_al_H, adop35_al_H]

