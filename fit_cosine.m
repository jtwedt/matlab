% function [a,phi,b,yy,frac_red] = fit_cosine(t,y,L)
% computes the least-squares fit of the function: 
%         f(t) = a * cos(2*pi*t/L + phi) + b 
% returns yy = y - f(t)
%
function [a,phi,b,yy,frac_red] = fit_cosine(t,y,L)
%
t=t(:);m=length(t);y=y(:);

% create A with columns [cos(alpha*t), -sin(alpha*t), 1] 
alpha=2*pi/L;
A(:,1)=cos(alpha*t);
A(:,2)=-sin(alpha*t);
A(:,3)=ones(m,1);
%
x=A\y;
phi=atan(x(2)/x(1));
% check for vanishing denominator
	if abs(cos(phi))>abs(sin(phi))
	a=x(1)/cos(phi);
	else
	a=x(2)/sin(phi);
	end
b=x(3);
yfit=a*cos(2*pi*t/L+phi)+b;
% evaluate fit
yp=y-mean(y);var=yp'*yp;
yy=y-yfit;          % residual
frac_red=1-(yy'*yy)/var;
% make amplitude positive
   if a<0;
   a=-a;
   phi=phi+pi;
      if phi>pi;phi=phi-2*pi;end
   end
