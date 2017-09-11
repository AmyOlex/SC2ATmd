function [ fom_t ] = FOM2_adj( clust_mat, data_mat, num_clust_orig)
%FOM2_adj Calculates the adjusted 2-norm Figure of Merit for a clustering algorithm.
%   
%
%   This function takes in a matrix of clustering solutions, a matrix
%   of gene expression measurements in the same order as the cluster solutions,
%   and the number of clusters.  It outputs the adjusted FOM score for the cluster algorithm used.
%
%   Usage:  [score] = FOM2_adj( cluster_solutions, data, #_of_clusters )
%   
%   Variable description:
%       clust_mat:  This is a nxm matrix where n is the number of genes/rows
%       and m is the number of experiemental conditions/columns. Each column 
%       of this matrix represents a clustering solution of all the data 
%       except that corresponding condition e.
%       For example if you have the data:
%                   2.1   3.2   4.7
%                   3.3   5.6   6.2
%                   3.3   3.3   3.8
%       and you take the first column out as condition e, a row clustering 
%       with 2 clusters may look like this:
%                       1
%                       2
%                       1
%       This would be your first column in the cluster_mat matrix.
%       Therefore, each clustering solution in column i of cluster_mat was
%       generated without condition i of the data_mat matrix.
%
%       data_mat:  This a nxm matrix where n is the number of genes/rows,
%       and m is the number of experimental conditions/columns.  This
%       matrix contains all the data values/measurements for each gene.
%       This is the data that was clustered.
%
%       num_clust_orig:  this is just the number of clusters that was used
%       to generate the clust_mat matrix of clustering solutions.
%       
%
%
%
%
%   Acknowledgments:
%       Code Author:    Amy Olex
%       Figure Of Merit Scores: Mathematical scoring methods from the 
%           following Technical Report which became a published paper:
%           Yeung,KY; Haynor,DR; and Ruzzo,WL (2001) "Validating
%           Clustering for Gene Expression Data". Bioinformatics, Vol.17 No.4,
%           309-318.
%           Note:  The published paper does not have the FOM Range or Ratio
%           scoreing in it, that came from the techincal report which can
%           be found at http://faculty.washington.edu/kayee/cluster/
%       
%       Last Revised:  3/21/2007
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

tmp = size(data_mat);   % needed to get number of rows and columns in the data matrix
num_rows = tmp(1,1);    % the number of genes/rows
num_cols = tmp(1,2);    % the number of conditions/columns

sub_fom = 0;            % This hold each condition e's FOM score in turn
fom_a = 0;              % This is the cumulative fom score of all the sub_fom's

% Make sure clust_mat and data_mat have the same dimensions
if size(clust_mat) ~= size(data_mat)
    error('clust_mat and data_mat do not have same dimensions')
end

% Loop through each condition/column e
for e=1:num_cols
    
    % Find the number of clusters for this condition e
    % With k-means one or more of the clusters may have been dropped.
    % Matlab's unique() function lists all the unique entries in a vector.
    num_clust = unique(clust_mat(:,e));
   
    temp_fom=0; % this is a temporary variable that holds the summation part of the fom score for each number of clusters

    %loop through each cluster and find the average of the squared
    %distances from the mean of that cluster
    for i=1:length(num_clust)       % for each cluster present       
        
        temp_clust_mat=[];  % to hold all values for this cluster
        
        % now extract all values for this cluster i
        for j=1:num_rows   % for each gene/row of the entire data matrix
            % if the cluster assignemnt for gene j under condition e
            % matches the cluster we are working with, then add this data
            % value from the data_mat to our temporary vector
            if clust_mat(j, e) == num_clust(i)   
                temp_clust_mat=[temp_clust_mat, data_mat(j,e)];
            end
        end
        % calculate the mean of this cluster for condition e
        temp_mean = mean(temp_clust_mat);

        % after mean for this cluster i is found, start to calculate the
        % summation in the fom equation.

            %calculate the fom score for this cluster, and increment temp_fom
            temp_fom = temp_fom + sum((temp_clust_mat - temp_mean).^2);  
            
    end %end for each cluster

    sub_fom = sqrt((1/num_rows)*temp_fom);  % complete calculations of the fom score for this condition
    
    fom_a = fom_a + sub_fom;        % the total fom for this data is the sum
                                    % of each condition e fom.
end  % end loop through conditions e

%Adjusted score
fom_t = fom_a/sqrt((num_rows-length(num_clust))/num_rows);  % calculate the adjusted FOM score.

        
        
        
        
        
        