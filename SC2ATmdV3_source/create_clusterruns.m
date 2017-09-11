function [ clustered_mat, runheader ] = create_clusterruns( dataset_ary, row_labels, alg_list, ...
    dismeasure_list, numreps, num_clusters, savepath, savename, saveresults )
%CREATE_CLUSTERRUNS   generates the specified clustering runs 
%
%   Takes in the datasets and the consensus options input by the user and
%   performes the necessary clustering to generate the clustering runs.
%   All runs are stored in matrix for and returned.
%
%   Step 1:  identify the number of datasets, algorithms and similarity
%   measures that will need to be looped through
%
%   Step 2:  Set up needed variables like global run matrix
%
%   Step 3:  loop through each dataset, then each clustering algorithm,
%   followed by each dismetric.
%
%   Step 4:  At each loop pass the neseccary variables to the method
%   ConsensusClusteringSecondary.m and add the solution matrix to the
%   cumulative one.
%
%   Step 5:  return the clustering run matrix
%
%   To determine how many clustering solutions should be generated follow
%   this formula:
%       (num_datasets*num_dismeasures) * ((1-num_algs)+num_kmean_runs)
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

num_datasets = length(dataset_ary);
num_algs = length(alg_list);
num_dismeasures = length(dismeasure_list);
num_genes = length(row_labels);
clustered_mat = zeros(size(row_labels));
solution_count = 1;

runheader = {};   
        
% create clustering solutions for all combinations.
for d=1:num_datasets
    
    for a=1:num_algs
        
        switch char(alg_list(a))
            case 'Kmeans',
                for s=1:num_dismeasures
                    
                    switch char(dismeasure_list(s))
                        case 'Euclidean Distance',
                            
                            for r=1:numreps
                                clustered_mat(:,solution_count) = kmeans(dataset_ary(d).data, num_clusters, 'distance', 'sqEuclidean', 'EmptyAction', 'singleton');
                                solution_count = solution_count+1;
                                runheader = cat(1, runheader, {strcat('Kmeans ED dset', num2str(d), 'rep',num2str(r))} );
                            end   
                        case 'Pearsons Correlation',
                            
                            for r=1:numreps
                                clustered_mat(:,solution_count) = kmeans(dataset_ary(d).data, num_clusters, 'distance', 'correlation', 'EmptyAction', 'singleton');
                                solution_count = solution_count+1;
                                runheader = cat(1, runheader, {strcat('Kmeans PCC dset', num2str(d), 'rep',num2str(r))} );
                            end     
                        case 'City Block',
                            
                            for r=1:numreps
                                clustered_mat(:,solution_count) = kmeans(dataset_ary(d).data, num_clusters, 'distance', 'cityblock', 'EmptyAction', 'singleton');
                                solution_count = solution_count+1;
                                runheader = cat(1, runheader, {strcat('Kmeans CB dset', num2str(d), 'rep',num2str(r))} );
                            end 
                        case 'Cosine',
                            
                            for r=1:numreps
                                clustered_mat(:,solution_count) = kmeans(dataset_ary(d).data, num_clusters, 'distance', 'cosine', 'EmptyAction', 'singleton');
                                solution_count = solution_count+1;
                                runheader = cat(1, runheader, {strcat('Kmeans Cos dset', num2str(d), 'rep',num2str(r))} );
                            end 
                    end %end switch
                    
                end % loop similarity measures  
   % perform hierarchical clustering
            case 'Hierarchical',
                for s=1:num_dismeasures
                    
                    switch char(dismeasure_list(s))
                        case 'Euclidean Distance',
                            runheader = cat(1, runheader, {strcat('Hierarch ED dset', num2str(d))} );
                            figure(1000);
                            Y = pdist(dataset_ary(d).data, 'euclidean');  %calculate all distances
                            Z = linkage(Y, 'average');     %create hierarchical tree
                            [H, clustered_mat(:,solution_count)] = dendrogram(Z, num_clusters, 'orientation', 'left', 'colorthreshold', .7);
                            solution_count = solution_count+1;
                            close(1000);
                        case 'Pearsons Correlation',
                            runheader = cat(1, runheader, {strcat('Hierarch PCC dset', num2str(d))} );
                            figure(1000);
                            Y = pdist(dataset_ary(d).data, 'correlation');  %calculate all distances
                            Z = linkage(Y, 'average');     %create hierarchical tree
                            [H, clustered_mat(:,solution_count)] = dendrogram(Z, num_clusters, 'orientation', 'left', 'colorthreshold', .7);
                            solution_count = solution_count+1;
                            close(1000);
                        case 'City Block',
                            runheader = cat(1, runheader, {strcat('Hierarch CB dset', num2str(d))} );
                            figure(1000);
                            Y = pdist(dataset_ary(d).data, 'cityblock');  %calculate all distances
                            Z = linkage(Y, 'average');     %create hierarchical tree
                            [H, clustered_mat(:,solution_count)] = dendrogram(Z, num_clusters, 'orientation', 'left', 'colorthreshold', .7);
                            solution_count = solution_count+1;
                            close(1000);
                        case 'Cosine',
                            runheader = cat(1, runheader, {strcat('Hierarch Cos dset', num2str(d))} );
                            figure(1000);
                            Y = pdist(dataset_ary(d).data, 'cosine');  %calculate all distances
                            Z = linkage(Y, 'average');     %create hierarchical tree
                            [H, clustered_mat(:,solution_count)] = dendrogram(Z, num_clusters, 'orientation', 'left', 'colorthreshold', .7);
                            solution_count = solution_count+1;
                            close(1000);
                    end %end switch
                    
                end % loop similarity measures                 
                
        end % end switch clustering algorithms

        
    end % loop algorithms
    
end % loop datasets


if saveresults
    filename = strcat(savepath, savename, '-ClusterRuns.txt');

    fid = fopen(filename, 'w');

    % Printing out header row
    fprintf(fid, 'GeneID\t');

    num_runs = length(runheader);
    
    for d=1:num_runs
        fprintf(fid, '%s\t', char(runheader(d)));
    end

    % printing out data

    num_genes = length(clustered_mat);
    
    for row=1:num_genes
        gene_name = char(row_labels(row));
        fprintf(fid, '\n%s\t', gene_name);
        for i=1:num_runs
           fprintf(fid, '%s\t', num2str(clustered_mat(row,i))); 
        end
    
    end      

fclose(fid);
end
