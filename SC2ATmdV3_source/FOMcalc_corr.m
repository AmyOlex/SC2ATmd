function [ fom_tcorr ] = FOMcalc_corr( clust_mat, data_mat, num_clust_orig)
%FOMCALC_CORR This functions calculates the correlation biased cFOM for a clustering algorithm.
%   This function takes in a matrix of cluster solutions, a matrix
%   of gene data in the same order as the cluster solutions, and the number of clusters.
%   It outputs the cFOM score for the cluster algorithm used.
%
%   USAGE:  >>[score] = FOMcalc_corr( cluster_solutions, data, 10 )
%   
%   Variable descriptions:
%       clust_mat:  Each column of this matrix represents a
%       clustering of all the data except that corresponding condition e.
%       For example if you have the data:
%                   2.1   3.2   4.7
%                   3.3   5.6   6.2
%                   3.3   3.3   3.8
%       and you take the first column out as condition e, a row clustering 
%       with 2 clusters may look like this:
%                       1
%                       2
%                       1
%       This would be your first column in the clust_mat matrix.
%
%       data_mat:  This is the data that is to be used for clustering and
%       calculating the cFOM score.  Columns are conditions, and rows are
%       features/gene profiles.
%
%       num_clust_orig:  the total number of clusters to use.
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
%       Last Revised:  4/10/07
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

sub_fomcorr = 0;            % This hold each condition e's FOM in turn
fom_corr = 0;              % This is the cumulative cfom score

% Make sure clust_mat and data_mat have the same dimensions
if size(clust_mat) ~= size(data_mat)
    error('clust_mat and data_mat do not have same dimensions')
end

% Loop through each condition e

for e=1:num_cols        % each column in clust_mat is a clustering solution without the corresponding condition e
    
    % Find the number of clusters for this condition e
    % With Kmeans one or more of the clusters may have been dropped.
    num_clust = unique(clust_mat(:,e));

    % Find the mean pair-wise correlations of condition e for each cluster
    % Create an array to store them
    e_avgcorrs = zeros(num_clust_orig, 1);
    
    for i=1:length(num_clust)       % for each cluster present make a separate matrix with each genes data in it from that cluster
        temp_avgcorr = 0;
        temp_size = 0;  %the number of genes in the cluster
        temp_matrix = [];
        for j=1:num_rows   % for each gene/row
            if clust_mat(j, e) == num_clust(i)  %If this genes cluster assignment in clust_mat equals the current cluster, then select it
                temp_size=temp_size+1;
                temp_matrix=[temp_matrix;data_mat(j,:)];  % add this gene to the temporary cluster matrix
            end
        end
        
        %calculate the average pair-wise correlations for all combinations
        %of (x,y) pairs where x,y are features/rows in the data matrix.
        if(temp_size == 1)
            e_avgcorrs(num_clust(i),1) = 0;
        else
            e_avgcorrs(num_clust(i),1) = FOMcorr(temp_matrix);
        end

    end %end for each cluster

    sub_fomcorr = mean(e_avgcorrs);
    
    fom_corr = fom_corr + sub_fomcorr;        % the total fom for this data is the sum
                                    % of each condition e fom.
end  % end for each condition e loop through conditions e

fom_tcorr = fom_corr;  