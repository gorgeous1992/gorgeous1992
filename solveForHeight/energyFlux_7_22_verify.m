%% Wave-energy model verification code for d/dx (E*C_g) = -delta
% To verify the model, we apriori choose H, h, and sigma;
% since d/dx (E*C_g) + delta = err, where err is some error.
% We obtain an analytical formula for err by determining
% d/dx (E*C_g) + delta (by using Mathematica or pencil/paper).
% Then, we solve the differential equation d/dx (E*C_g) = -delta + err,
% where the delta and err depend on our apriori chosen values of H, h,
% and sigma. 
% 7/2/2017 9:38 AM

%% Loop indices
start = 3; jump = 8;

%% Initial arrays for testing
errorArray = zeros(jump, 1);
dxArray = zeros(jump, 1);
numPointArray = zeros(jump, 1);

for kk = start:(start + jump)
    
    %% Set up the "mesh"
    domain = [0,10];
    numPoint = 2^kk;
    numPointArray(kk - start + 1) = numPoint;
    x = linspace(domain(1), domain(2), numPoint);
    dx = (domain(2) - domain(1))/(numPoint - 1);
    dxArray(kk - start + 1) = dx;
    
    %% Physical parameters
    rho = 1000; % water density
    g = 9.8;    % gravity 
    gam = .78;  % ?
    rms = .707; % root-mean square constant
    B = 1;      % energy dissipation parameter
    
    
    %% Apriori choices for h, H, and sigma:
    h = @(x) 50 - x;
    h = h(x);
    h_prime = @(x) -1*ones(size(x));
    h_prime = h_prime(x);
    sigma = @(x) 2*ones(size(x));
    sigma = sigma(x); f = sigma/(2*pi);
    Ha = @(x) cos(x) + 5; % Ha = "analytical height"
    Ha = Ha(x);
    Ha_prime = @(x) -sin(x);
    Ha_prime = Ha_prime(x);
    
    
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
    
    %% Energy flux, F = E*C_g
    F = zeros(size(x));
    F(1) = E(1)*C_g(1); % boundary condition
    
    %% -------------------------------------------------------------------
    %% The analytical formulae (plural) for d/dx (E*C_g) from Mathematica
    % using shallow water approximation for wavenumber:
    theta1 = 2*sigma.*sqrt(h)/sqrt(g);
    shallowFluxDerivative = (1/16)*rho*g^(3/2)*(rms)^2*(Ha.^2.*(2.*sigma.*csch(theta1).* ...
        h_prime/sqrt(g) + h_prime./(2*sqrt(h)) - 2*sigma.^2.*coth(theta1).* ...
        csch(theta1).*sqrt(h).*h_prime/g) + 2*(sqrt(h) + 2*sigma.*csch(theta1).*h/sqrt(g)).* ...
        Ha.*Ha_prime);
    % using the deep water approximation for wavenumber:
    theta2 = 2*h.*sigma.^2/g;
    deepFluxDerivative = (1/16)*rho*g^2./sigma.*(rms)^2.*(Ha.^2.* (2*sigma.^2.*csch(theta2).*h_prime/g - ...
        4*sigma.^4.*coth(theta2).*csch(theta2).*h.*h_prime/(g^2) ) + 2*(1 + 2*sigma.^2.*csch(theta2).*h/g).* ...
        Ha.*Ha_prime);
    
    %% Analytical formula for delta
    Ha_rms = rms*Ha;
    Ra = H_b./Ha_rms;
    deltaAnalytic = (1./(4.*h)).*B.*rho.*g.*(sigma./(2.*pi)).*Ha_rms.^3.*( (Ra.^3 + 1.5.*Ra).*exp(-Ra.^2) + 0.75.*sqrt(pi).*(1 - erf(Ra)));

    %% Analytical "err" formula, d/dx(flux) + delta = err
    shallowError = shallowFluxDerivative + deltaAnalytic;
    deepError = deepFluxDerivative + deltaAnalytic;
    %% -------------------------------------------------------------------
    
    %% Solve the ODE via finite differences
    for ii = 2:length(x)
        F(ii) = -delta(ii - 1)*dx + F(ii - 1); % finite difference formula
                                               % to compute new flux
                                               
        % determine which regime we are in, then add the approriate error
        if h < 0.05*2*pi./k(ii) % shallow
            F(ii) = F(ii) + dx*shallowError(ii);
        elseif h > 0.5*2*pi./k(ii) % deep
            F(ii) = F(ii) + dx*deepError(ii);
        else % default to deep?...
            F(ii) = F(ii) + dx*deepError(ii);
        end
        
        E(ii) = F(ii)./C_g(ii); % compute new energy from flux
        H(ii) = sqrt(8./(rho*g)*E(ii))/rms; % compute height from energy
        H_rms(ii) = rms*H(ii); 
        delta(ii) = 1/(4*h(ii))*B*rho*g*f(ii)*H_rms(ii)^3*(R(ii)^3 + (3/2)*R(ii))*exp(-R(ii)^2) + ...
            (3/4)*sqrt(pi)*(1 - erf(R(ii))); % compute new delta
    end
    
    %% post processing
    error = norm(H - Ha); % difference between computed and true solution
    errorArray(kk - start + 1) = error;
 
end
    
%% create a log-log plot
figure(), loglog(dxArray, errorArray), title('log-log plot of error against spacing')
axis equal, xlabel('log(dx)'), ylabel('log(norm(abs(H - H_a)))')

%% determine the slope of the log-log graph 
% this should match with the theoretical order of convergence
order = (log(errorArray(jump)) - log(errorArray(1)))/(log(dxArray(jump)) - log(dxArray(1)))



    
    
    
    
    

