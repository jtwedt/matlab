% function ssh_heat=seasonal_heating(time,qnet,alf)
%
% Given net surface heat flux and times (in decimal years)
% Computes steric response eta by integrating
%
%     d(eta)/dt = alf*Qnet/(rho*c_p) 
%
% alf is actually alpha/(rho*cp) 
% qnet and alf must be on the same grid as "time"
% assumes time is in days
%
function ssh_heat=seasonal_heating(time,qnet,alf)

% times for integration
dt=(time(2)-time(1));       % time in days
delt=24*3600;               % # of seconds in a day
nt=length(qnet);
% integrate to get SSH
% eta(t+1) = eta(t)+ delt*alf/(rho*cp)*Qnet
eta=0;     
W=delt*dt*alf.*qnet;      
    for kk=2:nt                % start on the second day
	eta(kk)=eta(kk-1)+W(kk); 
	end 
ssh_heat=eta(:)-mean(eta);






