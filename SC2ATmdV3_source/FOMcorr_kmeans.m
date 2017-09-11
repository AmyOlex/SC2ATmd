function [ cfom ] = FOMcorr_kmeans( num_clust, data_mat, dis_metric )
%FOMCORR_KMEANS Returns the correlation FOM calculation
%on the input data using the kmeans clustering provided by Matlab.
%
%   
%   This algorithm first clusters the data once for each left out condition, 
%   each time leaving a different condition e out.  It combines all these
%   clustering solutions into a matrix, and passes that matrix to the cfom
%   functions which do the actual calculations.  This method returns the
%   correlation-biased FOM for kmeans clustering using the input data.  
%
%   USAGE >> [cfom] = FOMcorr_kmeans( 10, your_data_matrix, 'correlation' )
%
%   Variable Descriptions:
%       num_clust: the number of total clusters to use.
%
%       data_mat:  the actual data to be clustered, where columns are
%       conditions and rows are features/gene profiles.
%
%       dis_metric:  can be any distance metric avaliable to PDIST.
%
%
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
%           Note:  Yeung et al developed the original FOM method from which
%           this cFOM method was derived.  The correlation FOM method was
%           developed by Amy Olex.
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

% First create the variables we need
tmp = size(data_mat);   % needed to get number of rows and columns
num_rows = tmp(1,1);    % the number of genes
num_cols = tmp(1,2);    % the number of time series

tmp_fom1 = 0;           % this will be used to keep a running total of the kmean
           % iterations of the cfom calculation, then the average will be
           % returned.
% Loop through 10 times, each time calculate the fom scores for that
% clustering.  Return the average of these results.

% NOTE: because this algorithm has a very long running time, the kmean
% iterations are not being done as in the original FOM2_kmeans.m file.
% Here kmeans is only done once; when the algorithm is improved then this
% should be increased to 10 or more.
for reps=1:1

    clustered = zeros(num_rows, num_cols);   % this is where the clustered solutions from kmeans will go

    % loop for each condition,leaving out one column each time (column h)
    for h=1:num_cols
        tmp_data = data_mat;
        tmp_data(:,h) = [];     % delete time series h
        clustered(:,h) = kmeans(tmp_data, num_clust, 'distance', dis_metric ,'EmptyAction', 'singleton', 'Display', 'off');   %cluster the rest,
                % and save the results in the clustered matrix
    end

    % calculate the cFOM score
    tmp_fom1 = tmp_fom1 + FOMcalc_corr( clustered, data_mat, num_clust);

    
end  % end clustering reps

% average of all reps
cfom = tmp_fom1/1;





    






