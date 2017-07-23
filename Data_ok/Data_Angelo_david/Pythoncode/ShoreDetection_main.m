clc
clear all

topo = importdata('topograpy_y956_042816_1118.mat');
tau = -0.08;

slope = ShoreDetection(topo,tau)















