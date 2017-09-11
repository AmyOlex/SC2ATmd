function z = reverse(A)
%REVERSE reverses the order of elements in a one-dimensional MATLAB ARRAY
% or reverse each column order in a 2D matrix
% ARRAY2 = REVERSE(ARRAY1)
%   ARRAY1 can be numeric, char (string), or cell array
%
%   Author: Unknown
%   Source: Matlab Central File Exchange
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

S = size(A);
row = S(1);
col = S(2);

if row==1 || col==1

    L = length(A);

    if iscell(A)
       z = cell(size(A));
       for i=1:L
          z{i} = A{L-i+1};
       end
    elseif isnumeric(A)
       z = zeros(size(A));
       for i=1:L
          z(i) = A(L-i+1);
       end
    elseif ischar(A)
        z = char(reverse(double(A)));
    end

else
    z = zeros(size(A));
    for i=1:col
        z(:,i) = reverse(A(:,i));
    end
end

