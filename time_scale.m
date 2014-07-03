% function [autocor,tau] = time_scale(xx)
% finds the autocorrelation of xx and
% integral time scale (tau) 
%
% computes the lagged autocorrelation of xx
% integrates autocorrelation to get integral time scale
%
function [autocor,tau] = time_scale(xx)
% compute autocovariance
mlag=round(length(xx)/2);
rho=xcov(xx,mlag,'unbiased');
% keep only one side of the symmetric autocovariance
% normalize to get correlation
corr=rho(mlag+1:2*mlag+1)/rho(mlag+1);
lags=0:mlag;

% integral time scale 
% integrate out to first zero crossing
% (using trapezoid rule)
tau=0.;
i=1;
	while corr(i)>=0
	tau=tau+(corr(i)+corr(i+1))/2;
	i=i+1;
    end
autocor=corr;    % save autocorrelation
