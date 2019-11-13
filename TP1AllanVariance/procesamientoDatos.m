close all;
clear all;

gyrox=load('gyrox.mat');
gyroy=load('gyroy.mat');
gyroz=load('gyroz.mat');
gyrox=gyrox.gyrox;
gyroy=gyroy.gyroy;
gyroz=gyroz.gyroz;

% gyrox=load('gyroxLargo.mat');
% gyroy=load('gyroyLargo.mat');
% gyroz=load('gyrozLargo.mat');
% gyrox=gyrox.gyroxLargo;
% gyroy=gyroy.gyroyLargo;
% gyroz=gyroz.gyrozLargo;

gyrox=gyrox*180/pi;%de rad a grados
gyroy=gyroy*180/pi;
gyroz=gyroz*180/pi;
%%
Ts=.01;
periodograma(gyrox,1/Ts,'Densidad espectral de frecuencia')
[desvioAllan,T]=funcionAllanVarianceII(gyrox,Ts,'Allan desviation');
rectasAllanVariance(desvioAllan,T)
%%
periodograma(gyroy,1/Ts,'Densidad espectral de frecuencia')
[desvioAllan,T]=funcionAllanVarianceII(gyroy,Ts,'Allan desviation');
rectasAllanVariance(desvioAllan,T)
%%
periodograma(gyroz,1/Ts,'Densidad espectral de frecuencia')
[desvioAllan,T]=funcionAllanVarianceII(gyroz,Ts,'Allan desviation');
rectasAllanVariance(desvioAllan,T)
% Q
% q