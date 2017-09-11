function [fom_a2] = FOM2_hierarch( num_clust, data_mat, dis_metric )
%FOM2_HIERARCH Returns the 2-norm FOM calculation for hierarchical
%clustering.
%   
%   This algorithm removes each condition e in turn, then clusters the data 
%   once for each left out condition.  The algorithm combines each of these
%   clustering results into a matrix, and passes that matrix to the fom2_adj
%   function which does the actual calculations.  This method returns the
%   adjusted 2-norm FOM for Hierarchical clustering on the input data.  
%
%   USAGE >> [a2] = FOM2_hierarch(6, data_matrix, 'correlation' )
%
%
%   Variable Description:
%       num_clust:  The number of clusters/subtrees the hierarchical
%       clustering algorithm should break the data/hierarchical tree into.
%
%       data_mat:  The data that is being clustered with features (genes)
%       as rows and conditions (time points) as columns.
%
%       dis_metric:  The similarity measure to use; it can be any 
%       Similarity measure avaliable to PDIST.
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
%       Last Revised:  4/9/07
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


% First create the variables we need
tmp = size(data_mat);   % needed to get number of rows and columns of data_mat
num_rows = tmp(1,1);    % the number of genes/features
num_cols = tmp(1,2);    % the number of time series/conditions

clustered = zeros(num_rows, num_cols);   
    % this is where the cluster solutions from hierarchical clustering will go

% loop for each condition e, leaving out that column in data_mat each time
for h=1:num_cols
    tmp_data = data_mat;    % copy data_mat to a tmp variable tmp_data
    tmp_data(:,h) = [];     % delete column h from tmp_data
    
    % cluster the remaining columns in tmpp_data, 
    % and save the results in the corresponding column h of the 'clustered' matrix
        Y = pdist(tmp_data, dis_metric);  % calculated the pairwise distances
        Z = linkage(Y,'average');   % creates the full linkage tree (i.e. this is the clustering step)
        [dont_need ,clustered(:,h)] = dendrogram(Z, num_clust); % builds the dendrogram, but only down to num_clust nodes
        close;            
end

% calculate the adjusted FOM score for hierarchical clustering
fom_a2 = FOM2_adj(clustered, data_mat, num_clust);

    






