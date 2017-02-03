function moments = getSignalMoments(inputSignal,numMoments)

if(numMoments < 1)
    warning('numMoments must be positive integer, 1 moment assumed');
    numMoments = 1;
end
% s = size(inputSignal,1);
moments = zeros(size(inputSignal,1),numMoments);

moments(:,1) = mean(inputSignal,2);
if(numMoments > 1)
    for i = 2:numMoments
        moments(:,i) = moment(inputSignal,i,2);
    end
end
end