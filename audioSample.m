classdef audioSample
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        debug = 1
        filename
        x
        fs
        numBands = 32
        type
        rating
        env
        demod
        ddmod
        demodSC
        demoddSC
        distScale
        ERBFreqC
%         autoEnv
%         autoCar
        momentName
        momentLegend
        moments
        momVect
    end
%     properties (Dependent)
%         lag
%     end
    
    methods
        function thisAudioSample = audioSample(filename) %Constructor class
            thisAudioSample.filename = ['audio/',filename,'.wav'];
            if(~exist(thisAudioSample.filename,'file'))
               error(['File ', filename, ' does not exist']); 
            end
            [thisAudioSample.x,thisAudioSample.fs] = audioread(thisAudioSample.filename);
            thisAudioSample.x = norma(thisAudioSample.x);
            if(strfind(filename,'anch'))
                thisAudioSample.type = 'Anchor';
                thisAudioSample.rating = 'Anchor';

            elseif(strfind(filename,'synth'))
                thisAudioSample.type = 'Synthesis';
            elseif(strfind(filename,'samp'))
                thisAudioSample.type = 'Sample';
            else
                warning('Sound Class Type could not be identified');
            end
        end

        function thisAudioSample = getFeatures(thisAudioSample)
            if(thisAudioSample.debug)
                disp(['Calculating Features for ',thisAudioSample.filename]);
            end
            [yModel,thisAudioSample.ERBFreqC] = ERBModel(thisAudioSample.x, thisAudioSample.fs);
            modelSize = size(yModel);
            thisAudioSample.env = zeros(modelSize );
            thisAudioSample.demod = zeros(modelSize );
            thisAudioSample.ddmod = zeros(modelSize );
            thisAudioSample.distScale = getFreqWeighting(thisAudioSample.ERBFreqC);
            for i = 1:thisAudioSample.numBands
                y = hilbert(yModel(i,:));
                
                thisAudioSample.env(i,:) = abs(y);
                thisAudioSample.demod(i,:) = yModel(i,:) ./ thisAudioSample.env(i,:);
                thisAudioSample.env(i,:) = thisAudioSample.env(i,:) / max(thisAudioSample.env(i,:));

                thisAudioSample.ddmod(i,:) = deriv(thisAudioSample.demod(i,:)) / 2;
                thisAudioSample.demodSC(i,:) = evaluateSpectralCentroid(thisAudioSample.demod(i,:),thisAudioSample.fs) / 20000;
                thisAudioSample.demoddSC(i,:) = deriv(thisAudioSample.demodSC(i,:));
            end
            
            thisAudioSample = getMoments(thisAudioSample);
        end
        
        function thisAudioSample = getMoments(thisAudioSample, numMoments)
            if(nargin < 2)
                numMoments = 4;
            end
            
            thisAudioSample.momentName = {'Demodulated Signal','Demodulated Signal Spectral Centroid','Demodulated Signal Spectral Centroid Derivative', 'Demodulated Signal Derivative','Envelope'};
            thisAudioSample.momentLegend = {'Mean','Variance','Skew','Kurtosis'};
            thisAudioSample.moments(:,:,1) = getSignalMoments(thisAudioSample.demod,numMoments);
            thisAudioSample.moments(:,:,2) = getSignalMoments(thisAudioSample.demodSC,numMoments);
            thisAudioSample.moments(:,:,3) = getSignalMoments(thisAudioSample.demoddSC,numMoments);
            thisAudioSample.moments(:,:,4) = getSignalMoments(thisAudioSample.ddmod,numMoments);
            thisAudioSample.moments(:,:,5) = getSignalMoments(thisAudioSample.env,numMoments); 
            thisAudioSample.momVect = reshape(thisAudioSample.moments,32,20);

        end
        
%         function thisSample = getFeatures(thisSample)
%             
%         end
        
    end
    
end

