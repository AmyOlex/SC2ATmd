function [ fom_a2 ] = FOM2_kmeans( num_clust, data_mat, dis_metric )
%FOM2_KMEANS Returns the 2-norm FOM calculation for kmeans clustering.
%
%   This algorithm removes each condition e in turn, then clusters the data 
%   once for each left out condition.  The algorithm combines each of these
%   clustering results into a matrix, and passes that matrix to the fom2_adj
%   function which does the actual calculations.  This method returns the
%   adjusted 2-norm FOM for K-means clustering on the input data.
%
%   Because K-means is randomly initilized, slightly different clustering
%   solutions will be generated each time. Therefore, kmeans is run 10
%   times, and the FOM score calculated each time and averaged to ensure a
%   representative score.
%
%   Variable Descriptions:
%       num_clust:  The number of clusters/subtrees the kmeans algorithm
%       should divide the data into.
%
%       data_mat:  The data that is being clustered with features (genes)
%       as rows and conditions (time points) as columns.
%
%       dis_metric:  The similarity measure to use; it can be any 
%       Similarity measure avaliable to KMEANS.
%
%   USAGE >> [a2] = FOM2_kmeans( 6, data_mat, 'correlation' )
%   
%   Extra Notes:  Kmeans requiers occasional handling of missing clusters.
%   This is done with the 'EmptyAction' setting (see help kmeans for more
%   info).  It is using 'singleton' because this way of handling missing
%   clusters does not result in division by zero like the 'drop' setting
%   occasionally does.  Using a small data set, there seems to be no effect
%   on any of the scores no matter what method is used.
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
tmp = size(data_mat);   % needed to get number of rows and columns
num_rows = tmp(1,1);    % the number of genes
num_cols = tmp(1,2);    % the number of time series

  % this will be used to keep a running total of the fom scores for each
  % iteration on kmeans, then the average will be used as the final score.
tmp_fom2 = 0;                   

% Loop through 10 times, each time calculate the fom scores for that
% clustering.  Return the average of these results.
for reps=1:10

    clustered = zeros(num_rows, num_cols);   % this is where the clustering solutions from kmeans will go

    % loop for each condition e,leaving out one column each time (column h)
    for h=1:num_cols
        tmp_data = data_mat;    % copy data_mat ot tmp_data.
        tmp_data(:,h) = [];     % delete column h from tmp_data
        %cluster the rest, and save the results in the clustered matrix
        clustered(:,h) = kmeans(tmp_data, num_clust, 'distance', dis_metric, 'EmptyAction', 'singleton', 'Display', 'off');           
    end
    % call the fom2 function to get the 2-norm FOM score for
    % this clustering
    tmp_fom2 = tmp_fom2 + FOM2_adj(clustered, data_mat, num_clust);
    
end  % end clustering reps
fom_a2 = tmp_fom2/10;





    






