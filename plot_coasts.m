%function plot_coasts(labels,colorbar)
% labels = 1 to label lat, lon. I think you need to contourf the data, first for the xlabels to work... 
% colorbar = 1 to make horizonal colorbar

function plot_coasts(labels, clrbar)
ll = coast;
plot(ll(:,2), ll(:,1),'k-', 360+ll(:,2),ll(:,1), 'k-');

if labels == 1
    set(gca,'fontsize',14,'ytick',-60:30:60,'yticklabel',{'60S';'30S';'Eq';'30N';'60N'});
    set(gca,'xtick',90:90:360,'xticklabel',{'90';'180';'-90';'0'});
end

if clrbar == 1
    P=get(gca,'position'); P(4)=0.8*P(4); P(2)=P(2)+0.15; set(gca,'position',P);clb=colorbar('horiz'); set(clb,'fontsize',16);
    Pc=get(clb,'position');  Pc(2)=Pc(2)-0.14; Pc(4)=0.04; set(clb,'position',Pc);
end
