function rectasAllanVariance(AllanDesv,T)
% T: vector de tiempos promedios
% AllanDesv: vector con los desvios de Allan
AllanDesv=AllanDesv.*3600;
T=T./3600;
N=length(T);
slopes=zeros(N-1,1);
for i=1:N-1
    slopes(i)=log10(AllanDesv(i+1)/AllanDesv(i))/log10(T(i+1)/T(i));
end
% m=[-1;-.5;0;.5;1];
m=[-.5;0];
% m=[-1;-.5];
Nm=length(m);
closestSlopes=zeros(Nm,1);
idx=zeros(Nm,1);
for j=1:Nm
    diferencia=abs(m(j)-slopes);
    idx(j)=find(diferencia==min(diferencia));
    closestSlopes(j)=slopes(idx(j));
end
figure;
loglog(T,AllanDesv,'ko')
grid on;
xlabel('T [hs]')
ylabel('\sigma (T) [deg/hs]')

tiposLinea=['*','+','s','x','d'];
for j=1:Nm;
    hold on;
    loglog(T,(T.^closestSlopes(j))*AllanDesv(idx(j))/(T(idx(j))^closestSlopes(j)),'LineWidth',2);
    grid on;
end
legend('Simulación Allan variance',['Pendiente ',num2str(closestSlopes(1))],['Pendiente ',num2str(closestSlopes(2))],['Pendiente ',num2str(closestSlopes(3))],['Pendiente ',num2str(closestSlopes(4))],['Pendiente ',num2str(closestSlopes(5))])
ylim([min(AllanDesv)*.7 max(AllanDesv)*1.1])




end
% Q
% q