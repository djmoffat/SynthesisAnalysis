function cfArray = ERBScale(lowFreq, highFreq, N)

% This function computes an array of N frequencies uniformly spaced between
% highFreq and lowFreq on an ERB scale.  N is set to 100 if not specified.


% if nargin < 1
% 	lowFreq = 100;
% end
% 
% if nargin < 2
% 	highFreq = 44100/4;
% end
% 
% if nargin < 3
% 	N = 100;
% end

%  Glasberg and Moore Parameters
EarQ = 9.26449;				
minBW = 24.7;
order = 1;

cfArray = -(EarQ*minBW) + exp((1:N)'*(-log(highFreq + EarQ*minBW) + ...
		log(lowFreq + EarQ*minBW))/N) * (highFreq + EarQ*minBW);

