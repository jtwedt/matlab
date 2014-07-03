% function [lags,rho] = lagcor(xx,yy,mlag)
%  computes the lagged correlation between xx and yy
%
%	remove the means first
% 		[because XCORR does NOT uses 'coeff' 
%		(normalizes autocorrelation to one)]
%	computes correlation for a maximum of mlag lags 
%	returns the correlation and lags
%
%	lag<0, xx leads yy
%	lag>0, xx lags yy
%
function [lags,rho] = lagcor(xx,yy,mlag)

% remove means
xp=xx-mean(xx);yp=yy-mean(yy);
rho=xcorr(xp,yp,mlag,'coeff');
lags=-mlag:mlag;

figure;clf
plot(lags,rho);grid on
axis([-mlag-1 mlag+1 min(rho)-0.1 max(rho)+0.1])
text(-mlag/2,min(rho),'xx leads yy')
text(mlag/2-2,min(rho),'yy leads xx')

