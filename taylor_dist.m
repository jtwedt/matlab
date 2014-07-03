% function distance=taylor_dist(correlation,amplitude_ratio,ind)
%
% construct a Taylor diagram from vectors of correlations and amplitude
% ratios
%
% The amplitude_ratio can be defined either
% as rms(y)/rms(x) or std(y)/std(x) and gives slightly
% different results depending on the size of the bias.
% NOTE that complex_corr uses std(x)/std(y)
%
% plots each point in polar coordinates (r,theta):
% 1) r = amplitude ratio of prediction to observation
% 2) theta = arccos(rho)
% array ind gives the symbol to use in plotting:
% 1 - dot
% 2 - circle
%
% returns the distance from correlation=1.0 and ratio=1.0,
% which is the rms error as a fraction of observation amplitude
%
% Suzanne Dickinson, March 2009
% Kathie Kelly, April 2009
%
function distance=taylor_dist(correlation,amplitude_ratio,ind)

% plot diagram & compute distance
npts=length(correlation);
% compute theta, rr, normalized error (distance)
    theta=acos(correlation);    % compute correlation angle
    rr=amplitude_ratio;
    xx=rr.*cos(theta);yy=rr.*sin(theta);
    distance=sqrt((xx-1).^2+yy.^2);
% % plot data points
%         if ind(j)==1
%         plot(xx,yy,'k.','Markersize',15);hold on
%         elseif ind(j)==2
%         plot(xx,yy,'ko','Markersize',6);hold on        
%         end
%     end
% plot circles & axes
    for j=1:5
    rr=j*0.25;
        for k=1:900
        xc(k)=rr*cos((k/10)/180*pi);yc(k)=rr*sin((k/10)/180*pi);
        end
    plot(xc,yc,'k','linewidth',0.5);hold on
        if rr==1
        plot(xc,yc,'k','linewidth',2)
        end
    end

axis([0 1.3 0 1.3]);
axis('square');
set(gca,'xtick',[0.25 0.5 0.75 1 1.25])
set(gca,'ytick',[0.25 0.5 0.75 1 1.25])
set(gca,'yticklabel',[])

% plot radial lines for the correlation
rr=1.25
rhobin=[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 0.95 0.99];
thetabin=acos(rhobin);
xp=rr*cos(thetabin);yp=rr*sin(thetabin);
    for k=1:length(xp)
    plot([0 xp(k)],[0 yp(k)],'k--')
        if k>=10
        textstr=sprintf('%4.2f',rhobin(k));
        else
        textstr=sprintf('%3.1f',rhobin(k));
        end
    text(xp(k)+0.005*(1+rhobin(k)),yp(k)+0.015*(1+rhobin(11-k+1)),textstr)
    end
text(0.9,1,'Correlation','fontsize',14,'fontw','bold')
xlabel('Relative Amplitude','fontsize',14,'fontw','bold')

% plot circle at perfection
plot(1,0,'ko','Markersize',8);box off

% large, bolder labels
% set(gca,'fontname','times','fontsize',14)

% plot data points
    for j=1:npts
        if ind(j)==1;plot(xx(j),yy(j),'r.','Markersize',25);end
        if ind(j)==2; plot(xx(j),yy(j),'b.','Markersize',25);end        
        if ind(j)==3; plot(xx(j),yy(j),'g.','Markersize',25);end        
        if ind(j)==4; plot(xx(j),yy(j),'c.','Markersize',25);end        
        if ind(j)==5; plot(xx(j),yy(j),'m.','Markersize',25);end        
	 end  

