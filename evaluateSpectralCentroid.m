function sc = evaluateSpectralCentroid(x,fs)

type = 'hann';
L = 128;        %2.5ms
hop = 0.5;      % 50% = 1.25ms

ws=winSignal(x,L,hop,type);
[s,~]=size(ws);
sc = zeros(s,1);

for i = 1:s
    sc(i) = specCentr(ws(i,:),fs); 
    if(isnan(sc(i)))
        sc(i) = 0;
    end
end


end