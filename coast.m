function ll = coast
%COAST coastline data
%  
%  ll = COAST returns the world vector shoreline in the coast MAT-file as a 
%  two-column vector of latitudes and longitudes in degrees.
%  
%  See also COAST.MAT, WORLDLO, USALO, USAHI

% Copyright 1996-2002 Systems Planning and Analysis, Inc. and The MathWorks, Inc.
% $Revision: 1.5 $  $Date: 2002/03/20 21:27:12 $

load coast
ll = [lat,long];

