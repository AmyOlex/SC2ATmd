function [ consensus_solution ] = identify_consensus_clusters( gene_labels, ...
    dataset_ary, gene_clustering, num_runs, cutoff, savename, savepath )
%IDENTIFY_CONSENSUS_CLUSTERS  Extracts the consensus clusters from the
%input clustering runs.
%  
%  Creates a matrix to count which elements are consistently found in the
%  same clusters.  Input is vector of element labels, and and matrix of
%  clusterings, plus a cutoff.  There must be 2 or more clustering runs.  
%  Output is one consensus clustering solution that is ordered by the 
%  largest sized cluster to the smallest. 
%
%   This algorithm can be used with any data that has already been
%   clustered, as long as it is in the appropriate matirx and label format.
%
%   Algorithm:
%       1 - create n x n matrix and initilize to zero
%       2 - use list of gene labels as the index to the matrix.
%       3 - start at gene 1, all genes with the same cluster assignment in
%       that clustering should get incremented by one in the matrix.
%       4 - Create vectors for each input element that includes all element labels 
%       that have clustering counts exactly equal to the cutoff value.
%
%   Usage:  cluster_consensus( labels, runs, 10, 10, 'myfile.txt' );
%   The above call specifies that each consensus cluster must be 100%
%   consistent.  If less than 100% accuracy is ok, then the cutoff may be
%   lowered to a value less than the total number of runs.
%
%
%   Variable Description:
%     gene_labels - a column cell array with the element labels as strings
%     gene_data - the SLR values these genes were clustered on.  Must be in
%       the same order as the gene_labels array.
%     gene_clustering - an nxm matrix where n is the number of elements
%       (rows), and m is the number of clustering runs (columns).  Each
%       column of this matrix must be in the same order as the gene labels
%       so that element label 1 corresponds to row 1 of the matrix.
%     num_runs - the number of clustering runs/solutions being put into the
%       program.
%     cutoff - cannot be greater than the total number of clustering
%       runs.  Set the cutoff to equal the number of runs to only get those
%       elements that clustered together every single time.
%     filename - The name of the output file to save the results
%       in.  It must include an extension.
%     data_headers - the column labels for the raw data
%
%   Author:  Amy Olex
%
%   Algorithm loosly based on:
%   Stefano Monti, Pablo Tamayo, Jill Mesirov and Todd Golub.
%   Consensus Clustering: A resampling-based method for class discovery
%   and visualization of gene expression microarray data. 
%   Machine Learning. 52:91-118 (2003).
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


% Create matrix and needed variables
num_genes = length(gene_labels);
gene_counts = zeros(num_genes, num_genes);


%create counting matricies
% Loop through the array to count occurances
for c=1:num_runs
   % fprintf('Working on Clustering Run #%d', c);
   % tic;
    for a=1:num_genes
       
        geneA_idx = a;
        geneA_clust = gene_clustering(geneA_idx,c);
    
        for b=1:num_genes
            if(gene_clustering(b,c)== geneA_clust)
                gene_counts(geneA_idx,b) = gene_counts(geneA_idx,b)+1;
            end
        end
    end
   % toc;
end

%save('gene_counts.mat', 'gene_counts', 'gene_labels');
  
% Pull out the consensus clusters without duplication.

%% NEW METHOD: What I want to do here is to pull out all connected genes into the same cluster.
% Essentially I am traversing a graph of nodes and finding the 'weakly
% connected components', thus I use a graphing method here to do this.  
% First I must alter the adjacency matrix (gene_counts) so that all edges
% below the threshold are set to zero.

adjMat = double(gene_counts >= cutoff);
adjSmat = sparse(adjMat);
[num_clusters, consensus_clusters] = graphconncomp(adjSmat, 'Directed', false);


%this method does not re-order anything, so vector should still be in same
%order as gene_labels variable.
consensus_solution = order_by_clustsize(consensus_clusters);

%save('consensus_solution.mat', 'consensus_solution');


% Write the results to a text file
% fprintf('Writing Outfile\n');

filename = strcat(savepath, savename, '.txt');

fid = fopen(filename, 'w');

num_datasets = length(dataset_ary);

% Printing out header row
fprintf(fid, 'ConsensusCluster#\tGeneID\tOrigCluster#\t');

for d=1:num_datasets
    for j=1:length(dataset_ary(d).colheader)
        fprintf(fid, '%s\t', char(dataset_ary(d).colheader(j)));
    end
end

% printing out data

for row=1:num_genes
    gene_name = char(gene_labels(row));
    fprintf(fid, '\n%d\t%s\t%d\t', consensus_solution(row), ...
        gene_name, gene_clustering(row,1));
          
    % loop through each dataset and print out the data
    for d=1:num_datasets
        
        tmp = size(dataset_ary(d).data);
        col = tmp(2);
        for i=1:col
           fprintf(fid, '%s\t', num2str(dataset_ary(d).data(row, i))); 
        end
    end
end

fclose(fid);


%% Now take the gene_counts matrix and print out a network file for Cytoscape so we can look at these clusters in network form.
%  Need to ensure no self-edges or duplicate edges are included.  The
%  tril() command should ensure all values on the diagonal (self-edges) and
%  those above the diagonal (duplicate edges) are not included in the
%  output.

gene_count_sparse = sparse(tril(gene_counts, -1));
[node1, node2, value] = find(gene_count_sparse);
%convert numbers to gene IDs
node1names = gene_labels(node1);
node2names = gene_labels(node2);

%print to file
filename2 = strcat(savepath, savename, '_network.txt');
fid2 = fopen(filename2,'W');

% Printing out header row
fprintf(fid2, 'ID1\tID2\tNumClusteredTogether\t');

% printing out data

for n=1:length(node1)
    gene_name1 = char(node1names(n));
    gene_name2 = char(node2names(n));
    fprintf(fid2, '\n%s\t%s\t%d\t', gene_name1, gene_name2, value(n));
          
end

fclose(fid2);







