% linear regression using svd and minimizing (Ax - b)
%usage: [bhat, uncertainties] = leastSquaresSVD(A,b);
% A is the independent variable (usually time), b is dependent 
% units of x are d[b]/d[A]. Note most CCSM data is in units of days
% Caution:  for 3D data dimensions of b MUST be (time, x, y) 

function [x, uncertainties] = leastSquaresSVD(time,b);
if ndims(b) > 2
   nt = size(b,1); nx = size(b,2); ny = size(b,3);
   ns = nx*ny; % number of spatial points
   b = reshape(b,nt,ns);
   flag = 1;
   disp('Trend calc assumes dimensions are (time,x1,x2)');
end

A = ones(numel(time),2); % intercept & slope
A(:,2) = time;
[U,S,V] = svd(A,0);
W = diag(1./diag(S));
x = (V*W*U')*b;
Covmat = V*W.^2*V';
[n m] = size(A);
errs= ((A*x-b).^2./(n-m)); % estimate uncertainties
redchisqr = sum(errs(:));
Covmat = redchisqr*Covmat;  
uncertainties = sqrt(diag(Covmat)); %uncertainties in coefficients

if flag ==1
    x = reshape(x,2,nx,ny);
end
