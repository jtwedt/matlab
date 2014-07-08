%function[annAvg] = month2ann(dat, time, varargin);
%This returns the annual average from monthly values (units in days)
% Note this starts on the 1st time elt, whether it's jan or june!
% And dat (data)  is a vector
%usage: month2ann(data,time,nlon, nlat) 
% nlat and nlon are optional and only needed for spatial data

function[annAvg] = month2ann(dat, time, varargin);

time = time(:);
startday = mod(time(1),365)
if startday <= 31
    weights = [31 28 31 30 31 30 31 31 30 31 30 31]/31; % no leap year
else
    error('First month must be January')

end


ntime = length(time);
nyrs = floor(ntime/12);
if ndims(dat)>2
  nlon = varargin{1};
  nlat = varargin{2};
  annAvg = zeros(nyrs,nlat, nlon);
  wtMat = ones(12,nlat,nlon); 
  wtMat = bsxfun(@times,weights', wtMat);
	for k = 1:nyrs
        	ii = 1+12*(k-1);
		weighted_dat = bsxfun(@times, dat(ii:ii+11,:,:), wtMat); 
		%annAvg(k,:,:) = squeeze(mean(dat(ii:ii+11,:,:),1));
	         annAvg(k,:,:) = squeeze(mean(weighted_dat,1));
	end 

else
	for k = 1:nyrs
        	 ii = 1+12*(k-1);
                weighted_dat = weights'.*dat(ii:ii+11);
          	%annAvg(k) = mean(dat(ii:ii+11),1);
	 	annAvg(k) = mean(weighted_dat);	
	end
end
