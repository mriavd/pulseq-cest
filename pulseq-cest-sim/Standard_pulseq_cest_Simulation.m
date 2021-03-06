function M_z = Standard_pulseq_cest_Simulation(seq_fn,B0)
%% Run pulseq SBB simulation
% example for a Z-spectrum for GM at 3T with
% - 2 CEST pools
% - a Lorentzian shaped MT pool
%
% All parameters are saved in a struct which is the input for the mex file
%
% Kai Herz, 2020
% kai.herz@tuebingen.mpg.de
if nargin<2
    B0=3;
end

%% Water properties (standard 3T)
PMEX.WaterPool.R1 = 1/1.31;          % Hz
PMEX.WaterPool.R2 = 1/(71e-3);      % Hz
PMEX.WaterPool.f  = 1;              % proton fraction
if round(B0)>4 && round(B0)<9       % 7T 
    PMEX.WaterPool.R1 = 1/1.67;      % Hz
    PMEX.WaterPool.R2 = 1/(43e-3);  % Hz
elseif round(B0)>= 9                % 9.4T and above
    PMEX.WaterPool.R1 = 1/2.0;      % Hz
    PMEX.WaterPool.R2 = 1/(35e-3);  % Hz
end

%% CEST pools
% pool 1 Amide
PMEX.CESTPool(1).R1 = PMEX.WaterPool.R1;
PMEX.CESTPool(1).R2 = 1/100e-3;
PMEX.CESTPool(1).f  = 72e-3/111; % fraction
PMEX.CESTPool(1).dw = 3.5; % chemical shift from water [ppm]
PMEX.CESTPool(1).k  = 30; % exchange rate [Hz]

% pool 2 creatine
PMEX.CESTPool(2).R1 = PMEX.WaterPool.R1;
PMEX.CESTPool(2).R2 = 1/170e-3;
PMEX.CESTPool(2).f  = 20e-3/111; % fraction
PMEX.CESTPool(2).dw = 2; % chemical shift from water [ppm]
PMEX.CESTPool(2).k  = 1100; % exchange rate [Hz]

% pool 3 NOE 
% PMEX.CESTPool(3).R1 = PMEX.WaterPool.R1;
% PMEX.CESTPool(3).R2 = 1/5e-3;
% PMEX.CESTPool(3).f  = 500e-3/111; % fraction
% PMEX.CESTPool(3).dw = -3.5; % chemical shift from water [ppm]
% PMEX.CESTPool(3).k  = 16; % exchange rate [Hz]

%% MT pool
PMEX.MTPool.R1        = 1;
PMEX.MTPool.R2        = 1e5;
PMEX.MTPool.k         = 23;
PMEX.MTPool.f         = 0.0500;
PMEX.MTPool.dw        = -2;
PMEX.MTPool.Lineshape = 'Lorentzian';

%% Put together an initial Magnetization vector (fully relaxed)
% [MxA, MxB, MxD, MyA, MyB, MyD, MzA, MzB, MzD, MzC]
% -> A: Water Pool, B: 1st CEST Pool, D: 2nd CEST Pool, C: MT Pool
% Cest pools would continue in the same way with E, F, G ...
nTotalPools = numel(PMEX.CESTPool)+1; % cest + water
PMEX.M = zeros(nTotalPools*3,1);
PMEX.M(nTotalPools*2+1,1)= PMEX.WaterPool.f;
for ii = 2:nTotalPools
    PMEX.M(nTotalPools*2+ii,1)= PMEX.CESTPool(ii-1).f;
    PMEX.M(nTotalPools*2+1,1) = PMEX.M(nTotalPools*2+1,1) - PMEX.CESTPool(ii-1).f;
end
if isfield(PMEX, 'MTPool') && size(PMEX.M,1) == nTotalPools*3 % add MT pool
    PMEX.M = [PMEX.M; PMEX.MTPool.f];
end

% say you have a magnetization Mi of 50% after the readout. Scale the M
% vector here according to that (ca. 0.5 for FLASH)
PMEX.M = PMEX.M * 0.5;


%% Scanner parameters
PMEX.Scanner.B0    = B0; % field strength [T]
PMEX.Scanner.Gamma = 267.5153; % gyromagnetic ratio [rad/uT]
% optional
% PMEX.Scanner.B0Inhomogeneity = 0.0; % field inhomogeneity [ppm]
% PMEX.Scanner.relB1           = 1.0; % relative B1

%% more optinal paramters
% PMEX.Verbose         = false; % for verbose output, defalut false
% PMEX.ResetInitMag    = true;  % true if magnetization should be set to
% PMEX.M after each ADC, defaultrue
 PMEX.MaxPulseSamples = 500;   % max samples for shaped pulses

%% run sim

M_out = Sim_pulseqSBB(PMEX, seq_fn);
M_z=M_out(nTotalPools*2+1,:);


