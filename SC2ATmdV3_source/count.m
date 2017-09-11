function Result = count(data,condition)
%COUNT Counts the number of elements in A that match the criteria specified in B.
% 
%   Usage: count(A,B)
%   Example:
%   >> Data = [1 2 3 4 3 2 7 6 9 1 1 2 5 9 9];
%   >> count(Data,'==9')
%   >> ans =
%           3
%
% Author:  Richard Medlock, 2001.
% Source:  Matlab Central file exchange
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

nElements = length(data);
IndexIDs = 1:nElements;
Result = eval(['data' condition]);
Result = IndexIDs(Result);
Result = length(Result);

