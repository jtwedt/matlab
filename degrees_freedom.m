% function [mstar,nstar]=degrees_freedom(data);
%
% find degrees of freedom in data matrix, where
% [M,N]=size(D)
%
%	1) compute lagged autocovariance matrix for
%		each row (column)
%	2) average over all columns (rows)
%	3) integrate from zero lag to the first zero crossing
%		to get decorrelation scales, tauM, tauN 
%	4) compute degrees of freedom as 
%       mstar=M/tauM
%       nstar=N/tauN
%
% Note: since no units are entered, tau and record length
%		are given in relative units
%       degrees of freedom is at most the no. of points in record
%
function [mstar,nstar]=degrees_freedom(data);
[m,n]=size(data);
covi=[];
	for ii=1:n
	xx=data(:,ii);
   covi(:,ii)=xcov(xx,xx,'coeff');
	end
covx=mean(covi');
% integrate until zero crossing
tau=0.;
i=m;
	while covx(i)>=0
	tau=tau+(covx(i)+covx(i+1))/2;
	i=i+1;
	end
mstar=min(m,round(m/tau));

covi=[];
	for ii=1:m
	xx=data(ii,:);
	covi(:,ii)=xcov(xx,xx,'coeff')';
	end
covt=mean(covi');
% integrate until zero crossing
tau=0.;
i=n;
	while covt(i)>=0
	tau=tau+(covt(i)+covt(i+1))/2;
	i=i+1;
	end
nstar=min(n,round(n/tau));
