function [desvioAllan,T]=funcionAllanVarianceII(velAng,Ts,titulo)
% Ts: periodo de muestreo [s]
% titulo: titulo del grafico de Allan variance
N=length(velAng);

% potenciaMaxima=nextpow2((N2/2)-1);
% n=zeros(potenciaMaxima+1,1);
% 
% for i=2:potenciaMaxima+1
% %     n(i)=2^(i-1);
% end

naux=2.^(0:floor(log2(N/2)))';
CantidadPuntos=1000;
% n=unique(ceil(linspace(1,naux(end),CantidadPuntos)));
n=unique(ceil(logspace(0,log10(naux(end)),CantidadPuntos)));

varianzaAllan=zeros(length(n),1);
T=zeros(length(n),1);

posAng=cumsum(velAng)*Ts;

for i=1:length(n)
    T(i)=n(i)*Ts;
    suma=0;
    for k=1:N-2*n(i)
        sumando=posAng(k+2*n(i))-2*posAng(k+n(i))+posAng(k);
        sumando=sumando^2;
        suma=suma+sumando;        
    end
    varianzaAllan(i)=suma/(2*(T(i)^2)*(N-2*n(i)));
    
end

desvioAllan=sqrt(varianzaAllan);
%[deg/s] para un gyro o [m/s] para un acelerometro

% desvioAllan=desvioAllan.*3600;
% T=T./3600;

figure;
loglog(T./3600,desvioAllan.*3600,'ko')
grid on;
xlabel('T [hs]')
ylabel('\sigma (T) [deg/hs]')
title(titulo)
end