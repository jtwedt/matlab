% seasonal_climo.m
% usage: output = seasonal_climo(data,time, season);
% format season is a vector with months to average. 1 = january
% e.g. season = [12 1 2] for DJF
% time is in months, and first month is January
% time is also the first dimension of the data
function output = seasonL_climo(data,time,season);
season = season(:);
nmonths = length(season);
disp('I assume the data begins in January and the first dimension is time!');

weights = [31 28 31 30 31 30 31 31 30 31 30 31]'./31;
wtd_season = weights(season);
ntime = length(time);
nyrs = floor(ntime/12);
ii = 0:nyrs-1;


if ndims(data)>2
  x1= size(data,2);
  x2 = size(data,3);
  tempAvg = zeros(nmonths,x1, x2);
        for k = 1:nmonths
                ind = ii.*12 + season(k);
		monthly_weighted = data(ind,:,:).*wtd_season(k);
		assert(ndims(monthly_weighted)==3);
        	tempAvg(k,:,:) = squeeze(mean(monthly_weighted,1));
	end


else
	tempAvg = zeros(nmonths,1);
        for k = 1:nmonths
                ind = ii.*12 + season(k);
        	monthly_weighted = data(ind).*wtd_season(k);
		tempAvg(k) = mean(monthly_weighted);

	end


end

output = squeeze(mean(tempAvg,1));
