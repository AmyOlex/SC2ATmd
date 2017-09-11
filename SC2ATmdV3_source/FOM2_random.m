function [ fom_a2 ] = FOM2_random( num_clust, data_mat )
%FOM_random Randomly clusters the data and returns the calculated FOM
%scores.
%
%   
%   This algorithm places genes into random clusters.  It creates a random 
%   clustering for each condition e that is supposed to be left out.  Since
%   This algorithm is random it has no need to actually leave out each
%   condition; it wouldn't be using that data anyway. Then, all these
%   clustering results are combined into a matrix which is passed to the fom
%   functions to do the actual calculations.  This method returns the
%   adjusted 2-norm for random clustering using the input data.  
%
%   Input is the number of clusters and the data matrix; output is the
%   adjusted FOM2 score.
%
%   Variable Description:
%       num_clust:  The number of clusters wanted
%       
%       data_mat:  The data that is being clustered with features (genes)
%       as rows and conditions (time points) as columns.
%   
%   USAGE >> [a2] = FOM2_random( #_of_clusters, your_data_matrix ) 
%
%   Acknowledgments:
%       Code Author:    Amy Olex
%       Random Clustering Algorithm:  Amy Olex
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
tmp = size(data_mat);   % needed to get number of rows and columns
num_rows = tmp(1,1);    % the number of genes
num_cols = tmp(1,2);    % the number of time series

clustered = zeros(num_rows, num_cols);   % this is where the random clustering solutions will go

% loop for each column/condition and randomly assign genes to clusters

for h=1:num_cols
    clustered(:,h) = clust_rand(num_clust, num_rows);   %cluster randomly,
            % and save the results in the clustered matrix
end

% fom2 function to get the 2-norm FOM score for this clustering
fom_a2 = FOM2_adj(clustered, data_mat, num_clust);

    
