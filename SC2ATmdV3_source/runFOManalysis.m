function [ opti_range ] = runFOManalysis( clust_list, data, method_list, metric, graph_title, savepath, fileformats )
%RUNFOMANALYSIS A script to run and plot the adjusted FOM2 analysis
%  This script is used in the GUI.  The data should have already been loaded into 'data'.  
%  This code only needs the data and not the labels.
%  This script runs the designated clustering methods through the FOM
%  analysis.
%
%   runFOManalysis is a script designed to integrate all the clustering and
%   FOM code into one function.  First it clusters the data based on the
%   specified methods, then it calculates the FOM score for each clustering
%   method, finally the FOM scores are plotted and the graph is saved.
%
%   USAGE:  >>runFOManalysis([2,4,6,8,10], datamatrix, ['kmeans','hierarchical'], 'euclid', 'myfilename', 'C:/', {'fig', 'jpg'})
%
%   Variable Description:
%       clust_list: This is a monotonically increasing array of integers.
%       The length of this vector defines how many times the FOM analysis
%       will iterate, and the integers specify the number of clusters that
%       should be used in each consecutive iteration.  Hence in the example
%       above both k-means and hierarchical clustering will be evaluated
%       with the FOM 5 time use 2 clusters, then 4 clusters, then 6
%       clusters, then 8 and 10 clusters.
%
%       data:   A nxc real values matrix where n is the number of genes and
%       c is the number of experimental conditions.
%
%       method_list:  A column vector of strings, where each string is a
%       clustering method the use in the FOM analysis.  Currently only
%       'kmeans' and 'hierarchical' are valid entries; either one may be
%       entered alone, or they can be input together.
%
%       metric:  The similarity measure each clustering algorithm should
%       use.  Currently only 'euclid' and 'correlation' are avaliable.
%       'euclid' runs hierarchical clustering with the standard Euclidean
%       distance, and runs k-means with Squared Euclidean distance.
%
%       graph_title:  The that the FOM plot should be saved under.  Do not
%       include a file exptension.
%
%       save_path:  the path the graph should be saved to.
%
%   Acknowledgments:
%       Code Author:    Amy Olex
%       Figure Of Merit Scores: Mathematical scoring methods from the 
%           following Technical Report which became a published paper:
%           Yeung,KY; Haynor,DR; and Ruzzo,WL (2001) "Validating
%           Clustering for Gene Expression Data". Bioinformatics, Vol.17 No.4,
%           309-318.
%           Note:  The published paper does not have the FOM Range or Ratio
%           scoreing in it, that came from the techincal report which can
%           be found at http://faculty.washington.edu/kayee/cluster/
%       
%       Last Revised:  4/14/07
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

% output file variable
filetitle = strcat(savepath, graph_title, '.txt');
fid=fopen(filetitle, 'w');

fprintf(fid, '\nFigure of Merit analysis using the original Euclidean-biased FOM.\n');

list_length = length(clust_list);
fprintf(fid, 'Cluster list: %s', num2str(clust_list));

% The clustering algorithm that is determined to be the best, is the one 
% with the lowest average FOM score over all iteration specified by
% clust_list.  Therefore, once each algorithm is run through the FOM
% analysis, the mean scores are calculated and saved in an array at a
% specifice position.  The 'mean_arry' is this array where
% mean_arrr(1)=random average, mean_arry(2)=hierarchical average, and
% mean_arry(3)=kmeans average FOM score over all iterations.

% create the Mean Array.  
mean_arry = zeros(1,3);

%Mean Array position #1 %%%%%%%%  Random Section.  The random method is always done, so do first.
R = zeros(list_length,1);
for c=1:list_length
    [R(c,1)] = FOM2_random(clust_list(c), data);
end
%update the Mean_Arry with the average of all FOM scores for each iteration
mean_arry(1) = mean(R(:,1));
%  Now graph the FOM scores, and hold the graph
h = figure(1);
plot(clust_list(:),R(1:list_length,1),'b--')
hold on;

%start compiling the legend matrix for the plots
legend_mat = ['\it random      '];


%Mean Array position #2 %%%%%%%%%  Hierarchical Section.
%  first test to see if 'hierarchical' is in the 'method_list'
%  if yes then do the hierarchical FOM

if(ismember('hierarchical', method_list))
    H = zeros(list_length,1);
    %get the proper distance metric notation
    switch metric
        case 'Pearsons Correlation'
            hmetric = 'correlation';
        case 'Euclidean Distance'
            hmetric = 'euclidean';
        case 'City Block'
            hmetric = 'cityblock';
        case 'Cosine'
            hmetric = 'cosine';
    end
    % now cluster using hierarchical clustering and perform FOM analysis
    f=statusbar('Hierarchical...');
    for c=1:list_length
       % fprintf('Hierarchical: Calculating %d Clusters\n', clust_list(c));
        [H(c,1)] = FOM2_hierarch(clust_list(c), data, hmetric);  
     
        if isempty(statusbar(c/list_length,f))
           return
        end
    end
    
    if ishandle(f)
        delete(f);
    end
    
    %update the Mean_Arry with the avg FOM score
    mean_arry(2) = mean(H(:,1));
    
    %Now graph this on the same plot
    figure(1);
    hold on
    plot(clust_list(:),H(1:list_length,1),'gd-')
    legend_mat = [legend_mat; '\it hierarchical'];
