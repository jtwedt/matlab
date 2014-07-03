%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot1DEnsAnom
% Judy Twedt 1/26/14
% Plots annual  time series of area- weigted
% global mean anomalies. The seasonal cycle has been removed. 
%Inputs : exper - prefix for experiment (eg TTGA)
%          EnsNos - ensemble numbers in a cell array
% 	       field - name of variable
%		   suffix - end latter part of filename
% example: datFile = [exp, EnsNo(i), suffix] for
%	              TTGA05.TS.1980-2012.globalmean.nc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [monthlyAnom annAnom] = plot1DEnsAnom(exper,EnsNos,suffix,field, startyr, units)

%exper = 'TTGA'; EnsNos = {'07', '08', '09'};
%suffix = 'TS.1980-2012.globalmean.nc'; field = 'TS';
%startyr = 1980; units = 'kelvin';

nEns = length(EnsNos);
fname = [exper  EnsNos{1} '.' suffix];
time = nc_varget(fname, 'time');
ntime = length(time);
nyrs = floor(ntime/12);

monthlyAnom= zeros(ntime,nEns);
annAnom = zeros(nyrs, nEns);

for j = 1:nEns;
    fname = [exper, EnsNos{j},'.', suffix];
    data = nc_varget(fname, field);    
    monthlyAnom(:,j) = getAnomalies(data,time);
    annAnom(:,j) = month2ann(monthlyAnom(:,j),time);

end   

%Calcualte average of annual means, and find the trend:
annmean = mean(annAnom,2);
timeam = [startyr:startyr+nyrs-1]';
[trend,errs] = leastSquaresSVD(timeam, annmean);
model = trend(1) + timeam*trend(2);
R = errs(2);

figure; plot(timeam, annAnom), title(['ann mean ' field ' anomaly']); 
hold on; plot(timeam, annmean, 'LineWidth', 2);
xlabel('year'); ylabel(units);
savename = [field 'timeseries.jpg'];
saveas(gca, savename); 
