function [ clustered ] = clust_rand( num_clusters, num_genes )
%CLUST_RAND randomly creates a clustering permutation for the given
%number of genes and clusters
%   This method just assigns a random cluster number to each gene.  If a
%   cluster is not present then the algorithm is repeated until each
%   cluster is represented at least once.
%
%   Usage:  [clustered] = clust_rand(n, m);
%   Variable description:
%               clustered - an m length column vector containing a cluster
%               assignment in the range of 1 to n for each of the m
%               elements.
%               n - the number of cluster the data needs to be grouped into
%               m - the total number of elements in the dataset
%
%   Note:  this method does not need the actual data, as it just randomly
%   assigns each element to a cluster, so the data dimensions are all that 
%   is required.  Also, this can be used to create a random cluster 
%   assignment for anything.
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

clustered = zeros(num_genes,1);
tmp = [];
repeat = true;

while repeat==true
    
    for i=1:num_genes
        tmp=randperm(num_clusters);
        clustered(i,1) = tmp(1);
    end

    num_clust = length(unique(clustered));

    if num_clust ~= num_clusters
       repeat = true;
    else
       repeat = false;
    end
    
end