else
    %if hierarchical was not chosen, update the Mean_Arry with a really
    %high number
    mean_arry(2) = 1000;
end %if Hierarchical

%Mean Array position #3 %%%%%%%%%  Kmeans Section.
%  first test to see if 'kmeans' is in the 'method_list'
%  if yes then do the kmeans FOM
if(ismember('kmeans', method_list))
    K = zeros(list_length,1);
    %get the proper distance metric
    switch metric
        case 'Pearsons Correlation'
            kmetric = 'correlation';
        case 'Euclidean Distance'
            kmetric = 'sqeuclid';
        case 'City Block'
            kmetric = 'cityblock';
        case 'Cosine'
            kmetric = 'cosine';
    end
    % now cluster using kmeans then perform the FOM analysis
  k=statusbar('K-means...');
    statusbar('on',k)
    for c=1:list_length
       % fprintf('Kmeans: Calculating %d Clusters\n', clust_list(c));
        [K(c,1)] = FOM2_kmeans(clust_list(c), data, kmetric);

        if isempty(statusbar(c/list_length,k))
           return
        end
    end
    
    if ishandle(k)
        delete(k);
    end
    
    %update the Mean_Arry with the average FOM score
    mean_arry(3) = mean(K(:,1));
    %Now graph this.
    figure(1);
    hold on
    plot(clust_list(:),K(1:list_length,1),'r*-')
    legend_mat = [legend_mat; '\it kmeans      '];
else
    %if kmeans was not selected update the Mean_Arry to a really high
    %number
    mean_arry(3) = 1000;
end %if Kmeans


% Determine which algorithm is better using the lowest average FOM2 score.

R_mean = mean_arry(1);
H_mean = mean_arry(2);
K_mean = mean_arry(3);

if R_mean < H_mean && R_mean < K_mean
    opti_fom2 = R;
  %  disp('Optimal Cluster Algorithm is Random');
    fprintf(fid, '\nOptimal Cluster Algorithm is Random');
elseif H_mean < K_mean && H_mean < R_mean
    opti_fom2 = H;
  %  disp('Optimal Cluster Algorithm is Hierarchical');
    fprintf(fid, '\nOptimal Cluster Algorithm is Hierarchical');
elseif K_mean < H_mean && K_mean < R_mean
    opti_fom2 = K;
  %  disp('Optimal Cluster Algorithm is K-means');
    fprintf(fid, '\nOptimal Cluster Algorithm is K-means');
end

% write the opti_fom2 array values to a text file here

if(ismember('hierarchical', method_list))
    fprintf(fid, '\n\nHierarchical \nClusters: ');
    fprintf(fid, '%5.0f\t', clust_list);
    fprintf(fid, '\nFOMscores: ');
    fprintf(fid, '%5.2f\t', H);
end
if(ismember('kmeans', method_list))
    fprintf(fid, '\n\nK-means \nClusters: ');
    fprintf(fid, '%5.0f\t', clust_list);
    fprintf(fid, '\nFOMscores: ');
    fprintf(fid, '%5.2f\t', K);
end

fprintf(fid, '\n\nRandom \nClusters: ');
fprintf(fid, '%5.0f\t', clust_list);
fprintf(fid, '\nFOMscores: ');
fprintf(fid, '%5.2f\t', R);

% Put finishing touches on the graph
figure(1);
hold on
xlabel('Number of Clusters')
ylabel('FOM 2-norm score')
title({'Adjusted FOM 2-norm', graph_title})
legend(legend_mat, 'Location', 'Best')
grid on


if list_length >= 3
    %get the optimal cluster range
    opti_range = FOM2_opticluster(opti_fom2, clust_list);
    %disp('The Optimal Cluster Range is');
    %opti_range
    fprintf(fid, '\n\nThe Optimal Cluster Range is [%s]', num2str(opti_range));

    % notify the user what the optimal cluster number range is
    msg = strcat('The optimal number of clusters range from ', num2str(opti_range(1)), ' to ', num2str(opti_range(2)), ' clusters.');
else
    msg = 'The optimal number of clusters could not be calculated due to the small number of cluster intervals.'
end

%save the figure in all the formats and close the text file

for f=1:length(fileformats)
    saveas(h, strcat(savepath, graph_title), char(fileformats(f)) );
end
    
msgbox(msg, 'Optimal Number of Clusters');


fclose(fid);
   
   
   