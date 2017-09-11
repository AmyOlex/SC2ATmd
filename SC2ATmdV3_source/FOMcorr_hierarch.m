function [fom_corr] = FOMcorr_hierarch( num_clust, data_mat, dis_metric )
%FOMCORR_HIERARC Returns the correlation FOM calculation
%on the input data using the hierarchical clustering provided by Matlab.
%
%   
%   This algorithm first clusters the data once for each left out condition, 
%   each time leaving a different condition e out.  It combines all these
%   clustering results into a matrix, and passes that matrix to the cfom
%   functions which do the actual calculations.  This method returns the
%   correlation-biased FOM for Hierarchical clustering using the input data.  
%
%   USAGE >> [cfom] = FOMcorr_hierarch( 10, your_data_matrix, 'correlation' )
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
%   Acknowledgments:
%       Code Author:    Amy Olex
%       Original Figure Of Merit: Mathematical scoring methods from the 
%           following Technical Report which became a published paper:
%           Yeung,KY; Haynor,DR; and Ruzzo,WL (2001) "Validating
%           Clustering for Gene Expression Data". Bioinformatics, Vol.17 No.4,
%           309-318.
%           Note:  Yeung et al developed the original FOM method from which
%           this cFOM method was derived.  The correlation FOM method was
%           developed by Amy Olex.
%       
%       Last Revised:  4/10/2007
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

clustered = zeros(num_rows, num_cols);   % this is where the cluster solutions from kmeans will go

% loop for each condition, leaving out the corresponding column of data each time
for h=1:num_cols
    tmp_data = data_mat;
    tmp_data(:,h) = [];     % delete column h
    %cluster data using the dendrogram method and save the results to the
    %clustered matrix.
        Y = pdist(tmp_data, dis_metric); 
        Z = linkage(Y,'average'); 
        [dont_need ,clustered(:,h)] = dendrogram(Z, num_clust);
        close;          
end

% calculate the cFOM
fom_corr = FOMcalc_corr( clustered, data_mat, num_clust);

    






