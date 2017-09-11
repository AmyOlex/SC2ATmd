function [dirname, filename, format] = GetFileInfo(fullfilename)
% GETFILEINFO This function extracts directory, filename and format from
% Input can also be without the directory name
%
%   Author: Vaibhav Srivastava, 2005
%   Source: Matlab Central File Exchange
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


last_dot = 0;
braces = strfind(fullfilename,'\');
dot = strfind(fullfilename,'.');

% If input is actually a directory so it will not contain 
% any dot hence return top directory name
if(~length(dot))
    pos_last_brace = braces(length(braces));
    dirname = fullfilename(1:pos_last_brace-1);
    filename = 'Input was directory';  
    format   = 'Input was directory';  
    return;
end

last_dot = dot(length(dot));
format = fullfilename(last_dot+1:end);

try
    pos_last_brace = braces(length(braces));
    dirname = fullfilename(1:pos_last_brace-1);
catch
    dirname = 'Does not exist';
    pos_last_brace = 0;
end
filename = fullfilename(pos_last_brace+1:last_dot-1); 


