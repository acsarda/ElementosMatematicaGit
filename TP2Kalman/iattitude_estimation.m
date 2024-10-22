% Initialization for attitude_estimatiom.mdl
clear

% Sampling times
%
% Sampling time of star tracker and update equations
T=1;  % [s]
% Sampling time of gyro and propagation equations [s]
Tgyro=T/1;  % [s]

% Initial conditions
%
% true quaternion
qreal0=[0; 0; 0; 1];
qreal0=qreal0/sqrt(qreal0'*qreal0);

% Parametres of Honeywell's IRU
%
% Angle Random walk 
ARW=1*0.01;         % [deg/sqrt(h)]
ARW=2.9e-4*ARW;     % [rad/sqrt(s)]
% Bias Stability over 8 hours
BS=1*0.01/2;        % [deg/h]
BS=4.848e-6*BS;     % [rad/s]
% Rate Random Walk 
RRW=0;              % [deg/(h)^3/2]
RRW=8e-8*RRW;       % [rad/s^(3/2)]
% Readout Noise
Rdout=0.8e-6;       % [rad]
% constant bias
bias_cte=0.1*[1;1;1]; % [arcsec/s = deg/h]
bias_cte=4.848e-6*bias_cte; % [rad/s]
% Scale factor 
So=1.164352e6;      % [counts/revolution]
So=So/(2*3.1416);   % [counts/rad]
% Scale factor error
e=[0;0;0];          % [ppm]

% Star tracker noise
%
sss=1*10;           % [arcsec]
sss=4.87e-6*sss;    % [rad]
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
