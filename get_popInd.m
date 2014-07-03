% function [x1 x2 y1 y2] = get_camInd(lat1 lat2 lon1 lon2);
% retreives the indices for a given range of coordinates
% Usage: [ x1 x2 y1 y2] = get_camInd(lat1 lat2 lon1 lon2);

function [x1 x2 y1 y2] = get_camInd(lat1, lat2, lon1, lon2);
disp('latitude range: ', lat1, ': ', lat2);
disp('longitude range: ',lon1, ': ', lon2);

load('lat_POP.mat');
load('lon_POP.mat');

xt1 = abs(lon_POP - lon1);
xt2 = abs(lon_POP - lon2);
yt1 = abs(lat_POP - lat1);
yt2 = abs(lat_POP - lat2);

x1 = find(xt1 == min(xt1(:)));
x2 = find(xt2 == min(xt2(:)));
y1 = find(yt1 == min(yt1(:)));
y2 = find(yt2 == min(yt2(:)));

