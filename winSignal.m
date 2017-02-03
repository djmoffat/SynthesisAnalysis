function ws=winSignal(x,L,hop,type)

if nargin < 3
    type = 'sq';
end

switch type
    case 'sq'
        w = ones(L,1);
    case 'hann'
        w = hann(L);
    case 'hamm'
        w = hamming(L);
    case 'blackman'
        w = blackman(L);
    case 'cheb3';
        w = chebwin(L,3);
    case 'cheb6';
        w = chebwin(L,6);
    case 'cheb12';
        w = chebwin(L,12);
    case 'cheb100';
        w = chebwin(L,100);
    case 'gaus';
        w = gausswin(L);
        
    otherwise
        error('Invalid Window Choice');
end

if hop <= 1
    hop = floor(hop*L);
end

Q = ceil(length(x)/hop);
ws = zeros(Q,L);
lenDif = (Q*hop+L-1) - length(x);
if(lenDif > 0)
    x = cat(2,x,zeros(1,abs(lenDif)));
end

for i = 1:Q
    ws(i,:) = w' .* x(i*hop:i*hop+L-1);
end
end