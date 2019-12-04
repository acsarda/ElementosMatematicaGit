% clear;
close all;

% path='SimulacionesV2/Simulacion8/';
path='SimulacionesV2/Simulacion8/Simulacion1/';
%%
tBiasEst=load(strcat(path,'tBiasEst.mat'));
biasEst1=load(strcat(path,'biasEst1.mat'));
biasEst2=load(strcat(path,'biasEst2.mat'));
biasEst3=load(strcat(path,'biasEst3.mat'));

tBiasEst=tBiasEst.tBiasEst;
biasEst1=biasEst1.biasEst1;
biasEst2=biasEst2.biasEst2;
biasEst3=biasEst3.biasEst3;

idx=find(tBiasEst<=tBiasEst(end));
% idx=find(tBiasEst<=tBiasEst(end))
figure;
subplot(3,1,1)
plot(tBiasEst(idx),biasEst1(idx))
grid on;
xlabel('Tiempo [s]')
ylabel('[rad/s]')
subplot(3,1,2)
plot(tBiasEst(idx),biasEst2(idx))
grid on;
xlabel('Tiempo [s]')
ylabel('[rad/s]')
subplot(3,1,3)
plot(tBiasEst(idx),biasEst3(idx))
grid on;
xlabel('Tiempo [s]')
ylabel('[rad/s]')

bias_estimado(tBiasEst,biasEst1,biasEst2,biasEst3,0,bias_cte);
%%
tQuatMed=load(strcat(path,'tQuatMed.mat'));

KalmanQuaternion1=load(strcat(path,'KalmanQuaternion1.mat'));
KalmanQuaternion2=load(strcat(path,'KalmanQuaternion2.mat'));
KalmanQuaternion3=load(strcat(path,'KalmanQuaternion3.mat'));

KalmanBias1=load(strcat(path,'KalmanBias1.mat'));
KalmanBias2=load(strcat(path,'KalmanBias2.mat'));
KalmanBias3=load(strcat(path,'KalmanBias3.mat'));

tQuatMed=tQuatMed.tQuatMed;

KalmanQuaternion1=KalmanQuaternion1.KalmanQuaternion1;
KalmanQuaternion2=KalmanQuaternion2.KalmanQuaternion2;
KalmanQuaternion3=KalmanQuaternion3.KalmanQuaternion3;

KalmanBias1=KalmanBias1.KalmanBias1;
KalmanBias2=KalmanBias2.KalmanBias2;
KalmanBias3=KalmanBias3.KalmanBias3;

t=tQuatMed;
% idx=find(t<=t(end));
idx=find(t<3);
figure;
subplot(3,1,1)
plot(t(idx),KalmanQuaternion1(idx))
grid on;
xlabel('Tiempo [s]')
subplot(3,1,2)
plot(t(idx),KalmanQuaternion2(idx))
grid on;
xlabel('Tiempo [s]')
subplot(3,1,3)
plot(t(idx),KalmanQuaternion3(idx))
grid on;
xlabel('Tiempo [s]')

idx=find(t<=t(end));
% idx=find(t<4000);
figure;
subplot(3,1,1)
plot(t(idx),KalmanBias1(idx))
grid on;
xlabel('Tiempo [s]')
subplot(3,1,2)
plot(t(idx),KalmanBias2(idx))
grid on;
xlabel('Tiempo [s]')
subplot(3,1,3)
plot(t(idx),KalmanBias3(idx))
grid on;
xlabel('Tiempo [s]')
%%
t=load(strcat(path,'tQuatMed.mat'));
t=t.tQuatMed;

EQE1=load(strcat(path,'EQE1.mat'));
EQE2=load(strcat(path,'EQE2.mat'));
EQE3=load(strcat(path,'EQE3.mat'));

EQE1=EQE1.EQE1;
EQE2=EQE2.EQE2;
EQE3=EQE3.EQE3;

EQR1=load(strcat(path,'EQR1.mat'));
EQR2=load(strcat(path,'EQR2.mat'));
EQR3=load(strcat(path,'EQR3.mat'));

EQR1=EQR1.EQR1;
EQR2=EQR2.EQR2;
EQR3=EQR3.EQR3; 

figure;
subplot(3,1,1)
plot(t,EQR1,t,EQE1)
legend('Medicion','Estimacion')
grid on;
xlabel('Tiempo [s]')
ylabel('Arcosegundos')
subplot(3,1,2)
plot(t,EQR2,t,EQE2)
legend('Medicion','Estimacion')
grid on;
xlabel('Tiempo [s]')
ylabel('Arcosegundos')
subplot(3,1,3)
plot(t,EQR3,t,EQE3)
legend('Medicion','Estimacion')
grid on;
xlabel('Tiempo [s]')
ylabel('Arcosegundos')