function bode(entrada,salida,Fs,tituloGrafico)
    
    N2=2^nextpow2(length(entrada));
    
    x=zeros(N2,1);
    y=x;
    
    x(1:length(entrada))=entrada;  
    y(1:length(salida))=salida;
    
    xf=fft(x-mean(x),N2);
    yf=fft(y-mean(y),N2);
    
    g=yf./xf;
    
    gananciadB=20*log10(abs(g));
    
    fase=unwrap(angle(g))*(180/pi);%fase en grados
    
%     Vector de frecuencias
    deltaf=Fs/N2;
    f=0:deltaf:Fs/2;
    
    figure;
   
    subplot(2,1,1)
    
    semilogx(f,gananciadB(1:length(f)),'k')
    ylabel('Ganancia [dB]')
    xlabel('Frecuencia [Hz]')
    grid on;
    title(tituloGrafico)
    
    subplot(2,1,2)
    semilogx(f,fase(1:length(f)),'k')
    ylabel('Fase [Grados]')
    xlabel('Frecuencia [Hz]')
    grid on;
    

end