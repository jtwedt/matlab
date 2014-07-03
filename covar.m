% function cov = covar(var,ds,Ls,dt,Lt)
%
% covariance for lags in two dimensions
% cov=var*exp(-ds.^2/Ls^2-dt/Lt);
% 
% lags ds and dt may be vectors
% dimensions can be any combination of x, y, t, etc
%
function cov = covar(var,ds,Ls,dt,Lt)
cov=var*exp(-ds.^2/Ls^2-dt./Lt);
