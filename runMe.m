function audio=runMe(L)

s = length(L);

if(~exist('audiolist.mat','file'))
    audio = cell(s,1);
    for i = 1:s
        
        audio{i}.sample = audioSample(strcat(L{i},'_samp'));
        audio{i}.anchor = audioSample(strcat(L{i},'_anch'));
        audio{i}.synth = audioSample(strcat(L{i},'_synth'));
        
        audio{i}.sample = getFeatures(audio{i}.sample);
        audio{i}.anchor = getFeatures(audio{i}.anchor);
        audio{i}.synth = getFeatures(audio{i}.synth);
    end
    
    save('audiolist.mat','audio','-v7.3');
else
    load('audiolist.mat')
end
for i = 1:s
    
    audio{i}.distance = distanceVector(audio{i});
    plotDistanceVector(audio{i})
    %     audio{i}.distanceVectors
    save('runme-29-3.mat')
    
end
end