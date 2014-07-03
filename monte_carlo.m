% function [r5,r95]=monte_carlo(mstar,nstar)
% monte carlo (Preisendorfer's selection rule N)
%
% Given degrees of freedom in the data set,
% compute the 90% confidence limits for significant
% eigenvalues, using the fraction of variance to
% normalize the eigenvalues

 function [r5,r95]=monte_carlo(mstar,nstar)

% create random amplitudes for N(0,1) distribution
fracr=[];
% repeat 100 times
	for k=1:100
% create random amplitudes for N(0,1) distribution
	R=randn(nstar,mstar);
	[u,s,v,frac]=eof_svd(R);
% variance ratio (use vector frac(tion))
	fracr(:,k)=frac;
   	end

% rank(sort) ratios (descending order)
rank=sort(fracr')';
r95=rank(:,95);
r5=rank(:,5);

