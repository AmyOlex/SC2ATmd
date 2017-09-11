function [ range_est ] = FOM2_opticluster( fom2_scores, cluster_nums )
%FOM2_OPTICLUSTER Calculates an estimated range for the optimal number of
%clusters based on the FOM or cFOM scores.
%  
%   This uses the change in the Y value only (Delta Y).   
%
%   This method takes in the FOM or cFOM scores in an array and the array of
%   tested cluster numbers.  Based on this information, it returns a range
%   estimate as an array of 2 numbers, and draws a box on the FOM graph.
%   This method should use equal cluster step sizes.
%
%   Steps of calculation:
%               1 - Find all the differences of FOM/cFOM scores between each pair of cluster#s
%               2 - Find the standard deviation of the data calculated in step 1
%               3 - The last cluster# pair (starting from high to low # of clusters) 
%                   that has a FOM score less than 1 std unit is the recommended range.
%
%   USAGE:  [optimal_range] = FOM2_opticluster([3.45, 2.3, .54, .2], [2,4,6,8]);
%
%   Variable Description:
%       fom2_scores: a real valued vector containing the FOM/cFOM analysis
%       results.
%
%       cluster_nums:  an integer array specifying the number of clusters
%       used for each iteration of the FOM/cFOM analysis.  Both arrays must
%       be in the same order (i.e. in the example above, 3.45 was the score
%       when 2 clusters was used, 2.3 was the score when 4 clusters was
%       used etc).
%
%   Last updated: 4/14/07
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

% Create the variables we need
fom_difs = zeros(length(fom2_scores)-1, 1);
idxrange_upper = 0;  % The index for both fom score and cluster number top of the estimated range
idxrange_lower = 0;  % The index for both fom score and cluster number bottom of the estimated range

% Perform step one
for n=1:length(fom_difs)
    fom_difs(n) = fom2_scores(n)-fom2_scores(n+1);
end

% Perform step two
dif_std = std(fom_difs);

% Perform step 3
for k=length(fom_difs):-1:1
    if fom_difs(k)>dif_std
        if k==length(fom_difs)
            idxrange_lower = k;
            idxrange_upper = k+1;
            break;
        else 
            idxrange_lower = k+1;
            idxrange_upper = k+2;
            break;
        end
    end
end

% specify box coordinates
%x = [cluster_nums(idxrange_lower)-1.5  cluster_nums(idxrange_upper)+1.5  cluster_nums(idxrange_upper)+1.5  cluster_nums(idxrange_lower)-1.5  cluster_nums(idxrange_lower)-1.5];
%y = [fom2_scores(idxrange_upper)-.4  fom2_scores(idxrange_upper)-.4  fom2_scores(idxrange_lower)+.4  fom2_scores(idxrange_lower)+.4  fom2_scores(idxrange_upper)-.4];
%hold on;
%plot(x,y,'k');
%hold off;

range_est = [cluster_nums(idxrange_lower), cluster_nums(idxrange_upper)];


