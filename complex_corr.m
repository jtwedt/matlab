% function [r,theta,corr,ratio] = complex_corr(x,y)
%
%  computes the complex correlation between
%  the series of vectors x=[u1,v1] and y=[u2,v2]
%
% Note: enter vector components as real nos. in two columns
% removes the means if not already zero
%
% interpretation:
%   for vectors with same length and angular difference:
%       degrees         r
%           0         1 + 0i
%          90         0 + 1i
%         180        -1 + 0i
%         270         0 - 1i
%  
% same direction, different lengths,
%     r = rho + 0i, where rho is correlation
% of the lengths
%
% theta is the angle (degrees) of y wrt x, in 
%          counterclockwise direction
% 
% corr is the magnitude of r
%
% ratio is defined as:
%       ratio=sqrt(vary)/sqrt(varx);
% where the means of x,y have been removed
%
function [r,theta,corr,ratio] = complex_corr(x,y)
 [m,n]=size(x);
% convert to complex
  xc=x(:,1)+i*x(:,2);
  yc=y(:,1)+i*y(:,2);
% demean
  xc=xc-mean(xc);yc=yc-mean(yc);
  prod=xc'*yc;
  varx=xc'*xc;
  vary=yc'*yc;
% with means removed, rms is identical with std dev
  ratio=sqrt(vary)/sqrt(varx);
  r=sum(prod)/sqrt(varx*vary);
  theta=atan2(imag(r),real(r))/pi*180;
  corr=abs(r);
