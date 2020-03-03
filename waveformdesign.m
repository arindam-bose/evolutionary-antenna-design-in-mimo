%%
clc;
clear all;
close all;
addpath(genpath('util/'));
rng(23);
 
%% parameters
% user dependent parameters
M            = 15;                       % total number of antenna
N            = 10;                       % available number of antennas at a time
lambda       = 300;                      % wavelength of radio wave in m
d            = lambda/2;                 % inter-element spacing between two antennas
theta        = -90 : 90;                 % directions of interest in degree
thetahat     = [-50,0,50];             % special theta
deltheta     = 20;                       % selected beam pattern in degree
c            = 1;                        % power of the symbols
mutationBit  = 1;                        % how many bits of a child will be mutated
mutationProb = 1;                      % with how much probability
eigenMean    = 2;                        % needs to generate SPD matrices
cc           = 1;                        % choice of correlation term inclusion: 0 = no | 1 = yes
ampw         = 1;                       % amplitude of the beamforming weights in different angles
ampwc        = 1;                      % amplitude of the beamforming weights in different crosscorrelation angles

% optimization related parameters
alpha        = 1;                        % scaling parameter for desired beam pattern
iterOMax     = 10;
iterIMax     = 20;
gamma        = 0.1;                       % penalty for generalized formulation
verbose      = 0;                        % verbosity: 0 = no | 1 = yes
tol          = 1e-10;                    % tolerence for objective function
 
% secondary parameters
K            = length(theta);            % number of angles
Kbar         = length(thetahat);         % number of angles we are interested in
w            = ampw*ones(K,1);           % weights of k-th angle
wc           = ampwc;                    % weight of cross-correlation sidelobe
phi          = zeros(K,1);               % beam patterns
for k = 1:Kbar
    phi ( theta >= thetahat(k) - floor(deltheta/2) & theta <= floor(thetahat(k)) + deltheta/2 ) = 1;
end
 
%% parameters structures
params.cc       = cc;
params.c        = c;
params.M        = M;
params.N        = N;
params.w        = w;
params.wc       = wc;
params.K        = K;
params.Kbar     = Kbar;
params.phi      = phi;
params.theta    = theta;
params.thetahat = thetahat;
 
options.mutationBit  = mutationBit;
options.mutationProb = mutationProb;
options.iterIMax     = iterIMax;
options.verbose      = verbose;
 
%% initialization
m            = 0 : (M-1);
p            = zeros(M,1);
p(randperm(numel(p), N)) = 1;
% p            = randi([0 1], M, 1);
p            = ones(M,1);
pone         = randi([1], M, 1);
R            = generateSPDmatrix(M, eigenMean);
oldJ         = 0;
t            = 1;

%% functionals
aT    = @(th)       exp(1i*2*pi*m*d*sind(th)/lambda)';                     % steering vector at theta = th
P     = @(p,R,th)   p' * real(R .* conj(aT(th)*aT(th)')) * p;          % the beam-pattern
PP     = @(p,R,th)   p' * (R .* conj(aT(th)*aT(th)')) * p;          % the beam-pattern
f     = @(p,R,alpha)  J(p, R, alpha, params, aT) + gamma*(abs(sum(p) - N));  % beamforming quartic function
df    = @(p,R,alpha)  dJ(p, R, alpha, params, aT);                           % gradient of beamforming quartic function
 
%% loop begins here
disp(['init p = ' num2str(p')]);
obj(1) =  f(p,R,alpha);
tic

objj = [];
while t < iterOMax
    disp(['t: ' num2str(t)]);
 
    % optimize for R
    [R, alpha] = optimizeR(p, R, alpha, params, options, f);
    figure(1); imagesc(R); colorbar; title(['The covariance matrix in iteration: ' num2str(t)]); colormap gray;
    objj = [objj f(p,R,alpha)];
    
    % optimize for p
    p = pone; % [ones(N,1);zeros(M-N,1)]   % antenna selection vector reinitilization
    p = optimizep(p, R, alpha, params, options, f);
    disp(['best p = ' num2str(p')]);
    figure(2); plotP(P, p, R, alpha, params, t);
    objj = [objj f(p,R,alpha)];
    
    % endjob
    currJ = f(p,R,alpha);
    if (norm(oldJ - currJ) < tol)
%         break;
    end
    t = t+1;
    oldJ = currJ;
    obj(t) = currJ;
end
time = toc;

Nnew = sum(p);

%% plots
figure(1); imagesc(R); colorbar; title('The final covariance matrix'); colormap gray;
figure(2); plotP(P, p, R, alpha, params, 'Final');

disp(['optimum positions         : ' num2str(p')]);
disp(['optimum objective value   : ' num2str(f(p,R,alpha))]);
disp(['number of active antennas : ' num2str(Nnew) '/' num2str(M)]);
disp(['elapsed Time              : ' num2str(time) ' secs']);
figure(3); semilogy(1:t, obj); xlabel('Iterations'); ylabel('Objective values');
figure(4); plotCrossCorrelation(p,R,aT,params);
