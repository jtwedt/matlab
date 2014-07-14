% function h = polarplot(pcolordata, lon, lat,colormap)
% This function plots pcolor data on an equal azimuthal polar projection


function h = polarplot(data, lonm, latm, cmap)
h = figure;
load coast;
axesm('eqaazim', 'Frame', 'on', 'Grid', 'on','MapLatLimit',[-50 -90],...
   'mlabelparallel', -55, 'parallellabel', 'on', 'meridianlabel', 'on', ...
    'fontcolor', [1 1 1], 'labelformat', 'none', 'plabellocation', [-80 -70],...
    'PLineLocation', 10)
pcolorm(latm,[lonm; lonm(1)],[data; data(1,:)]')
plotm([lat; lat(1)],[long ;long(1)], 'k'); 
patchm(lat, long, [0.5 0.5 0.5])
%caxis([.2 .8])
colorbar
if nargin == 4; colormap(cmap); end
%getm(gca)