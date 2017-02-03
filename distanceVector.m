classdef distanceVector
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        typeList
        distMatrix
        numSamples
    end % end properties
    
    methods
        function thisDistVector = distanceVector(audioCell) %Constructor class
            thisDistVector.typeList = fieldnames(audioCell);
            s = size(thisDistVector.typeList,1);
            for i = 1:s
                if(strcmp(thisDistVector.typeList{i}, 'distance'))
                    thisDistVector.typeList(i) = [];
                    s = s - 1;
                end
            end
            s = size(thisDistVector.typeList,1);
            thisDistVector.numSamples = s;
            s1 = ceil(s/2);
            thisDistVector.distMatrix = cell(s);
            for i = 1:s
                for ii = 1:s1
                    % Is it possible to fix these ranges, so that less
                    % diagonal comparisons need to be made?
                    if (i == ii)
                        thisDistVector.distMatrix{i,ii} = [];
                    else
                        x1 = audioCell.(thisDistVector.typeList{i}).momVect;
                        x2 = audioCell.(thisDistVector.typeList{ii}).momVect;
                        thisDistVector.distMatrix{i,ii} = euclidDist(x1, x2);
                        thisDistVector.distMatrix{ii,i} = thisDistVector.distMatrix{i,ii};
                    end
                end
            end
            
        end % end distanceVector function
        
        function plotDistanceVector(thisDistVector)
            s = size(thisDistVector.typeList,1);
            figure;
            title('Distance Measures');
            for i = 1:(s*s)
                subplot(s,s,i);
                t1 = ceil(i/3);
                t2 = mod(i,3) + (mod(i,3)==0)*3;
                t = strcat('Distances between ',thisDistVector.typeList(t1),' and ',thisDistVector.typeList(t2));
                title(t);
                bar(thisDistVector.distMatrix{i})
                saveas(gcf,strcat('dist/',t,'.fig'),'fig');
                saveas(gcf,strcat('dist/',t,'.pdf'),'pdf');

            end
        end % end plotDistanceVector
        

    end % end methods
    
end % end classdef

