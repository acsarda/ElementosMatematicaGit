function funcionAllanVarianceI(signal,Ts,titulo)
% La señal que se recibe es la velocidad angular
N=length(signal);
N2=2^nextpow2(N);
signalN2=zeros(N2,1);
signalN2(1:N)=signal;
signalN2=signalN2.*Ts;
% La multiplico por Ts porque tengo que hacer sumas d Riemann

potenciaMaxima=nextpow2((N2/2)-1);
n=zeros(potenciaMaxima+1,1);

for i=1:length(n)
    n(i)=2^(i-1);
end

varianzaAllan=zeros(length(n),1);
T=zeros(length(n),1);

for i=1:length(n)
    T(i)=n(i)*Ts;
    signalN2Sum=zeros(N2/n(i),1);
    
    for j=1:N2/n(i)        
        indiceInferior=j*n(i)-n(i)+1;
        indiceSuperior=j*n(i);
        signalN2Sum(j)=sum(signalN2(indiceInferior:indiceSuperior));        
    end
    
    xi=zeros(N2/n(i)-1,1);
    
    for j=1:N2/n(i)-1
        xi(j)=signalN2Sum(j+1)-signalN2Sum(j);
    end
    xi=xi./T(i);
    varianzaAllan(i)=sum(xi.^2)/(2*(N2-2*n(i)));
end

desvioAllan=sqrt(varianzaAllan);

figure;
loglog(T,desvioAllan,'ko')
grid on;
xlabel('T')
ylabel('\sigma (T)')
title(titulo)
end