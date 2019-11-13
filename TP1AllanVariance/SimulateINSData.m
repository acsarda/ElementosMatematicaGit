% SimulateINSData: This script accepts desired noise coefficents of
% interest (assumed to be in "hr" denominators) and generates an output
% signal (deg/s for gyros, m/s^2 for accelerometers) with desired noise
% processes.
% 
% Y = SimulateINSData(Sigmas,dt,N,TBias)
% Outputs:
% Y: Output signal in deg/s (gyros) or m/s^2 (accelerometers)
% FOGM: Parameters of FOGM process if FOGM approximation to flicker noise
% was requested (i.e. if TBias was not empty);
%
% Inputs:
% Sigmas: A vector containing noise coefficients in the following order:
%  1. Quantization coefficient (in deg or m/s)
%  2. Random Walk coefficeint (in deg/sqrt(hr)or m/s/sqrt(hr))
%  3. Bias instability coefficient (in deg/hr or m/s/hr)
%  4. Rate Random Walk coefficient (in deg/hr/sqrt(hr) or m/s/hr/sqrt(hr))
% 
% dt: Sampling time in seconds
% N: Total number of samples
% TBias: Desired location of FOGM zero-slope point for flicker noise
% approximation.

function [Y,FOGM] = SimulateINSData(Sigmas,dt,N,Tbias)
% Quantization noise is generated using an uniform distribution based on
% quantization step size (Delta), which is related to the noise coefficient
% by a factor of sqrt(12). The noise is added to the integrated signal (deg
% or m/s) then the noise is differentiated wrt to time to generate the rate
% signal (deg/s or m/s^2).
Delta = Sigmas(1)*sqrt(12); % Step size
qNoise = -Delta/2+Delta*rand(N+1,1); % Uniform noise (deg or m/s)
qNoiseDot = diff(qNoise)/dt; % Uniform noise (deg/s or m/s^2)

% Angle/Velocity random walk is manifested by the integration of WGN found
% in the deg/s or m/s^2 signal. Since we are generating precisely that
% signal, we just add WGN directly. The noise coefficent given to the
% script was in deg/sqrt(hr) or m/s/sqrt(hr). We'll convert the units of
% this coefficient to match our output signal (deg/s or m/s^2).
SigmaRW = Sigmas(2)/60/sqrt(dt); % Converted sigma to deg/s or m/s^2
RWNoiseDot = SigmaRW*randn(N,1); % WGN noise signal

% Bias Instability is generated with either flicker (pink) noise or
% approximated by a First Order Gauss Markov signal with appropriate
% strength and correlation time. The input coefficient was in deg/hr or
% m/s/hr, so we need to convert to the units of our output signal (deg/s or
% m/s^2).
SigmaBias = Sigmas(3)/3600; % Converted to deg/s or m/s^2

% Direct Flicker Noise Method
if isempty(Tbias)
    pink = dsp.ColoredNoise('Color','pink','SamplesPerFrame',N);
    biasNoiseDot = SigmaBias*pink();
    FOGM = [];
else
    % FOGM Approximation Method
    tc = Tbias/1.89;
    Q = SigmaBias;
    Qd = Q^2*(1 - exp(-2*dt/tc));
    phi = exp(-dt/tc);
    biasNoiseDot = zeros(N,1);    % Initialize w/ zeros
    biasNoiseDot(1) = sqrt(Qd)*randn;    % Initial state
    for ii=2:N
        biasNoiseDot(ii) = phi*biasNoiseDot(ii-1) + sqrt(Qd)*randn;
    end
    FOGM.tc = tc;
    FOGM.Qd = Qd;
    FOGM.phi = phi;
end

% Rate Random Walk refers to a random walk that is manifested in the rate
% output (deg/s or m/s^2). This means the random walk came from WGN found
% in the derrivative of the rate output. Namely in a signal that is the
% derrivative of our desired output signal. To simulate RRW, we will then
% apply WGN to a signal and integrate it once to produce our desired output
% signal. Same unit conversion applies here as we take in deg/hr/sqrt(hr)
% or m/s/hr/sqrt(hr) and convert to deg/s or m/s^2
SigmaRRW = Sigmas(4)/(3600*60)*sqrt(dt)/dt; % [deg/s^2] or [m/s/s^2]
RRWNoiseDotDot = SigmaRRW*randn(N,1);
RRWNoiseDot = cumsum(RRWNoiseDotDot*dt); % In deg/s or m/s/s

% Rate Ramp [deg/hr/hr]
R = Sigmas(5)/(3600*3600); % [deg/s/s]
RRNoiseDotDot = ones(N,1)*R; 
RRNoiseDot = cumsum(RRNoiseDotDot*dt);

% Finally, the output signal in deg/s or m/s^2 is constructed by adding all
% noise sources since they are assumed to be independent. Note that
% IEEE-STD-952-1997 specifices Allan Variances add linearly, which is not
% contradicted by this sum since these are not variances but rather time
% domain signals.
Y = qNoiseDot + RWNoiseDot + biasNoiseDot + RRWNoiseDot + RRNoiseDot;



