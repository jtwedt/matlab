
%function [amp,phase,frac,offset,ya]=fit_harmonics(y,t,nharm,L,cutoff)
%
% given times t and cycle length L and data in y:
%	computes annual cosine harmonics (n=1:nharm)
%         fn(t) = a(n) * cos(2*pi*n*t/L + phase(n)) + b 
%
%  if fraction of variance is > cutoff/100, removes harmonic
%		otherwise, sets amp, etc to zero   
%		in any case, removes offset for first harmonic
%
% Notes: 
%	cutoff value should be given in PERCENT
%	checks for NaNs and uses only valid data   
%	L should in the same units as t 
% For example, if t is in days, L=365.25 for annual cycle, L=1 for diurnal
%
% returns positive amplitude,phase,frac(tion) of variance, and offset
%	for each harmonic
% ya is the residual time series
% 
% To construct the harmonics for a specified tt;
%    yt=offset;
%       for j=1:nharm
%       yt=yt+amp(j)*cos(2*pi*j*tt/L + phase(j));
%       end
%
function [amp,phase,frac,offset,ya]=fit_harmonics(y,t,nharm,L,cutoff)
y=y(:);t=t(:);nt=length(t);
% check for NaNs
ind=find(~isnan(y));
% skip operation if no valid data
    if isempty(ind);disp('WARNING: no valid data');
    amp=0;phase=0;frac=0;offset=0;ya=y;
    else
    yy=y(ind);tt=t(ind);
        for i=1:nharm
        Li=L/i;
        [amp(i),phase(i),offset(i),yi,frac(i)]=fit_cosine(tt,yy,Li);
% make amplitude positive
           if amp(i)<0;
           amp(i)=-amp(i);
           phase(i)=phase(i)+pi;
              if phase(i)>pi;phase(i)=phase(i)-2*pi;end
           end
           if frac(i) > cutoff/100
           yy=yi;
           else
           amp(i)=0;
           phase(i)=0;
% remove first offset even if first harmonic is not significant
              if i == 1
              yy=yy-offset(i);
              end
           end
       end
    offset=offset(1);           % just keep first offset as mean
%
% reconstruct to include NaNs
    ya=y;ya(ind)=yy;
    end

