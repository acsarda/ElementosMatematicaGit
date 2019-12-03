% Initialization for attitude_estimatiom.mdl
clear
%% Sampling times
%
% Sampling time of star tracker and update equations
T=1;  % [s]
% Sampling time of gyro and propagation equations [s]
Tgyro=.1;  % [s]

%% Initial conditions
%
% true quaternion
qreal0=[0; 0; 0; 1];
qreal0=qreal0/sqrt(qreal0'*qreal0);

%% Gyro 
%Parametres of Honeywell's IRU
%
% Angle Random walk 
% ARW=1*0.01;         % [deg/sqrt(h)]
% ARW=2.9e-4*ARW;     % [rad/sqrt(s)]
ARWSigma=.015;        % [deg/sqrt(hs)]
ARW=ARWSigma*(pi/180)/sqrt(3600);  % [rad/sqrt(s)]
% ARW=ARWSigma*(pi/180)/(60*sqrt(Tgyro)); 
% Bias Stability over 8 hours
% BS=1*0.01/2;        % [deg/h]
% BS=4.848e-6*BS;     % [rad/s]
% Rate Random Walk 
% RRW=0;              % [deg/(h)^3/2]
% RRW=8e-8*RRW;       % [rad/s^(3/2)]
RRWSigma=.01;          % [deg/(hs*sqrt(hs))]
RRW=8e-8*RRWSigma;    % [rad/s^(3/2)]
% RRW=RRWSigma*(pi/180)*sqrt(Tgyro)/(Tgyro*(3600^1.5));
% Bias instability
BISigma=0;                 % [deg/hs]
BI=pi/(3600*180);
% Readout Noise
Rdout=0.8e-6;       % [rad]
% constant bias (modelo del gyro)
bias_cte=.04*[1;1;1]; % [arcsec/s = deg/h]
bias_cte=bias_cte*(pi/(180*3600)); % [rad/s]
% Scale factor 
So=1.164352e6;      % [counts/revolution]
So=So/(2*pi);       % [counts/rad]
% Scale factor error
e=[0;0;0];          % [ppm]

%% Star tracker noise
%
sss=.01*3600;           % [arcsec] 
sss=sss*pi/(180*3600);  % [rad]
% sss=0.01*pi/180;      % [rad] 
sstar=[sss; sss; sss];

% Standard deviations used in matrix Q and R
%
seta1filt=1*ARW;    % [rad/s(1/2)]
seta2filt=1*1e-7;   % [rad/s(3/2)]
sstarfilt=1*sstar;  % [rad]

% Kalman filter initial values
%
%qest0=qreal0;
qest0=[0; 0; 0; 1];
qest0=qest0/sqrt(qest0'*qest0);
Pest0=zeros(6,6);
best0=0;

% gyro misallignment
%
ang=0*50e-6;          % [rad]
eje=[1;1;1];        % eje de rotacion
eje=eje/sqrt(eje'*eje);
Misalig=[
    cos(ang)+eje(1)^2*(1-cos(ang))              eje(1)*eje(2)*(1-cos(ang))+eje(3)*sin(ang)  eje(1)*eje(3)*(1-cos(ang))-eje(2)*sin(ang)
    eje(1)*eje(2)*(1-cos(ang))-eje(3)*sin(ang)  cos(ang)+eje(2)^2*(1-cos(ang))              eje(2)*eje(3)*(1-cos(ang))+eje(1)*sin(ang)
    eje(1)*eje(3)*(1-cos(ang))+eje(2)*sin(ang)  eje(2)*eje(3)*(1-cos(ang))-eje(1)*sin(ang)  cos(ang)+eje(3)^2*(1-cos(ang))
];
%% Matrices Q y R
C_bl_GYRO=eye(3);
C_bl_GYRO_aux=[C_bl_GYRO,zeros(3,3);zeros(3,3),C_bl_GYRO];
ARW_aux=.001;        % [deg/sqrt(hs)]
ARW_aux=ARW_aux*(pi/180)/sqrt(3600);  % [rad/sqrt(s)]
RRW_aux=.01;          % [deg/(hs*sqrt(hs))]
RRW_aux=8e-8*RRW_aux;    % [rad/s^(3/2)]
Q_coefs=[eye(3)*(ARW_aux^2),zeros(3,3);zeros(3,3),eye(3)*(RRW_aux^2)];
Q=1*C_bl_GYRO_aux*Q_coefs*(C_bl_GYRO_aux');

C_bl_STR=eye(3);
R=1*(1/4)*C_bl_STR*(eye(3)*(sss^2))*(C_bl_STR');

% Q 
% q