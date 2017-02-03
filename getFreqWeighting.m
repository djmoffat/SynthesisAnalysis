function weight = getFreqWeighting(cFreq)
% weight = eye(length(cFreq));

f = cFreq;
A = (12200^2 * f.^4) ./ ((f.^2+206^2).*sqrt((f.^2+107.7^2).*(f.^2+737.9^2)).*(f.^2+12200^2));
weight = diag(A);

end
