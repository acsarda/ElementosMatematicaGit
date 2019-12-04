path='SimulacionesV2/Simulacion9/Simulacion20/';
mkdir(path)
%% Bias estimado
t=best.Time;
biasEst1=best.Data(:,1);
biasEst2=best.Data(:,2);
biasEst3=best.Data(:,3);
save(strcat(path,'t.mat'),'t')
save(strcat(path,'biasEst1.mat'),'biasEst1')
save(strcat(path,'biasEst2.mat'),'biasEst2')
save(strcat(path,'biasEst3.mat'),'biasEst3')
%% Quaternion estimado
% *pi/(180*3600*2); para pasar de arcseg a rad. El 2 que divide es porque
% en simulink esta multiplicado por 2
errorQuatEst1=ErrorQuatEst.Data(:,1)*pi/(180*3600*2);
errorQuatEst2=ErrorQuatEst.Data(:,2)*pi/(180*3600*2);
errorQuatEst3=ErrorQuatEst.Data(:,3)*pi/(180*3600*2);
save(strcat(path,'errorQuatEst1.mat'),'errorQuatEst1')
save(strcat(path,'errorQuatEst2.mat'),'errorQuatEst2')
save(strcat(path,'errorQuatEst2.mat'),'errorQuatEst3')

%Q
%q