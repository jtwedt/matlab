% function data_filt=filterfb(b,a,data);
% 
% applies a filter to the vector data
% problem: Matlab function "filter" phase shifts the data
%   and zeros the end points
% solution:
% 1) remove the mean (to minimize end point problems)
% 2) run filter forward (shifts data right)
% 3) reverse the filtered data and run filter again
% 4) reverse after second filter 
% 5) add the mean back
%
% better method: use filtfilt in the Signal Processing Toolbox
%
function data_filt=filterfb(b,a,data);
davg=mean(data);
da=data-davg;
df=filter(b,a,da);
db=filter(b,a,flipud(df(:)));
data_filt=flipud(db)+davg;

