function [ ] = changecolor(CM)
%CHANGECOLOR  This function simply creates a new blue-yellow colormap with the
%exp_colormap function, then sets the colormap of the current image to the
%new one.
%
%   Usage:  changecolor();
%
%   Note: This method requires no input because it uses the current figure
%   handle that is in the system memory.  To apply this method to the
%   appropriate figure make sure it is the current (top) figure.
%
%   Author:  Amy Olex
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

if(strcmp(CM, 'blue-yellow'))
  C = exp_colormap('blue-yellow',64);
  colormap(C) 
end
if(strcmp(CM, 'red-white-blue'))
  C = exp_colormap('red-white-blue',64);
  colormap(C) 
end