clc
clear all

%% cBathy from Davoud
%Run it in command terminal!!!!!
%Don't run the script!!!

bathy = load('cBathy_results 2017apr.1.mat')
h = bathy.fCombined.h;
ym = (bathy.ym)';
id = find(ym == 950);
xm = (bathy.xm)';
cBathy_depth = [xm, h(id, :)']
