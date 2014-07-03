% function [correlation,ratio,norm_error]=taylor_eval(x,y)
%
% computes variables for Taylor diagram
% for estimate y compared with "truth" x
% 
% 1) computes correlation
% 2) computes amplitude_ratio: std(y)/std(x) 
% 3) computes normalized error 
%
% error_norm is the distance from correlation=1.0 and ratio=1.0,
% which is the rms error as a fraction of truth std dev
%
% Kathie Kelly, April 2010
%
function [correlation,ratio,norm_error]=taylor_eval(x,y)
%
[correlation,df,rho_sig95] = correlate(x,y);
ratio=std(y)/std(x);
% compute theta, rr, normalized error (distance)
theta=acos(correlation);    % compute correlation angle
rr=ratio;
xx=rr*cos(theta);yy=rr*sin(theta);
norm_error=sqrt((xx-1)^2+yy^2);




