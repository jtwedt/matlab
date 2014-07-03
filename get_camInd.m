% function [x1 x2 y1 y2] = get_camInd(lat1 lat2 lon1 lon2);
% retrieves the indices for a given range of coordinates
% Usage: [ x1 x2 y1 y2] = get_camInd(lat1 lat2 lon1 lon2);

function [x1 x2 y1 y2] = get_camInd(lat1, lat2, lon1, lon2);

load('lat_CAM.mat');
load('lon_CAM.mat');

xt1 = abs(lon_CAM - lon1);
xt2 = abs(lon_CAM - lon2);
yt1 = abs(lat_CAM - lat1);
yt2 = abs(lat_CAM - lat2);

x1 = find(xt1 == min(xt1(:)));
x2 = find(xt2 == min(xt2(:)));
y1 = find(yt1 == min(yt1(:)));
y2 = find(yt2 == min(yt2(:)));

