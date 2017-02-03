function [y,ERBFreq] = ERBModel(x, fs)
% Parameters
% x = Input Signal
% fs = sample rate

numChannels = 32;
% if(nargin < 6)
%     NoiseSlowMoving = 1; % Define the noise variables to be slow moving
%     FAtaps = 10; % Filter taps on downsampling variable Fa
%     Btaps = 10; % Filter taps for all variables of filtered noise
% end



lowFreq = 50; % Taken from essentia documentation.
[fcoefs,ERBFreq] = MakeERBFilters(fs,numChannels,lowFreq);

xModel = ERBFilterBank(x, fcoefs);

y = xModel;





