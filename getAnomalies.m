% getAnomalies.m
% Removes the annual cycle and mean from the input data
%usage: [result ]  = getAnomalies(dat, time, nharm, cutoff, L);
% only dat is required. Default vals are:
% nharm = 3; cutoff = 10; L = 365; (no leap year)

function anom = getAnomalies(dat, time,varargin);

if nargin > 2
   nharm = varargin(3);
   cutoff = varargin(4);
   L = varargin(5);
end

nharm = 3; cutoff = 10; L = 365;
[amp, phase, frac,offset, anom] = fit_harmonics(dat,time, nharm, L, cutoff);

