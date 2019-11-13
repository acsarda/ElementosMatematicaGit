% Allan Variance: Data simulation and analysis demo script.
%
% Author: Juan Jurado, Air Force Institute of Technology, 2017

% Initial MATLAB macros for figure formatting
clear; clc; close all;
set(groot,'defaulttextinterpreter','latex');
set(groot, 'DefaultLegendInterpreter', 'latex')
set(groot,'DefaultAxesFontSize',16);
set(groot,'DefaultTextFontSize',16);
set(groot,'defaultAxesFontName','Helvetica');
set(groot,'defaultTextFontName','Helvetica');
set(groot, 'defaultAxesTickLabelInterpreter','latex'); 
set(groot, 'defaultLegendInterpreter','latex');

% Determine simulated data structure based on desired length and sampling
tMax = 6*3600; % Duration (6 hrs)
dt = .004; % Sampling time (seconds)
nSamp = tMax/dt; % Total number of samples

% Specificy noise std for each type of noise (specified in hrs for ease of
% comparison to most industry specs). Note the numerator is always deg for
% gyros and m/s for accelerometers (i.e. their integrated output).
quantSigma = 2e-4; % deg (gyros) OR m/s (accels)
randWalkSigma = 8e-3; % deg/sqrt(hr) (gyros) OR m/s/sqrt(hr) (accels)
biasSigma = 1e-1; % deg/hr (gyros) OR m/s/hr (accels)
rateRandWalkSigma = 1e0; % deg/hr/sqrt(hr) (gyros) OR m/s/hr/sqrt(hr)(accels)
rateRampSigma = 5; % deg/hr/hr
sigmasIn =  [quantSigma;randWalkSigma;biasSigma;rateRandWalkSigma;...
    rateRampSigma];

% Generate simulated sensor signal with specified noise parameters. Note
% the simulation script will produce an output signal is either in 
% deg/s (gyros) or m/s^2 (accels). To use pink noise in bias instability,
% we lave the last input empty. If we want to see how a FOGM approximation
% would perform, we provide the location (T value) of the zero-slope point
% in seconds (which can be obtained by first running the simulation with 
% FOGM off, then noticing where in the x-axis is the minimum AD curve point.
FOGM = 1;
if FOGM
    % FOGM Approximation of Flicker Noise:
    [Y,FOGMParams] = SimulateINSData(sigmasIn,dt,nSamp,.0119*3600);
else
    % Flicker Noise Method:
    Y = SimulateINSData(sigmasIn,dt,nSamp,[]);
end

% Now feed simulated data to Allan Deviation script to compute Alla
% Deviation and coresponding T for later analysis.
[AllanSigma, T] = ComputeAVAR(Y,dt); 

% AllanSigma is expressed in deg/s (gyro) or m/s^2 (accel), we'll convert
% the denominator to hours prior to anlayzing so we don't have to scale the
% outputs later.
AllanSigma = AllanSigma*3600; % Now in deg/hr (gyros) or m/s^2/hr(accels)
T = T/3600; % Now in hrs

% Finally, feed AllanSigma and T to analyzer script to extract noise
% parameters and compare to those we first introducted into Y.

% The script takes in Log-Log slopes of interest along with respective T
% values to extrapolate to prior to reading desired Allan Deviation. Per
% the literature, the slopes of interest are: -1, -1/2, 0 and 1/2;
slopes = [-1;-0.5;0;0.5;1];

% Also per literature, the corresponding T values to extrapolate to are:
% T=sqrt(3), T=1, N/A, and T=3. Note we've already converted T to hours at
% this point, so there is no need to multiply these values by 3600.
Ts = [sqrt(3);1;NaN;3;sqrt(2)];

% The script will analyse AllanSigma, look for the slopes, extrapolate to
% Ts and report the appropriate AllanSigma found. The last parameter is a
% plot option.
[sigmasOut,Tbias,figs,hs] = AnalyzeAVAR(AllanSigma,T,slopes,Ts,1,1);

% We finally take the output of the analyzer and apply any other scaling
% per the literature. The only scaling needed at this point is for bias
% instability, where we divide by sqrt((2*log(2)/pi)).
sigmasOut(3) = sigmasOut(3)/sqrt((2*log(2)/pi));

% Finally, format the figure and display the input and output noise
% coefficients.
sigmaQ = sprintf('Quantization. In:%0.2e, Out:%0.2e [deg]',...
    sigmasIn(1),sigmasOut(1));
sigmaRW = sprintf('Random Walk. In:%0.2e, Out:%0.2e [deg/$\\sqrt{hr}$]',...
    sigmasIn(2),sigmasOut(2));
sigmaBias = sprintf('Bias Instability. In:%0.2e, Out:%0.2e [deg/hr]',...
    sigmasIn(3),sigmasOut(3));
sigmaRRW = sprintf(...
    'Rate Random Walk. In:%0.2e, Out:%0.2e [deg/hr/$\\sqrt{hr}]$',...
    sigmasIn(4),sigmasOut(4));
sigmaRR = sprintf(...
    'Rate Ramp. In:%0.2e, Out:%0.2e [deg/hr/hr]',...
    sigmasIn(5),sigmasOut(5));

figure(figs(1)); hold on; title('Simulated Data: Allan Deviation');
set(gcf,'Position',[0 0 800 800]);
legend(hs(1,2:end),sigmaQ,sigmaRW,sigmaBias,sigmaRRW,sigmaRR,'Location',...
    'NorthEast');
xlabel('Averaging Time, $\tau$ (hr)');
ylabel('Allan Deviation, $\sigma(\tau)$ (deg/hr)');
grid minor;

% Choose if FOGM approximation to bias stability is desired. If not,
% simulation will use "Pink" noise generator for 1/f flicker noise. 
if FOGM
    Tex = {'FOGM Approximation Parameters:';
           sprintf('$Q_d$: %0.2e',FOGMParams.Qd);...
           sprintf('$\\Phi$: %0.2e',FOGMParams.phi);...
           sprintf('$T_C$: %0.2e',FOGMParams.tc)};
    
      t = textLoc(Tex,'SouthWest','FontSize',14,'EdgeColor',[0,0,0]);
end

figure(figs(2)); hold on; title('Simulated Data: Allan Deviation Slope');
set(gcf,'Position',[0 0 800 800]);
legend(hs(2,2:end),'-1: Quantization','-1/2: Random Walk',...
    '0: Bias Instability','+1/2: Rate Random Walk',...
    '+1: Rate Ramp','Location','NorthEast');
xlabel('Averaging Time, $\tau$ (hr)');
ylabel('Allan Deviation Slope');
grid minor;

