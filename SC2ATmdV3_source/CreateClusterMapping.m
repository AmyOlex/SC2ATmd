function [  ] = CreateClusterMapping( solution1, solution2, file )
%CREATECLUSTERMAPPING Creates a mapping of the first clustering solution to
%the second by defining the composition of the first in terms of the second
 
%  Must input 2 arrays: cluster assignments for one solution, and
%  cluster assignments for a second cluster solution, all ordered by the 
%  first cluster solution then by the second cluster solution.
%  Must also input the file to write to.
%
%   USAGE: CreateClusterMapping( solution1, solution2, 'myfilename.txt');
%
%   Variable description:
%       solution1:   This is a 1D n-length integer array that is sorted
%       in an ascending manner.
%
%       solution2:  This is also a 1D n-length integer array, that is
%       sorted ascending, but on a per cluster basis from that of solution1.
%
%       file:  The file name with extension that the output should be saved
%       to.
%
%   This function is a little confusing in that no labels are input, and it
%   is assumed that the input vectors are in some order based on data not
%   used by this function.  In order ot get valid and meaninful results 
%   from this function, pre-process of the data is required.
%   Therefore, a brief example is illustrated below.
%
%   Say you have the following dataset:
%       
%       Gene1   1   3   4
%       Gene2   4   3   2
%       Gene3   8   7   9
%       Gene4   9   0   5
%       Gene5   7   8   2
%       Gene6   7   8   5
%       Gene7   1   2   4
%
%   You want to cluster this data into 3 clusters using two different
%   methods, then you want to compare the results of the two methods to see
%   which genes were moved around.  
%
%   First cluster the data using both methods:
%               Method 1    Method 2
%       Gene1       3           1
%       Gene2       2           2
%       Gene3       3           1
%       Gene4       1           1
%       Gene5       1           3
%       Gene6       1           3
%       Gene7       1           2
%
%
%   Now the CreateClusterMapping finction can be used.  However, before
%   inserting the cluster solutions, they must be sorted by one of the
%   methods.  Sorting by Method 1 we get:
%               Method 1    Method 2
%       Gene4       1           1
%       Gene7       1           2
%       Gene5       1           3
%       Gene6       1           3
%       Gene2       2           2
%       Gene1       3           1
%       Gene3       3           1
%
%   Notice that now the clusters in Method 1 are sorted ascending, and the
%   clusters in Method 2 are sorted on a per-cluster basis from solution 1.
%   This is the data that is input into the CreateClusterMapping function.  
%
%   >> CreateClusterMapping([1,1,1,1,2,3,3], [1,2,3,3,2,1,1], 'sample.txt');
%
%   The above command will generate an output file like the following:
%
%   solution#1  solution#2:numberofGenes
%   1           1:1 2:1 3:2
%   2           2:1
%   3           1:2
%
%   This can be read as: Cluster 1 for Method1 is composed of 1 gene from
%   cluster1 in Method2, 1 gene from cluster 2 in Method2, and 2 genes from
%   cluster 3 in Method2.
%
%
%   Last revised 4/14/07
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

% Open file
fid = fopen(file, 'w');

fprintf(fid, 'solution#1\tsolution#2:NumGenes\n');

num_clusters = length(unique(solution1));

% find out how many genes are in each cluster
cluster_count = hist(solution1, num_clusters);

% loop through each gene counting the clusters as we go
start_idx = 1;
for i=1:num_clusters
    %determine the new end gene_idx
    end_idx = start_idx+cluster_count(i)-1;
    
    % extract new cluster i from the original clusters into it's own array
    tmp_origi = solution2(start_idx:end_idx, :);
    
    % now find all the unique values, and their counts
    tmp_unique = unique(tmp_origi);
    tmp_unique_count = hist(tmp_origi, tmp_unique);
   
    % now write this information to the file
    fprintf(fid, '%d\t', i);
    
    if length(tmp_unique) == 1
        fprintf(fid, '%d:%d\t ', tmp_unique, cluster_count(i));
    else
        for n=1:length(tmp_unique)
            fprintf(fid, '%d:%d\t ', tmp_unique(n), tmp_unique_count(n));
        end % for
    end %if else
    
    fprintf(fid, '\n');
    
    start_idx = end_idx+1;
    
end % for each cluster

fclose(fid);


