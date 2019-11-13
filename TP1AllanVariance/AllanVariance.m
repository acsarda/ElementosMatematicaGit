clear;
close all;

TSimHs=1/2;
TSim=TSimHs*3600;
% TSim=10;
Fs=10;
Ts=1/Fs;
t=0:Ts:TSim-Ts;
%%
RuidoVelARW=RuidoVelARW.Data(:,1,1);
RuidoVelCuantizacion=RuidoVelCuantizacion.Data(:,1,1);
RuidoVelBI=RuidoVelBI.Data(:,1,1);
RuidoVelRRW=RuidoVelRRW.Data(:,1,1);
% RuidoVelRateRamp=RuidoVelRateRamp.Data(:,1,1);
% RuidoVel=RuidoVel.Data(:,1,1);
%%
RuidoVelARW_W=variablesForWorkspace(t,RuidoVelARW);
RuidoVelCuantizacion_W=variablesForWorkspace(t,RuidoVelCuantizacion);
RuidoVelBI_W=variablesForWorkspace(t,RuidoVelBI);
RuidoVelRRW_W=variablesForWorkspace(t,RuidoVelRRW);

%%
close all;
funcionAllanVarianceI(RuidoVelARW,Ts,'Angle random walk')
funcionAllanVarianceI(RuidoVelCuantizacion,Ts,'Cuantizacion')
funcionAllanVarianceI(RuidoVelBI,Ts,'Bias instability')
funcionAllanVarianceI(RuidoVelRRW,Ts,'Rate random walk')
% funcionAllanVarianceI(RuidoVelRateRamp,Ts,'Rate ramp')
% funcionAllanVarianceI(RuidoVel,Ts,'RuidoVel total')

funcionAllanVarianceII(RuidoPosCuantizacion,Ts,'Cuantizacion')
funcionAllanVarianceII(RuidoPosARW,Ts,'Angle random walk')
funcionAllanVarianceII(RuidoPosBI,Ts,'Bias instability')
funcionAllanVarianceII(RuidoPosRRW,Ts,'Rate random walk')


% (log10()-log10())/(log10()-log10())