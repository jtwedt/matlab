%%%%%%%%%%%%%
% Use QR factorization to compute a least squares linear fit (Ax = b)
% b can be a matrix or column vector
% A is a column vector with same length as the rows/lenth of b
% x is a slope with units d[b]/d[A] 
% usage: function [x,res] = leastSquares1(A,b);
% 6/26/13
%%%%%%%%%%%%%

function [x,res] = leastSquares1(A,b);

if size(b,1)==1
	b = b(:);	
end
[Q R] = qr(A,0);
x  = R\(Q'*b);
end
res = b - A*x;


