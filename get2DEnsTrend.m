%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  function [coeffs_Ens coeffs_members annMeanEnsMean stddev] = get2DEnsTrend(exper,EnsNos,suffix,field, %   startyr, units)

% Judy Twedt 1/26/14
% Calculates -  temporal trend from of ensemble mean of ann mean anomalies.
%	     -  ensemble mean of annual mean
%	     -  std dev of ens mean ann mean (shows temporal variability)
%        -  coeff of linear regression of the ensemble and each member
% The seasonal cycle has been removed. 
% Note this does NOT filter out NAN's, land, or anything else
%Inputs : exper - prefix for experiment (eg TTGA)
%         EnsNos - ensemble numbers in a cell array
% 	      field - name of variable
%	      suffix - end latter part of filename
%         tInt  -- specify indices of desired time interval
% example: datFile = [exp, EnsNo(i), suffix] for
%	              TTGA05.TS.1980-2012.globalmean.nc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [coeffs_Ens coeffs_members annMeanEnsMean stddev] = get2DEnsTrend(exper,EnsNos,suffix,field, startyr, units,tInt)

%exper = 'TTGA'; EnsNos = {'07', '08', '09'};
%suffix = 'ICEFRAC.1980-2012.nc'; field = 'ICEFRAC';
%startyr = 1980; units = 'fractional ice cover';

nEns = length(EnsNos);
fname = [exper  EnsNos{1} '.' suffix];
time = nc_varget(fname, 'time'); time = time(tInt);
ntime = length(time);
nyrs = floor(ntime/12);
lat = nc_varget(fname, 'lat'); lon = nc_varget(fname, 'lon');
ny = numel(lat);
nx = numel(lon);

monthlyAnom= zeros(ntime,ny,nx,nEns);
annEns = zeros(nyrs,ny,nx,nEns);

for j = 1:nEns;
    fname = [exper, EnsNos{j},'.', suffix];
    data = nc_varget(fname, field); 
    data = data(tInt,:,:);
    annEns(:,:,:,j) = month2ann(data,time,nx,ny);
    disp('.');
end   

annMeanEnsMean = squeeze(mean(annEns,4));
stddev = squeeze(std(annMeanEnsMean,0,1));
% find the trends:
trend_members = zeros(2,ny,nx,nEns);
time_am = [startyr:startyr+nyrs-1]';
[trendEns,uncertainty] = leastSquaresSVD(time_am, annMeanEnsMean);
R = uncertainty(2); %NOTE uncertainty(1) > 1. Does this make sense?
coeffs_Ens = squeeze(trendEns(2,:,:));

for k = 1:nEns
    [trend_members(:,:,:,k),uncert] = leastSquaresSVD(time_am,squeeze(annEns(:,:,:,k)));
end
    
coeffs_members = squeeze(trend_members(2,:,:,:));


