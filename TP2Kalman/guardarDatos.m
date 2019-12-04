path='SimulacionesV2/Simulacion8/';
%% Bias estimado
tBiasEst=best.Time;
biasEst1=best.Data(:,1);
biasEst2=best.Data(:,2);
biasEst3=best.Data(:,3);
save(strcat(path,'tBiasEst.mat'),'tBiasEst')
save(strcat(path,'biasEst1.mat'),'biasEst1')
save(strcat(path,'biasEst2.mat'),'biasEst2')
save(strcat(path,'biasEst3.mat'),'biasEst3')
%% Kalman
tKalman=KalmanBias.Time;

KalmanBias1=KalmanBias.Data(:,1);
KalmanBias2=KalmanBias.Data(:,2);
KalmanBias3=KalmanBias.Data(:,3);

KalmanQuaternion1=KalmanQuaternion.Data(:,1);
KalmanQuaternion2=KalmanQuaternion.Data(:,2);
KalmanQuaternion3=KalmanQuaternion.Data(:,3);

save(strcat(path,'tKalman.mat'),'tKalman')

save(strcat(path,'KalmanBias1.mat'),'KalmanBias1')
save(strcat(path,'KalmanBias2.mat'),'KalmanBias2')
save(strcat(path,'KalmanBias3.mat'),'KalmanBias3')

save(strcat(path,'KalmanQuaternion1.mat'),'KalmanQuaternion1')
save(strcat(path,'KalmanQuaternion2.mat'),'KalmanQuaternion2')
save(strcat(path,'KalmanQuaternion3.mat'),'KalmanQuaternion3')
%% Error Quaternion Medido (EQR) y Error Quaternion Estimado (EQE)
tEQR=ErrorQuatMed.Time;

EQR1=ErrorQuatMed.Data(:,1);
EQR2=ErrorQuatMed.Data(:,2);
EQR3=ErrorQuatMed.Data(:,3);

EQE1=ErrorQuatEst.Data(:,1);
EQE2=ErrorQuatEst.Data(:,2);
EQE3=ErrorQuatEst.Data(:,3);

save(strcat(path,'tEQR.mat'),'tEQR')

save(strcat(path,'EQR1.mat'),'EQR1')
save(strcat(path,'EQR2.mat'),'EQR2')
save(strcat(path,'EQR3.mat'),'EQR3')

save(strcat(path,'EQE1.mat'),'EQE1')
save(strcat(path,'EQE2.mat'),'EQE2')
save(strcat(path,'EQE3.mat'),'EQE3')
%% Quaternion Medido  y Quaternion Estimado 

tQuatMed=QuatMed.Time;

QuatMed1=QuatMed.Data(:,1);
QuatMed2=QuatMed.Data(:,2);
QuatMed3=QuatMed.Data(:,3);
QuatMed4=QuatMed.Data(:,4);

QuatEst1=QuatEst.Data(:,1);
QuatEst2=QuatEst.Data(:,2);
QuatEst3=QuatEst.Data(:,3);
QuatEst4=QuatEst.Data(:,4);

save(strcat(path,'tQuatMed.mat'),'tQuatMed')

save(strcat(path,'QuatMed1.mat'),'QuatMed1')
save(strcat(path,'QuatMed2.mat'),'QuatMed2')
save(strcat(path,'QuatMed3.mat'),'QuatMed3')
save(strcat(path,'QuatMed4.mat'),'QuatMed4')

save(strcat(path,'QuatEst1.mat'),'QuatEst1')
save(strcat(path,'QuatEst2.mat'),'QuatEst2')
save(strcat(path,'QuatEst3.mat'),'QuatEst3')
save(strcat(path,'QuatEst4.mat'),'QuatEst4')
% Q