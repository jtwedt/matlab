% function [U,S,V,frac]=eof_svd(data)
%
% Computes eofs of data using singular
% value decomposition (SVD)
%  U*S*V' = data
% 
% If the data are entered into the matrix, data, such that the 
% rows are time series and columns correspond to locations, then
%   U columns are the orthogonal spatial functions
%   S diagonal contains singular values (square root of eigenvalues) 
%   V columns are the orthogonal and normalized time series
%
% If D is M X N, then only the p=min(M,N) columns of U and V are 
% computed and returned (to save computation time)
%
% To get the dimensional time series
%   A(t) = (V*S')'
%
% also finds frac(tion) of variance in each eof using the
%    diagonal singular value matrix, S
%
function [U,S,V,frac]=eof_svd(data)
[m,n]=size(data);p=min(m,n);
[U,S,V]=svd(data,'econ');		% 
Sp=S(1:p,1:p);
lambda=Sp*Sp';
var=trace(lambda);
frac=diag(lambda)/var;


