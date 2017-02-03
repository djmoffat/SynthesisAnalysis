function y = norma(a)

% make Mono
if(size(a,2) > 1)
    x = sum(a,2)/size(a,2);
else
    x = a;
end

%normalise to full scale
y = x / max(abs(x));
end
