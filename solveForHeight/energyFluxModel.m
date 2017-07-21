%% 1D Energy Flux Differential Equation Problem Description:
% Find H = H(x) such that
% d/dx (E*C_g) = - delta
% where 
% E = (1/8)*rho*g*H_{rms}^2,
% C_g = (c/2)*(1 + 2*k*h/sinh(2*k*h)),
% H_{rms} = 0.707*H,
% delta = (kappa/d)*(E*C_g - E*C_{g,s}) from slides, or from Apotsos et al
% 2008 and Janssen and Battjes 2007:
%   delta = 1/4h * B*rho*g*f*H_{rms}^3 *(R^3 + 3/2 * R)*exp(-R^2) + ...
%   3/4*sqrt(pi)*(1 - erf(R)),
% where H_b = 0.78*h, R = H_b/H_{rms}, H_b = gamma*h,
% and B is an order 1 parameter which controls the energy dissipation,
% and gamma is a parameter which is interdependent on B. In 
% Apostsos et al, they set B = 1, and vary gamma.
% -------------------------------------------------------------------------

%% Parameters/variables:
load('democBathy1')
h = bathy.fCombined.h; % input from data
sigma = bathy.fDependent.fB(:,:,1); % input from data (chosen arbitrarily),
                                    % might need to combine fB values
g = -9.81; % gravity, 9.8 m/s^2
k = bathy.fDependent.k(:,:,1); % initial guess for k for newton-solve
DispFun = @(k) sigma.^2 - g*k.*tanh(h.*k); % anonymous function
k = fsolve(DispFun, k);
%k = fsolve(dispersionRelation, k);
%k = fsolve(sigma.^2 - g*k.*tanh(h.*k), k);
%k = sigma./(g*h); % initial guess for k

rho = 1000; % water density, kg/m^3

% Finding k associated with sigma:
%numIterations = 1000; %tolerance = 10e-1;
%for ii = 1:numIterations
%    k = k - (g*k.*tanh(k.*h) - sigma.^2)./(g*tanh(k.*h) - g*h.*k.*sech(k.*h).^2);
    %if (abs(sigma.^2 - g*k.*tanh(k.*h)) < tolerance)
    %    break
    %end
%end

c = sigma./k; % local wave phase speed
%Cg = (c/2)*(1 + (2*k.*h)./(sinh(2*k.*h));

%% d/dx (E*C_g) = -delta
% d/dx (E*C_g) = E'*C_g + E*C_g' 
% E' = (E_i - E_{i-1})/(deltax)
% (E_{i+1} - E_i)/(deltax)*C_g + E_i*C_g' = - delta
% E_{i+1} = -E_i * C_g' * deltax - delta*deltax + E_i*C_g

%% Mesh Spacing:
domain = [0,10]; deltax = 1; x = domain(1):deltax:domain(2);

%% Initialize solution: 
E = zeros(size(x));

%% Initial Depth:
%h = h;

%% Wave Period/Frequency:
%sigma = sigma;

%% Boundary/Initial Condition:
H0 = 1; % arbitrarily chosen wave height
H0_rms = 0.707*H0;
E(1) = (1/8)*rho*g*H0_rms^2;
%E(1) = 1; 

%% Compute Cg_{i-1} 
C_g = (c/2)*(1 + (2*k.*h)./(sin(2*k.*h)));


%% Estimate wave number k:
k = k - (g*k.*tanh(k.*h) - sigma.^2)./(g*tanh(k.*h) - g*h.*k.*sech(k.*h).^2);

%% Compute wave breaking function delta:
%delta = 

%E = -E*Cg_prime*deltax - delta*deltax + E*Cg;

H  = sqrt(8*E/(p*g))/(.707);
%H_rms = 0.707*H;
%(1/8)*rho*g*
