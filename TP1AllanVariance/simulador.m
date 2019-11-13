clear;
close all;
desviosRuidos=[2e-4;8e-3;.1;1;5];
Ts=.004;
Fs=1/Ts;
TSim=5;

[ruido,t]=simuladorRuido(desviosRuidos,Ts,TSim);
periodograma(ruido,3/Ts,'Densidad espectral de frecuencia')
[desvioAllan,T]=funcionAllanVarianceII(ruido,Ts,'Allan desviation');
%%
rectasAllanVariance(desvioAllan,T)
% Q
% q