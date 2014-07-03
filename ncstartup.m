function ncstartup

% ncstartup -- Startup script for the NetCDF Toolbox.
%  ncstartup (no argument) adjusts the Matlab path
%   to include the components of the NetCDF Toolbox.
%   A call to this "ncstartup" script should be made
%   during Matlab startup, such as from within the
%   "startup" script that is reserved for just such
%   purposes.  Adjust the path below as needed.
 
% Copyright (C) 1997 Dr. Charles R. Denham, ZYDECO.
%  All Rights Reserved.
%   Disclosure without explicit written consent from the
%    copyright owner does not constitute publication.
 
% Version of 03-Jul-1997 09:09:29.

% These statements assume that the NetCDF Toolbox is
%  located in the conventional Matlab "toolbox" area.
%  Adjust as needed.

[stat,hn]=system('hostname');
%HN = (strcmp(hn(1:3),'oly'))|(strcmp(hn(1:3),'fra'));
%if HN
  toolbox_area = '/fs/home/jtwedt/matlab/mexcdf';
  toolbox_area = '/glade/u/home/jtwedt/matlab/mexcdf';

%  path(path, fullfile(toolbox_area, 'netcdf_toolbox', ''))
%  path(path, fullfile(toolbox_area, 'netcdf_toolbox/netcdf', ''))
%  path(path, fullfile(toolbox_area, 'netcdf_toolbox/netcdf/ncutility', ''))
  path(path, fullfile(toolbox_area, 'mexnc', ''))
  path(path, fullfile(toolbox_area, 'snctools', ''))
%  path(path, fullfile(toolbox_area, 'matlab_netcdf_5_0', ''))




%end
