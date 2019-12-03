function bias_estimado(t,best1,best2,best3,tconv,bias_cte)
% best es la variable que viene del simulink 
% tconv es el tiempo para el cual "veo" que convergio el bias estimado
% t=best.Time;
% best1=best.Data(:,1);
% best2=best.Data(:,2);
% best3=best.Data(:,3);
% calculo rms
idx=find(t>tconv);
taux=t(idx);
Ts=t(2)-t(1);
rms1=rms_over_time(best1(idx),Ts);
rms2=rms_over_time(best2(idx),Ts);
rms3=rms_over_time(best3(idx),Ts);

% length(taux)
% length(rms1)
% length(rms2)
% length(rms3)
figure;
subplot(3,1,1)
plot(t,best1)
grid on;
xlabel('tiempo [s]')
ylabel('Bias estimado [rad/s]')
subplot(3,1,2)
plot(t,best2)
grid on;
xlabel('tiempo [s]')
ylabel('Bias estimado [rad/s]')
subplot(3,1,3)
plot(t,best3)
grid on;
xlabel('tiempo [s]')
ylabel('Bias estimado [rad/s]')
figure;
% graficos de RMS
subplot(2,3,1)
plot(taux,rms1,'-')
hold on
plot(taux,ones(length(taux),1)*bias_cte(1),'-.')
grid on
xlabel('tiempo [s]')
ylabel('RMS [rad/s]')
subplot(2,3,2)
plot(taux,rms2,'-')
hold on
plot(taux,ones(length(taux),1)*bias_cte(2),'-.')
grid on
xlabel('tiempo [s]')
ylabel('RMS [rad/s]')
subplot(2,3,3)
plot(taux,rms3,'-')
hold on
plot(taux,ones(length(taux),1)*bias_cte(3),'-.')
grid on
xlabel('tiempo [s]')
ylabel('RMS [rad/s]')
% graficos de errores
subplot(2,3,4)
plot(taux,abs(rms1-bias_cte(1))*100/bias_cte(1),'-')
grid on
xlabel('tiempo [s]')
ylabel('Error %')
subplot(2,3,5)
plot(taux,abs(rms2-bias_cte(2))*100/bias_cte(2),'-')
grid on
xlabel('tiempo [s]')
ylabel('Error %')
subplot(2,3,6)
plot(taux,abs(rms3-bias_cte(3))*100/bias_cte(3),'-')
grid on
xlabel('tiempo [s]')
ylabel('Error %')
end
% Q 
% q