function [fcoefs,cf]=MakeERBFilters(fs,numChannels,lowFreq)

% This function computes the filter coefficients for a bank of 
% Gammatone filters.   
% 
% The result is returned as an array of filter coefficients.  Each row 
% of the filter arrays contains the coefficients for four second order 
% filters.  The transfer function for these four filters share the same
% denominator (poles) but have different numerators (zeros).  All of these
% coefficients are assembled into one vector that the ERBFilterBank 
% can take apart to implement the filter.
%
% The filter bank contains "numChannels" channels that extend from
% half the sampling rate (fs) to "lowFreq".


T = 1/fs;
if length(numChannels) == 1
	cf = ERBScale(lowFreq, fs/2, numChannels);
else
	cf = numChannels(1:end);
	if size(cf,2) > size(cf,1)
		cf = cf';
	end
end

%  Glasberg and Moore Parameters in ERB scale
EarQ = 9.26449;				
minBW = 24.7;
order = 1;

ERB = ((cf/EarQ).^order + minBW^order).^(1/order);
B=1.019*2*pi*ERB;

A0 = T;
A2 = 0;
B0 = 1;
B1 = -2*cos(2*cf*pi*T)./exp(B*T);
B2 = exp(-2*B*T);

A11 = -(2*T*cos(2*cf*pi*T)./exp(B*T) + 2*sqrt(3+2^1.5)*T*sin(2*cf*pi*T)./ ...
		exp(B*T))/2;
A12 = -(2*T*cos(2*cf*pi*T)./exp(B*T) - 2*sqrt(3+2^1.5)*T*sin(2*cf*pi*T)./ ...
		exp(B*T))/2;
A13 = -(2*T*cos(2*cf*pi*T)./exp(B*T) + 2*sqrt(3-2^1.5)*T*sin(2*cf*pi*T)./ ...
		exp(B*T))/2;
A14 = -(2*T*cos(2*cf*pi*T)./exp(B*T) - 2*sqrt(3-2^1.5)*T*sin(2*cf*pi*T)./ ...
		exp(B*T))/2;

%Normalize each filter's gain so it is one at the center frequency
gain = abs((-2*exp(4*1i*cf*pi*T)*T + ...
                 2*exp(-(B*T) + 2*1i*cf*pi*T).*T.* ...
                         (cos(2*cf*pi*T) - sqrt(3 - 2^(3/2))* ...
                          sin(2*cf*pi*T))) .* ...
           (-2*exp(4*1i*cf*pi*T)*T + ...
             2*exp(-(B*T) + 2*1i*cf*pi*T).*T.* ...
              (cos(2*cf*pi*T) + sqrt(3 - 2^(3/2)) * ...
               sin(2*cf*pi*T))).* ...
           (-2*exp(4*1i*cf*pi*T)*T + ...
             2*exp(-(B*T) + 2*1i*cf*pi*T).*T.* ...
              (cos(2*cf*pi*T) - ...
               sqrt(3 + 2^(3/2))*sin(2*cf*pi*T))) .* ...
           (-2*exp(4*1i*cf*pi*T)*T + 2*exp(-(B*T) + 2*1i*cf*pi*T).*T.* ...
           (cos(2*cf*pi*T) + sqrt(3 + 2^(3/2))*sin(2*cf*pi*T))) ./ ...
          (-2 ./ exp(2*B*T) - 2*exp(4*1i*cf*pi*T) +  ...
           2*(1 + exp(4*1i*cf*pi*T))./exp(B*T)).^4);

allfilts = ones(length(cf),1);
fcoefs = [A0*allfilts A11 A12 A13 A14 A2*allfilts B0*allfilts B1 B2 gain];

