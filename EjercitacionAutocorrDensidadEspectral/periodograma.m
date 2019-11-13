function periodograma(Rs,Fs)
%Rs es la señal
FNyq=Fs/2;
N2=pow2(nextpow2(length(Rs)));
RsN2=zeros(N2,1);
RsN2(1:length(Rs))=Rs;

deltaf=Fs/N2;
f=0:deltaf:FNyq;

dft=fft(RsN2);
dft=dft(1:(N2/2)+1);
Ss=(1/(N2*Fs))*(abs(dft).^2);
Ss(2:end-1)=2*Ss(2:end-1);
Ss=10*log10(Ss);
mediaSs=mean(Ss);
figure;
plot(f,Ss)
hold on
% plot(f,ones(size(f))*mediaSs,'k','Linewidth',2)
% plot(f,Ss,f,ones(size(f))*mediaSs,'k')
grid()
xlabel('frecuencia [Hz]')
ylabel('PSD [dB/Hz]')
title('Periodograma')
end