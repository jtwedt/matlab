% function y = deriv(x,del)
%
% takes first centered difference of x
%  y(i) = [x(i+1) - x(i-1) ]/(2*del)
%
% returns zero for y(1) and y(last)
% only works on column vectors
%
function y=deriv(x,del)
x=x(:);                 % make sure x is a column vector
mm=length(x);
y=zeros(mm,1);
for i = 2:mm-1
  y(i)=(x(i+1)-x(i-1))/(2.*del);
end

