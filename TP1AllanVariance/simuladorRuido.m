function [ruido,t]=simuladorRuido(Sigmas,Ts,TSim);
% Sigmas: valores caracteristicos de cada tipo de ruido
% Ts: periodo de muestreo en segundos
% TSim: tiempo de simulacion en hs

quantSigma=Sigmas(1);%[deg]
ARWSigma=Sigmas(2);%[deg/sqrt(hs)]
BISigma=Sigmas(3);%[deg/h]
RRWSigma=Sigmas(4);%[deg/(hs*sqrt(hs))]
RRSigma=Sigmas(5);%[deg/(hs^2)]
TSim=TSim*3600;%paso a segundos
N=ceil(TSim/Ts);

%% Quantization noise 
% quantSigma=2e-4;%[deg]
delta=quantSigma*sqrt(12);
qNoise=-(delta/2)+delta*rand(N+1,1);
qNoiseDot=diff(qNoise)/Ts;
% se le pide a rand que cree un vector de long N+1 asi el resultado de diff
% tiene longitud de N
%% Angle random walk (ARW)
% ARWSigma=8e-3;%[deg/sqrt(hs)]
ARWSigma=ARWSigma/(60*sqrt(Ts));
ARWNoiseDot=ARWSigma*randn(N,1);
%% Bias instability (BI)
% BISigma=.1;%[deg/h]
BISigma=BISigma/3600;
pink=dsp.ColoredNoise('Color','pink','SamplesPerFrame',N);
BINoiseDot=pink()*BISigma;
%% Rate random noise (RRW)
% RRWSigma=1;%[deg/(hs*sqrt(hs))]
RRWSigma=RRWSigma*sqrt(Ts)/(Ts*(3600^1.5));%[deg/(seg*sqrt(seg))]
RRWNoiseDotDot=RRWSigma*randn(N,1);
RRWNoiseDot=cumsum(RRWNoiseDotDot*Ts);
%% Rate ramp (RR)
% RRSigma=5;%[deg/(hs^2)]
RRSigma=RRSigma/(3600^2);
RRNoiseDotDot=ones(N,1)*RRSigma;
RRNoiseDot=cumsum(RRNoiseDotDot*Ts);
%%
% ruido=qNoiseDot;
% ruido=ARWNoiseDot;
% ruido=BINoiseDot;
% ruido=RRWNoiseDot;
% ruido=RRNoiseDot;
ruido=qNoiseDot+ARWNoiseDot+BINoiseDot+RRWNoiseDot+RRNoiseDot;
t=(0:Ts:TSim-Ts)';

% Q
% q
end