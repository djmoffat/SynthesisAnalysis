function y = euclidDist(x1, x2)

[k,l] = size(x1);
if(size(x2,1) ~= k && size(x2,2) ~= l)
    error('Input vectors must be the same dimension');
end

y = diag(pdist2(x1',x2')); 

% TODO: This will be quite inefficient, as entire pairwise comparison
% is occuring, however, only the diagonal matrix is required
% Refactor to only calculate euclidian dist. on diagonal matrix,
% not entire matrix for efficiency.

end


% % X = randn(100, 5);
% % Y = randn(25, 5);
% % D = pdist2(X,Y,'euclidean'); % euclidean distance
