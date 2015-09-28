function setFontsLinesPrint(hFig,name,flagLocationLegend)
% Only if flagLocationLegend=1 the function deals with the position of the
% legend
format='-dpdf';
line=2;
marker=10;
font=32;
fontaxes=30;
set(0,'ShowHiddenHandles','on')
ha=get(hFig,'CurrentAxes');
hl=findobj(gca,'Type','line');
set(hl,'Linewidth',line,'Markersize',marker);
hEB=findobj(gca,'Type','errorbar');
set(hEB,'Linewidth',line,'Markersize',marker);
% hl=findobj(ha,'Type','line','-not','LineStyle','none');
% set(hl,'Linewidth',line);
% set(hl,'Markersize',marker)
% hm=findobj(ha,'Type','line','-and','LineStyle','none');
% set(hm,'Markersize',marker);
% set(hm,'Linewidth',line);
set(ha,'Fontsize',fontaxes,'FontWeight','Bold');
if nargin>=3
    if flagLocationLegend==1
        hLeg=legend(ha);
        set(hLeg,'Location','Best');
    end
end
ht=findobj(hFig,'Type','text');
set(ht,'Fontsize',font,'FontWeight','Bold');
xLabel=get(gca,'XLabel');
yLabel=get(gca,'YLabel');
set(xLabel,'FontWeight','Bold');
set(yLabel,'FontWeight','Bold');
print_Seb(format,name)
end