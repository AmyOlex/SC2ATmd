function [ reordered_solution ] = order_by_clustsize( cluster_solution )
%ORDER_BY_CLUSTSIZE re-labels the input clusters by size
%
%   basically takes in a 1D array that represents a
%   clustering solution and reordereds the labels by descending cluster size.
%   The largest cluster will have the smallest cluster assignment.
%
%   Author: Amy Olex
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


reordered_solution = zeros(size(cluster_solution));
clust_list = unique(cluster_solution);
numclust = length(clust_list);
numgenes = length(cluster_solution);

% generate histogram
solution_histogram = reverse(sortrows(transpose([histc(cluster_solution, clust_list); clust_list])));

% format of solution_histogram is:
%       [count  clust#]
% with it being ordered in descending order by the count column.


% loop through each cluster the each gene reassigning as you go

for i=1:numclust
    for j=1:numgenes
        if cluster_solution(j) == solution_histogram(i, 2)
            reordered_solution(j) = i;
        end
    end
end

