function [ cfom ] = FOMcorr_random( num_clust, data_mat  )
%FOMcorr_random Randomly clusters the data and returns the calculated cFOM
%scores.
%   
%   This algorithm places genes into random clusters.  It creates a random 
%   clustering for each condition e that is supposed to be left out.  Since
%   This algorithm is random it has no need to actually leave out each
%   condition; it wouldn't be using that data anyway. Then, all these
%   clustering solutions are combined into a matrix which is passed to the cfom
%   functions to do the actual calculations.  This method returns the cFOM score for random clustering.  
%
%
%   USAGE >> [cfom] = FOMcorr_random( 10, your_data_matrix )
%
%
%   Variable Descriptions:
%       num_clust: the number of total clusters to use.
%
%       data_mat:  the actual data to be clustered, where columns are
%       conditions and rows are features/gene profiles.
%
%
%   Acknowledgments:
%       Code Author:    Amy Olex
%       Random Clustering Algorithm:  Amy Olex
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

clustered = zeros(num_rows, num_cols);   % this is where the random solutions will go

% loop for each condition and randomly assign genes to clusters

for h=1:num_cols
    clustered(:,h) = clust_rand(num_clust, num_rows);   %cluster randomly,
            % and save the results in the clustered matrix
end

% calculate the cFOM score
cfom = FOMcalc_corr( clustered, data_mat, num_clust);

    
