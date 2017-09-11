function [outargs] = ClusterStats( clustering, data_mat, num_clust, filename, selections)
%CLUSTERSTATS calculates eight different statistics associated with each cluster, and writes them to a file.
%   
%   Usage: ClusterStats( clusters, data, 10, 'myfile.txt', [1,1,1,1,1,1,1,1]);
% 
%   Variable Descriptions:
%     clustering - a column array with cluster assignments for each element
%     data_mat - a nxm matrix containing m data points for each of the n elements.
%     num_clust - the total number of clusters the data is broken down
%       into.
%     filename - the name and extension to write the results to.
%     selections - a boolean vector indicating which stats are to be
%       calculated where 1 = yes and 0 = no.  Enter a vector with eight 
%       1's to calculate all stats or a combination of 0's and 1' for 
%       selected stats.  The order of elements is:  
%       [AvgExpVec, StdDevVec, StdErrVec, #upVec, #downVec, #zeroVec, AvgEuclid, #genes]
%
%   Author:  Amy Olex
%
%
%   ************
%   Copyright (C) 2007 Amy Olex
%   
%   This file is part of SC2ATmd.
%
%   SC2ATmd is free software: you can redistribute it and/or modify
%   it under the terms of the GNU General Public License as published by
%   the Free Software Foundation, either version 3 of the License, or
%   (at your option) any later version.
%
%   SC2ATmd is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU General Public License for more details.
%
%   You should have received a copy of the GNU General Public License
%   along with SC2ATmd.  If not, see <http://www.gnu.org/licenses/>.
%   ************


% Create needed variables

tmp = size(data_mat);   % needed to get number of rows and columns
num_rows = tmp(1,1);    % the number of genes
num_cols = tmp(1,2);    % the number of time series
    % Calculate the average expression vector for each cluster and write it
    % to a file
avgVecs = zeros(num_clust, num_cols);
stdVecs = zeros(num_clust, num_cols);
errVecs = zeros(num_clust, num_cols);
upcountVecs = zeros(num_clust, num_cols);
downcountVecs = zeros(num_clust, num_cols);
zercountVecs = zeros(num_clust, num_cols);

AvgEuclid = 0;
numclusterGenes = 0;


fid=fopen(filename, 'w');

% before we begin each cluster, output the global file stats
% Total number of clusters, Number of Singltons, Average cluster size
% excluding singletons, Largest cluster, Smallest Cluster

clusterSizes = histc(clustering, unique(clustering));
TotClusts = length(unique(clustering));
numSingletons = count(clusterSizes, '==1');
avgSize = round((sum(clusterSizes)-numSingletons)/(TotClusts-numSingletons));
largestClust = max(clusterSizes);
smallestClust = min(clusterSizes(1:TotClusts-numSingletons));

fprintf(fid, 'General Cluster Information\n');
fprintf(fid, 'Total number of clusters: %d\n', TotClusts);
fprintf(fid, 'Total number of singleton clusters: %d\n', numSingletons);
fprintf(fid, 'Average cluster size (excluding singletons): %d\n', avgSize);
fprintf(fid, 'Largest cluster size: %d genes\n', largestClust);
fprintf(fid, 'Smallest cluster size: %d genes\n', smallestClust);


    
    for i=1:num_clust       % for each cluster present
        temp_mat = [];
        for j=1:num_rows   % for each gene/row
            %create a temporary matrix to store all genes in cluster i
            if clustering(j) == i
                temp_mat = [temp_mat;data_mat(j,:)];
            end
        end
        
        % now calculate all per column vector stats for all clusters with
        % more than 1 gene in them.
      % [AvgExpVec, StdDevVec, StdErrVec, #upVec, #downVec, #zeroVec, AvgEuclid, #genes]
        
        if ~isempty(temp_mat) && length(temp_mat(:,1)) > 1
           
            for c=1:num_cols  %for each column

                if(selections(1))  % calculate the average expression profile for cluster
                    avgVecs(i,c) = mean(temp_mat(:,c));
                end

                if(selections(2) || selections(3))
                    stddev=std(temp_mat(:,c));
                end
                if(selections(2)) % calc the stdDevs for each average value
                    stdVecs(i,c) = stddev;
                end
                if(selections(3)) % calc the stdErrs for each average value
                    errVecs(i,c) = stddev/sqrt(length(temp_mat(:,1)));
                end

                if(selections(4)) % count the number of genes with expression >0
                    upcountVecs(i,c) = count(temp_mat(:,c),'>0');
                    downcountVecs(i,c) = count(temp_mat(:,c),'<0');
                    zerocountVecs(i,c) = count(temp_mat(:,c),'==0');
                end

            end %end for each column in temp_mat


            % write everything for this cluster to the file   

            fprintf(fid, '\n\n------------------------------\nCluster %d:', i);

            if(selections(5)) % the average Euclidean cluster score
               AvgEuclid = mean(pdist(temp_mat));
               fprintf(fid, '\nAverage Euclidean Distance Score:\t%5.2f', AvgEuclid);
            end

            if(selections(6)) % the number of genes in cluster
                numclusterGenes = length(temp_mat(:,1));
                fprintf(fid, '\nNumber of genes in cluster:\t%d', numclusterGenes);
            end


            if(selections(1))
                fprintf(fid,'\nAverage Expression Profile:\t', i);
                for n=1:num_cols
                    fprintf(fid,'%5.2f\t', avgVecs(i,n));
                end 
            end
            if(selections(2))
                fprintf(fid,'\nStandard Deviations:\t', i);
                for n=1:num_cols
                    fprintf(fid,'%5.2f\t', stdVecs(i,n));
                end 
            end
            if(selections(3))   
                fprintf(fid,'\nStandard Errors:\t', i);
                for n=1:num_cols
                    fprintf(fid,'%5.2f\t', errVecs(i,n));
                end 
            end
            if(selections(4))   
                fprintf(fid,'\nCount of positive expressions:\t', i);
                for n=1:num_cols
                    fprintf(fid,'%d\t', upcountVecs(i,n));
                end 

                fprintf(fid,'\nCount of negative expressions:\t', i);
                for n=1:num_cols
                    fprintf(fid,'%d\t', downcountVecs(i,n));
                end 

                fprintf(fid,'\nCount of zero expression:\t', i);
                for n=1:num_cols
                    fprintf(fid,'%d\t', zerocountVecs(i,n));
                end 
            end
            
        end % end if more than 1 gene in cluster

        
        
    end % end for each cluster

fclose(fid);

outargs{1} = avgVecs;
outargs{2} = stdVecs;
outargs{3} = errVecs;
outargs{4} = upcountVecs;
outargs{5} = downcountVecs;
outargs{6} = zercountVecs;
outargs{7} = AvgEuclid;
outargs{8} = numclusterGenes;
        
        
        
        
        