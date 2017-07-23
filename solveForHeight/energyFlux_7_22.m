%% Wave-energy model code for d/dx (E*C_g) = -delta
% big question: do we need to include the analytical formula
% for err to accurately compute H from data?
% 7/2/2017 8:58 AM

%% Set up the "mesh"
domain = [0,10];
numPoint = 20;
numPointArray(kk - start + 1) = numPoint;
x = linspace(domain(1), domain(2), numPoint); % normally get x from data
dx = (domain(2) - domain(1))/(numPoint - 1);
dxArray(kk - start + 1) = dx;

%% Parameters
rho = 1000; % water density
g = 9.8;    % gravity
gam = .78;  % ?
rms = .707; % root-mean square constant
B = 1;      % energy dissipation parameter

%% Height data (normally get from real data)
h = @(x) 30 - x;
h = h(x);

%% Frequency data (normally get from real data)
sigma = @(x) 2*ones(size(x));
sigma = sigma(x);
f = sigma/(2*pi);

%% Solving for wavenumber via the "linear" dispersion relation
dispersionRelation = @(k) sigma.^2 - g.*k.*tanh(k.*h);
k = ones(size(x)); % random initial guess for iterative solver
k = fsolve(dispersionRelation, k);

%% Off-shore boundary conditions
H = zeros(size(x)); E = zeros(size(x)); H_rms = zeros(size(x));
H(1) = 6; % offshore wave height determines H_rms(1) and E(1)
H_rms(1) = rms*H(1);
E(1) = (1/8)*rho*g*H_rms(1).^2;
R = zeros(size(x)); delta = zeros(size(x));
H_b = gam*h;
R(1) = H_b(1)/H_rms(1);

%% Group Celerity
c = sigma./k;
C_g = (c/2).*(1 + (2*k.*h)/(sinh(2*k.*h)));

%% Computing energy flux
F = zeros(size(x));
F(1) = E(1)*C_g(1);

%% Solve the ODE via finite differences
for ii = 2:length(x)
    F(ii) = -delta(ii - 1)*dx + F(ii - 1); % finite difference formula
    E(ii) = F(ii)./C_g(ii); % recompute energy from flux
    H(ii) = sqrt(8./(rho*g)*E(ii))/rms; % compute height from energy
    H_rms(ii) = rms*H(ii);
    delta(ii) = 1/(4*h(ii))*B*rho*g*f(ii)*H_rms(ii)^3*(R(ii)^3 + (3/2)*R(ii))*exp(-R(ii)^2) + ...
        (3/4)*sqrt(pi)*(1 - erf(R(ii)));
end

%% post process
figure(), plot(x, H), title('Waveheight H')
xlabel('x (meters)'), ylabel('H (meters)')
% can also plot energy, 








