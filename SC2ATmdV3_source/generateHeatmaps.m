function [ ] = generateHeatmaps( cluster_solution, labels, col_labels, data,...
    num_clusters, imagefile, savepath, colormap, fileformats, minClustSize )
%GENERATEHEATMAPS Takes pre-clustered data and generates heatmaps using
%the Clustergram function.
%
%  Technically this method hierarchicaly re-clusters any data that is input
%  using the Clustergram function provided by the Bioinformatics Toolbox.
%  The input data must also include cluster assignments, and each cluster
%  is extracted and re-clustered using Clustergram.  This organizes each
%  cluster, and generates a heatmap.  Then the heatmap is saved as a jpeg
%  and .fig file, plus a text file is generated containing the order of
%  genes in each heatmap that was created.
%
%
%   USAGE:  generateHeatmaps( cluster_solution, row_labels, col_labels,
%   your_data, 10, 'myimage', 'C:\', 'blue-yellow');
%
%   Variable Descriptions:
%       cluster_solution:  A vector of cluster assignments for each gene.
%
%       labels:  A column cell array of row labels for each gene; must be in the same order as
%       the cluster_solution vector.
%
%       col_labels: A row cell array of column labels.
%
%       data:  the data matrix containing all data that was used to
%       generate the clusters; must be in the same order as the
%       cluster_solution and labels vectors.
%
%       num_clusters: the number of clusters present in cluster_solution
%
%       imagefile:  a string to use as the file identifyer; do not include
%       an extension.
%
%       savepath:  A string representing the path to which the output files
%       should be saved to.
%
%       colormap:  can be one of 'blue-yellow' or 'red-green'; specifies the
%       color scheme to use for the heatmap.
%
%       fileformats:  A cell array of file extensions the heatmaps will be
%       saved in.
%
%       minClustSize:  The minimum number of genes that are in each cluster
%       for a heatmap to be generated.  To generate heatmaps of all
%       clusters set the minClustSize to 1.
%
%      Author: Amy Olex
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

tmp = size(data);   % needed to get number of rows and columns
num_rows = tmp(1,1);    % the number of genes
num_col = tmp(1,2);    % the number of time series

% find out how many genes are in each cluster
cluster_count = hist(cluster_solution, num_clusters);

% open the text file for writing.
textfile = strcat(savepath, imagefile, '.txt');
fid = fopen(textfile, 'w');
% print the column labels to the file
fprintf(fid, 'cluster#\tclusterOrder\tGeneID\t');
for j=1:num_col
    fprintf(fid,'%s\t', col_labels{j});
end

% loop through each cluster, if the cluster size is acceptable then
% extract the gene data and generate and save the heatmap.
for k=1:num_clusters
    
    % before anything is done, check the size of this cluster
    if cluster_count(k) >= minClustSize
        
        % extract data and gene labels for cluster k from the clustering solution into a
        % temporary matrix
        tmp_clusterk = zeros(cluster_count(k), num_col);
        tmp_labels = cell(cluster_count(k), 1);
        idx = 1;  %this is used as a counter for keeping track of how many genes are in this cluster.
        for j=1:num_rows  % for each row in the original data matrix
            if cluster_solution(j) == k % if this gene is in cluster j
                tmp_clusterk(idx, :) = data(j, :);  % add it to the temp matrix
                tmp_labels(idx, 1) = labels(j, 1);
                idx = idx+1;
            end %if 
        end %for

        % Since Clustergram cannot handle a cluster with only one gene, I will
        % duplicate the same gene and cluster the pair.
        if idx == 2
            tmp_clusterk = [tmp_clusterk; tmp_clusterk];
            tmp_labels = [tmp_labels; tmp_labels];
        end %if

       % open a new figure for this cluster 
       h = figure(k);

       % perform the revised clustergram on this cluster
       [a b c orderedID]=clustergram_revised(tmp_clusterk, 'rowlabels', tmp_labels, 'columnlabels', col_labels, 'pdist', 'euclid', 'linkage', 'average', 'ratio', .1);

       % modify the figure and save it to a file
       bar = colorbar('location','manual','position',[0.06 0.1 0.04 0.8]);     % adds a color bar
        

       %   maxfigsize(h);   % maximizes figure size to fit screen
       imagename = strcat(imagefile, '-cluster', num2str(k));
       title(imagename,  'FontSize', 12);

       if(strcmp(colormap,'blue-yellow'))   % changes the default red-green to blue-yellow colormap
        changecolor(colormap);
       end
       
       if(strcmp(colormap,'red-white-blue'))   % changes the default red-green to red-white-blue colormap
        changecolor(colormap);
       end

        %save the figure in all the formats and close the text file
       
        for f=1:length(fileformats)
            saveas(h, strcat(savepath, imagename), char(fileformats(f)) );
        end

              % now write the clustering results to a text file
              % the variable orderedID contains a list of gene labels in the same
              % order as the generated heatmap.  This list is used to obtain an
              % ordering of the genes in the output file to match the heatmap
              % ordering.
           for n=1:cluster_count(k)
               % match each label contained in orderedID with the corresponding
               % data in the original data matrix by finding its index through
               % string matching.
               orig_idx = strmatch(orderedID{n}, labels);
               fprintf(fid, '\n%d \t %d \t %s \t', k, n, orderedID{n});
               for c=1:num_col
                   fprintf(fid, '%s\t', num2str(data(orig_idx,c)));
               end
           end %for
    end % if cluster is right size
end %for each cluster k

fclose(fid);