%% Mesh:
load('democBathy1')
domain = [xm(1),xm(end)]; %dx = 0.1; x = domain(1):dx:domain(2);
gridResolution = 30;
x = linspace(domain(1), domain(2), gridResolution);
E = zeros(size(x)); H = zeros(size(x));

%% Parameters:
rho = 1000; g = 9.81; 

%% Off-shore boundary:
H(1) = 1; H_rms(1) = 0.707*H(1);
E(1) = (1/8)*rho*g*H_rms(1).^2;

%% height:
h = zeros(size(x));
h = bathy.fCombined.h;

%% sigma:
f = zeros(size(x));
f = bathy.fDependent.fB(:,:,1);
sigma = zeros(size(x));
sigma = f/(2*pi); 

%% k:
dispRel = @(k) sigma.^2 - g.*k.*tanh(k.*h); 
k = bathy.fDependent.k(:,:,1);     % initial guess
k = fsolve(dispRel, k); % the k values which satisfy the dispersion relationship
                        % for each sigma and each h
residual = abs(sigma.^2 - g.*k.*tanh(k.*h));

%% initial delta: 
B = 1; % energy dissipation parameter
R = zeros(size(x)); H_b = zeros(size(x)); delta = zeros(size(x));
H_b = 0.78*h; % H_b(1) = 0.78*h(1);
R(1) = H_b(1)/H_rms(1);
delta(1) = 1/(4*h(1))*B*rho*g*f(1)*H_rms(1)^3*(R(1)^3 + (3/2)*R(1))*exp(-R(1)^2) + ...
    (3/4)*sqrt(pi)*(1 - erf(R(1)));

%% C_g:
C_g = zeros(size(x)); 
c = zeros(size(x));
c = sigma./k;
C_g = (c/2).*(1 + (2*k.*h)/(sinh(2*k.*h)));

%% solve the problem:
for ii = 2:length(x)
    E(ii) = delta(ii - 1)*dx/C_g(ii)+ E(ii-1)*C_g(ii - 1)/C_g(ii);
    H(ii) = sqrt(8./(rho*g)*E(ii))/(0.707);
    H_rms(ii) = 0.707*H(ii);
    R(ii) = H_b(ii)/H_rms(ii);
    delta(ii) = 1/(4*h(ii))*B*rho*g*f(ii)*H_rms(ii)^3*(R(ii)^3 + (3/2)*R(ii))*exp(-R(ii)^2) + ...
    (3/4)*sqrt(pi)*(1 - erf(R(ii)));
end

%H = sqrt(8./(rho*g)*E)/(0.707);
plot(x, H)
axis([0 10 -1 4])




