% clear;
TiempoSim=1e4;
wn=0.01;
psi=.7;
wc=wn*100;
wcHz=wc/(2*pi);

Is=1e3;
Kd=2*psi*wn*Is;
K=Is*wn^2;


%% Bloque Band Limited White Noise
RMSRuido=1;
VarianzaRuido=RMSRuido^2;
FrecRuido=wcHz*100;
A=VarianzaRuido/(2*FrecRuido);

FrecRuidoBloque=2*FrecRuido;

Fs=3*FrecRuidoBloque;
% 
%% Rate noise
sys=-2*psi*wn*tf([0 1 0],[1 2*psi*wn wn^2]);

c1=2*psi*wn*wc;
d3=1;
d2=2*psi*wn+wc;
d1=(wn^2)+2*psi*wn*wc;
d0=wc*(wn^2);
I3=((c1^2)/(2*(d1*d2-d0*d3)));
varianzaVelAng=4*((psi*wn)^2)*A*I3;
B=2*((psi*wn)^2)*I3;

MSVelAng=A*((psi*wn*wc)^2)/(psi*(wn^3)+2*wc*((psi*wn)^2)+psi*wn*(wc^2));
MSVelAngLimite=psi*wn*A;

MSPosAng=A*(2*(psi^3)*wn*wc+((psi*wc)^2))/(psi*(wn^3)+2*wc*((psi*wn)^2)+psi*wn*(wc^2));
MSPosAngLimite=A*(psi/wn);
%% Position noise
WN_PS=A;
MSVelAng=WN_PS*((wn^4)*(wc^2))/(4*(psi*(wn^3)+2*wc*((psi*wn)^2)+psi*wn*(wc^2)));
MSVelAngLimite=WN_PS*(wn^3)/(4*psi);

MSPosAng=WN_PS*((2*psi*(wn^3)*wc)+((wn*wc)^2))/(4*(psi*(wn^3)+2*wc*((psi*wn)^2)+psi*wn*(wc^2)));
MSPosAngLimite=WN_PS*(wn/(4*psi));
%% Reaction wheel
MSVelAng=A*(wc^2)/(4*(Is^2)*(psi*(wn^3)+2*wc*((psi*wn)^2)+psi*wn*(wc^2)));
MSVelAngLimite=A/(4*psi*wn*(Is^2));

MSPosAng=A*(2*psi*wn*wc+(wc^2))/(4*(Is^2)*(wn^2)*(psi*(wn^3)+2*wc*((psi*wn)^2)+psi*wn*(wc^2)));
MSPosAngLimite=A/(4*(wn^3)*(Is^2)*psi);
%% errores
clc
errorVelAng=1-(MSVelAng/(rms(velAng)^2))
errorVelAngLimite=1-(MSVelAngLimite/(rms(velAng)^2))
errorPosAng=1-(MSPosAng/(rms(posAng)^2))
errorPosAngLimite=1-(MSPosAngLimite/(rms(posAng)^2))
%% Sistema sin medicion de la velocidad angular
Cp=K;
Co=Kd;

d3=1;
d2=2*psi*wn+wc;
d1=(wn^2)+2*psi*wn*wc;
d0=wc*(wn^2);
%% Position noise
c1=2*psi*wn*wc;
c0=(wn^2)*wc;

I3=((c1^2)*d0+(c0^2)*d2)/(2*d0*(d1*d2-d0*d3));
MSPosAng=I3*A;
%% Reaction wheel
c0=wc/Is;

I3=((c0^2)*d2)/(2*d0*(d1*d2-d0*d3));
MSPosAng=I3*A;
%%
clc;
errorPosAng=1-(MSPosAng/(rms(posAng)^2))
%%
close all
periodograma(ruido,Fs,'Periodograma del ruido BLWN')
periodograma(ruidoFiltrado,Fs,'Periodograma del ruido filtrado')
bode(ruido,ruidoFiltrado,Fs,'Bode - Filtro de primer orden')
bode(ruido,velAng,Fs,'Bode - Velocidad angular')
bode(ruido,posAng,Fs,'Bode - Posicion angular')