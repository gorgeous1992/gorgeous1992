%% Computes the sandbar location 

% load the wave data and topography
%load('wavedata20160428_11am') % output is "wavedata", y = 950 m
load('topograpy_y956_042816_1118.mat') % output is "topo_y956", y = 956 m


xCoord = 50:12:950; xCoord = xCoord'; 
domain = [50, 950]; 
numPoint = length(xCoord); % 76
dx = (domain(2) - domain(1))/(numPoint - 1); % 12
hCoord = -topo_y956;

topo = topo_y956;

%% Main variables for sandbar location:
% topo is the topography profile 
% xCoord is the corresponding x values that go along with the topography
% plot(xCoord, topo)


%% Initialize an array for the derivative of topography, 
% note that the derivative array has 1 less entry than the topography
% array
topoDerivative = zeros(size(xCoord)-[1,0]);
topoDerivative(1) = (topo(2) - topo(1))/dx; %initial derivative from finite difference

for ii = 2:(length(xCoord)-1)
    topoDerivative(ii) = (topo(ii+1) - topo(ii-1))/(2*dx); % middle derivatives from central difference
end
topoDerivative(end) = (topo(end) - topo(length(xCoord)-1))/dx; % final derivative from finmite difference

peakXCoord = zeros(size(xCoord)); % make an array to store the locations of the peaks
peakIndices = zeros(size(xCoord));
for ii = 2:length(topoDerivative)
    if sign(topoDerivative(ii-1)) > sign(topoDerivative(ii)) 
        % if the sign switches from positive to negative,
        % we have a local max 
        peakXCoord(ii) = xCoord(ii); %
        peakIndices(ii) = ii;
    end
end
peakIndices = nonzeros(peakIndices);
peakXCoord = nonzeros(peakXCoord);
plot(xCoord, topo) % compare peakXcoord with picture
                   % note that peak Xcoord is slightly off
                   % since the derivative array is 1 entry shorter

