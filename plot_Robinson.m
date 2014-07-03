




function plot_Robinson(field, lat, lat_lim, lon, lon_lim,title)

landareas = shaperead('landareas.shp', 'UseGeoCoords', true);
axesm('robinson', 'Frame', 'on', 'Grid', 'on', 'origin', [0 -150 0]);
warning off;
[latg long] = meshgrid(lat,lon);
k  = numel(lon);
j = [1:k 1];

pcolorm(latg(j,:)',long(j,:)',field(:,j)); shading flat;
geoshow(landareas,'Facecolor',[1 1 1]*0.5,'edgecolor',[1 1 1]*0.5);


axis([-3 3 -1.5 1.5])
%P=get(gca,'position'); P(3:4)=1.15*P(3:4); P(1)=P(1)-0.05; set(gca,'position',P);

clb = colorbar('horiz');
set(clb, 'fontsize', 14);
%set(gca, 'position', P);
%Pc = get(clb,'position');
%Pc(1) = 0.365; Pc(2) = 0.07;
%set(clb, 'position', Pc);




