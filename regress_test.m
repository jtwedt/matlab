
% function [alf,df1,df2,F_stat,var_red] = regress_test(y,x,npar1)
%
% computes alf, multiple regression coefficients 
%           y=X*alf 
% y is the data vector 
% x contains parameter series in columns
% 
% prediction is given by
%   y_pred = alf(1)*x(:,1) + alf(2)*x*:,2) + ... + alf(npar)
% 
% var_red: variance reduction for this estimator:(SSD-RSS1)/SSD,
% where SSD - sum of squares of data (variance of y)
%
% computes a F-statistic to evaluate variance reduction for predictor 
% using npar parameters vs. predictor with only npar1 parameters
%
% computes cross-correlations for multiple parameters
% if npar1=0, compares regression with y=mean(y)
%
% F_statistic=(RSS0-RSS1)/RSS1*(N*-npar-1)/k
%
%   where k (df2) = npar-npar1, the number of additional parameters
%   nstar - degrees of freedom of y 
%   RSS1 - residual sum of squares using all parameters
%   RSS0 - residual sum of squares using first npar1 parameters
%
% Additional k parameters justified if F statistic exceeds 95% confidence:
% df1=10 df2=1, F statistic ~ 5
% df1=100 df2=1, F statistic ~ 4
%
function [alf,df1,df2,F_stat,var_red] = regress_test(y,x,npar1)

% check/fix orientation
y=y(:);
[m,n]=size(x);
    if m~=length(y);x=x';end   % transpose if needed
%
    if m~=length(y) & n~=length(y)
    display('dimension mismatch')
    else
    [m,npar]=size(x);

% sum of squares for data
    ybar=mean(y);yp=y-ybar;SSD=yp'*yp;
% compute coefficients
    A=x(:,1:npar);A(:,npar+1)=ones(m,1);
    alf=A\y;
    ypred=A*alf;err=y-ypred;
% sum of squared residuals for all parameters
	RSS1=err'*err;
% total variance reduction for this estimator 
    var_red=1-RSS1/SSD;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% values needed for tests of significance of the estimator
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute degrees of freedom for y
	[~,tau]=time_scale(y);nstar=length(y)/tau;
% redo regression for npar1 parameters
        if (npar==1 | npar1==0);            % compare with no prediction
        RSS0=SSD;
        else
        A=x(:,1:npar1);A(:,npar1+1)=ones(m,1);
        alf0=A\y;
        ypred=A*alf0;err=y-ypred;
% sum of squared residuals for npar1 parameters
        RSS0=err'*err;
        end
	p=npar;k=npar-npar1;
	F_stat=(RSS0-RSS1)/RSS1*(nstar-p-1)/k;
	df1=nstar-p-1;
	df2=k;     
% compute cross-correlations
        if npar > 1
% correlation matrix
        xbar=ones(m,1)*mean(x);xp=x-xbar;
        cov=xp'*xp/m;sig=sqrt(diag(cov));
            for i=1:npar
            for j=1:npar
            corr(i,j)=cov(i,j)/sig(i)/sig(j);
            end
            end
        cross_correlations=corr
        end
    end
 