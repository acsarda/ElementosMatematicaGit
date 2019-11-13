%%

fs=10;           %frecuencia de muestreo [Hz]
to=1/fs;
tsim=500;

% ARW y RRW
N=0.03^2;%(0.015    *60)^2; %porque el datasheet lo da en sqrt(psd)
pARW = N^2;%Nhr/sqrt(3600)
fcut = fs;
tARW = 1/(fcut);
pARWdb=10*log10(pARW);

% BInst
BImag =1;% 0.04/3600 
BIsec =BImag;%sqrt(BImag*fs);
BIf0 = fs;
BIto =1/(BIf0);
BIdB=10*log10(BImag)

% Quantization
Qmag= ((1.62e-6)*180/pi)/sqrt(12);%
Q   = fs*Qmag;
Qf0 = fs;
Qto = 1/Qf0;
QdB=10*log10(Qmag);

%Rate
R=0;
%%
omega=data_gyro;
% figure(1)
% 
% omega = omega;
% subplot(121);hold on;
% figure(1);
% [psd,f]=periodogram(omega,[],length(omega),fs,'centered');
%semilogx(f,10*log10(psd));grid on
%semilogx(f,10*log10(ones(length(omega))),'--r','LineWidth',2);grid on
subplot(121)
periodograma(omega,fs,'Power Spectral Density');grid on
hold on;
% semilogx([0,fs/2],1./[0,fs/2].^2,'--r','LineWidth',2)
%title('Power Spectral Density')
ylabel('Power/frequency (dB/Hz)')
xlabel('Frquency (Hz)')

%hold on; plot([-fs,fs],[1,1]*10*log10(pARW),'--r','LineWidth',2)


omega=data_gyro;
theta = cumsum(omega, 1)*to;
maxNumM = 100;
L = size(theta, 1);
maxM = 2.^floor(log2(L/2));
m = logspace(log10(1), log10(maxM), maxNumM).';
m = ceil(m);   % m must be an integer.
m = unique(m); % Remove duplicates.

tau = m*to;

avar = zeros(numel(m), 1);
for i = 1:numel(m)
    mi = m(i);
    avar(i,:) = sum( ...
        (theta(1+2*mi:L) - 2*theta(1+mi:L-mi) + theta(1:L-2*mi)).^2, 1);
end

avar = avar ./ (2*tau.^2 .* (L - 2*m));

%  x=pi*tau*BIf0;
%  sigma=(2/pi)*(BImag^2)*(log(2)-(sin(x).^3./(2*(x.^2))).*(sin(x)+4*x.*cos(x))+cosint(2*x)-cosint(4*x));

% subplot(122);
 figure();
% loglog([0.01,3],[1   ,1],'--r','LineWidth',1.5);hold on
% loglog([3   ,3],[0.001,1],'--r','LineWidth',1.5);hold on
loglog(tau,sqrt(avar),'*k','LineWidth',1.5);hold on
%loglog(tau,sqrt(sigma),'--k','lineWidth',1)
grid on
title('Varianza de Allan para giroscopo ensayado')
xlabel('T [seg]')
ylabel('\sigma(T)')
%%
data=importdata('D:\Maestria\EMPAT\Entregable1\DatosMEMS\Raw_data.csv',',');
data_gyro=data(:,9);
