% monthly_climo.m
% This makes weighted averages of monthly climatologies
% input: data vector or matrix of monthly values
%        time vector
%        number of desired month
 function output = monthly_climo(data, time, month);
     disp('I assume the data begins in January and the first dimension is time!');
     nyrs = floor(length(time)/12);
     ii = 0:nyrs-1;
     ind = 12.*ii + month; 
     if ndims(data)==3
	     output = squeeze(mean(data(ind,:,:),1));
     elseif  ndims(data) == 2
       	    output = mean(data(ind)) 
    else error('Incompatible number of dimensions');

    end
	

