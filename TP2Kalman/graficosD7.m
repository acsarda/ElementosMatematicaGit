close all;
path0='SimulacionesV2/Simulacion9/Simulacion';
X=20;

for i=1:X
    int2str(i);
    path=strcat(path0,int2str(i),'/');
    
    best=load(strcat(path,'biasEst1.mat'));
    errorQuatEst=load(strcat(path,'errorQuatEst1.mat'));
    t=load(strcat(path,'t.mat'));
    
    best=best.biasEst1;
    errorQuatEst=errorQuatEst.errorQuatEst1;
    t=t.t;
    
    N=length(t);
    theta=zeros(N,1);
    
    idx=find(t<600);
    theta(idx)=errorQuatEst(idx);
    
    idx=find(t>1200);
    theta(idx)=errorQuatEst(idx);
    
    idx=find(t>=600 & t<=1200);
    theta(idx)=errorQuatEst(idx)-best(idx).*(t(idx)-t(idx(1)));
    
    plot(t,theta)
    grid on
    hold on
    
end
%%
ARWSigma=1.8;        % [deg/sqrt(hs)]
ARW=ARWSigma*(pi/180)/sqrt(3600);  % [rad/sqrt(s)]

yRaiz=zeros(N,1);
yRaiz(idx)=ARW*sqrt(t(idx)-t(idx(1)));
plot(t,yRaiz,'k-.')
hold on
plot(t,-yRaiz,'k-.')
xlabel('tiempo [s]')
ylabel('radianes')
%Q
%q