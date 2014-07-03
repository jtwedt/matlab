% function [b,a]=lowpass_create(N,dx,half_power);
%
% creates a filter to be run with lowpass.m
%
% dx is the length of the sample interval 
% half_power is the desired half-power point 
% N is the filter length (larger N gives smoother weights)
%     
% EXAMPLE: dx = 6 km (Nyquist = 12 km)
%          half-power = 48 km
%  Wn = 12/48 or 1/6
%  [b,a]=butter(N,Wn)
%
% half power occurs for response = 0.7
%
function [b,a]=lowpass_create(N,dx,half_power)
Wn=(2*dx)/half_power;
[b,a]=butter(N,Wn);  
 
% w=1 corresponds to the Nyquist frequency
% [h,w]=freqz(b,a,N);
% figure(1)
% plot(w/pi,abs(h),'r'),grid
% xlabel('Nyquist frequency = 1 ( the sample rate)')
