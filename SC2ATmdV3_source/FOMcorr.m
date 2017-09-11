function [ avg_corrcoef ] = FOMcorr( gene_matrix )
%FOMCORR Finds the average pair-wise correlation for a given set of vectors
%   Input matrix must have vectors in the rows, and it will be transposed
%   prior to input into the corr function.  This returns the average
%   1-corrcoef, so the closer to zero the more positively correlated.
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


% Get the correlation matrix
corr_mat = 1-corr(transpose(gene_matrix));

% Get dimensions of corr_mat
mat_size = length(corr_mat);

% find the size of the lower part of the pxp matrix not including the
% diagonal (p(p-1))/2 then multiple it by 2 to get p(p-1).
lowerTimes2 = mat_size*(mat_size-1);

% calculate the average correlation for these genes.
avg_corrcoef = (sum(sum(corr_mat))/lowerTimes2);

% In the last line the double sum includes all values in the entire nxn
% matrix even though half of these are redundant.  For this reason, it is
% necessary to divided by 2, thus the division by 2 is done when the lower
% size of the lower portion of the matrix is calculated to ruduce the
% computation.