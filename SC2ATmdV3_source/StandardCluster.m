function [ clustered_solution ] = StandardCluster( data, labels, col_labels, num_clusters, ...
    file, outpath, dis_metric, alg, colormap  )
%STANDARDCLUSTER Performs either k-means of hierarchical clustering on the input data,
%  outputs heatmaps of each cluster, and a text file with the clustering
%  solution.
%
%   This function is mainly used by the GUI to organize and integrate the
%   clustering and heatmap generation into one function.  It takes in a
%   numerical data matrix, two cell vectors with labels, number of
%   clusters, output file information, the similarity measure, clustering
%   algorithm, and the colormap.  Using all these the dad is clustered
%   using the specified method, then those clusters are used to generate
%   heatmaps of each, and they are saved to jpeg and .fig files.  The
%   clustering solution is returned and printed to a text file.
%
%   USAGE: [solution] = OlexCluster( mydata, {'gene1', 'gene2', ...}, ['1hr'; '3hr';...], 10, 'myfilename', 'C:/', 'correlation', 'k-means', 'red-green');
%   
%   This returns a n length 1D integer vector where n is the number of genes in the data matrix.
%   Each entry contains the cluster assignment for the corresponding row of
%   the data matrix.  The order of this vector is the same as the data
%   matrix.
%   
%   Variable Descriptions:
%       data:   A nxc matrix of real numbers where n is the number of genes, 
%               and c is the number of experimental conditions.  The order
%               of genes must be the same as the 'labels' vector.
%
%       labels: A cell array of strings where each cell is a label for one
%               row in the data matrix.
%               
%       col_labels: A row vector of strings that are labels for each column
%                   in the data matrix.
%
%       num_clusters:   The number of cluster the clustering algorithm
%                       should use.
%
%       file:   A string for the name of the output file without a file
%               extension.
%
%       outpath:    A string containing the path to the folder the output
%                   file should be saved in.
%
%       dis_metric: The distance metric the clustering algorithm should use.
%                   Can be one of: 
%                   'Euclidean Distance' or 'Pearson''s Correlation'
%
%       alg: The clustering algorithm to use.  Can be one of:
%            'K-means' or 'Hierarchical'
%
%       colormap:   The colormap used to create the heatmaps.  Can be one
%       of: 'yellow-blue' or 'red-green'
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

tmp = size(data);   % needed to get number of rows and columns
num_rows = tmp(1,1);    % the number of genes
num_col = tmp(1,2);    % the number of time series


%  Step 1: Figure out the input clustering algorithm, and properly assign
%  dis_metric, then cluster data

dismeasure = '';
okalgs = {'K-means','Hierarchical'};
okmeasures = {'Euclidean Distance', 'Pearsons Correlation', 'City Block', 'Cosine'};

a = strmatch(alg, okalgs);
m = strmatch(dis_metric, okmeasures);
switch(a)
  case 1  % clustering algorithm = kmeans
         switch(m)
             case 1 % similarity measure = Euclid
                    dismeasure = 'sqEuclidean';
             case 2 % similarity Measure = correlation
                    dismeasure = 'correlation';
             case 3 % similarity Measure = City Block
                    dismeasure = 'cityblock';
             case 4
                    dismeasure = 'cosine';
         end
        % now cluster using kmeans
         clustering = kmeans(data, num_clusters, 'distance', dismeasure, ...
             'EmptyAction', 'singleton');

  case 2  % clustering algorithm = hierarchical
         switch(m)
             case 1 % similarity measure = Euclid
                    dismeasure = 'euclidean';
             case 2 % similarity Measure = correlation
                    dismeasure = 'correlation';
             case 3 % similarity Measure = City Block
                    dismeasure = 'cityblock';
             case 4
                    dismeasure = 'cosine';
         end
         % now cluster using hierarchical
         clustering = dendroCluster(data, num_clusters, file, outpath, ...
             'pdist', dismeasure, 'linkage', 'average' );
end



% re-order the cluster assignments by decreasing cluster size
clustered_solution = order_by_clustsize(transpose(clustering));
        

% write the clustering results to a text file

textfile = strcat(outpath, file, '.txt');
fid = fopen(textfile, 'w');
fprintf(fid, 'cluster#\tGeneID\t');

% print column headers
for j=1:num_col
    fprintf(fid,'%s\t', col_labels{j});
end


% print cluster assignment and raw data
for n=1:num_rows
   fprintf(fid, '\n%d \t %s \t', clustered_solution(n), char(labels(n)));
   for c=1:num_col
       fprintf(fid, '%s\t', num2str(data(n,c)));
   end
end
   
fclose(fid);


