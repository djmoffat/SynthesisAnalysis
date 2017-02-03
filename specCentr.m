function sc = specCentr(x,fs)
% Function written by DM

L = length(x);
NFFT = 2^nextpow2(L);
Y = fft(x,NFFT)/L;
f = fs/2*linspace(0,1,NFFT/2+1);
X = 2*abs(Y(1:NFFT/2+1)); % Ref: Matlab Documentation for FFT
sc = sum(f.*X)/sum(X); %Ref: https://en.wikipedia.org/wiki/Spectral_centroid
end