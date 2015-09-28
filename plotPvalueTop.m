function plotPvalueTop(p)
L=length(p);
marker_p=10;
hold on
ylim=get(gca,'Ylim');
set(gca,'YLim',[0 ylim(2)*1.1])
for l=1:L
    y=ylim(2);
    mid=(l+l+1)/2;
    if p(l)<0.001
        plot([mid-0.05,mid+0.05],y,'*k','Markersize',marker_p);
    elseif p(l)<0.05
        plot(mid,y,'*k','Markersize',marker_p);
    end
end
hold off
end
