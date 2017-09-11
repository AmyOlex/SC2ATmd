function [ cluster_data ] = dendroCluster( data_mat, num_clust, file, outpath, varargin )
%DENDROCLUSTER Hierarchical clusters data using Matlab's linkage and dendrogram method.
%  This method takes in the number of clusters the user would like to break
%  the data up into, then uses linkage and dendrogram to hierarchically cluster the
%  data, and returns the results in an array.  The cluster_data result
%  contains one entry for each gene in the original data matrix in the
%  same order; it is the cluster assignment for that gene.  The
%  cluster_perm is an array that contains the order of the clusters on the
%  dendrogram.  This is only useful if you are using the dendrogram for
%  something.  
%  
%  By default this method uses 'euclidean' for the distance
%  metric, and 'average' for the linkage method.  If the user wants to
%  change this all they need to do is specify which method shoud be used
%  in the input arguments.  Examples follow:
%  
%  USAGE:  [solution] = dendroCluster( data_mat, 10, 'myfile', 'C:/', 'pdist', 'correlation' );
%           
%   Variable Description:
%       data_mat:  an nxc real valued matrix of data to cluster where n is the 
%       number of row/elements to cluster, and c is the number of columns.
%
%       num_clust:  the total number of clusters desired.
%
%       file:  A string containing the file name with no extension.
%
%       outpath:  A string containing the path to the desired folder the output should be saved in.
%
%       varargin:   These are optional.  If this is empty the default values 
%       for pdist and linkage are used; pdist = 'euclid', linkage =
%       'average'.
%       Any of the standard values defined by matlab for pdist and linkage can be specified.
%            
%
%  See also: DENDROGRAM, PDIST, LINKAGE
%
%   Author: Amy Olex
%  
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

pdistarg = 'euclidean';
linkagearg = 'average';

% The following code for input args was based on the code in CLUSTERGRAM by Matlab's
% bioinfo package.

if nargin > 4
    if rem(nargin,2) ~= 0
        error('Incorrect number of arguments');
    end

    okargs = {'pdist','linkage'};
    
    for j=1:2:nargin-4
        pname = varargin{j};
        pval = varargin{j+1};
        k = strmatch(lower(pname), okargs);
        if isempty(k)
            error('Unknown parameter name: %s.',pname);
        elseif length(k)>1
            error('Ambiguous parameter name: %s.',pname);
        else
            switch(k)
                case 1  % pdist args
                        pdistarg = pval;
                case 2  % linkage args
                        linkagearg = pval;
            end
        end
    end
end

% end code taken from CLUSTERGRAM

% start clustering algorithm

Y = pdist(data_mat, pdistarg);  %calculate all distances
Z = linkage(Y, linkagearg);     %create hierarchical tree
figure(1000);
% generate hierarchical dendrogram.  This method has the unique ability to
% stop building the tree at a specified level (the number of clusters
% wanted).  This functionality is utilized so that discrete cluster
% assignemnts for all genes is contained.  To build the entire tree, the
% num_clust variable should be changed to zero, however, then the number of
% clusters returned will equal the number of genes (i.e. all are in a
% singleton cluster).
[H, cluster_data] = dendrogram(Z, num_clust, 'orientation', 'left', 'colorthreshold', .7);
    

filename = strcat(outpath, file, '-gden');

saveas(1000, filename, 'fig');



