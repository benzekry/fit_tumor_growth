load Data
% Plot of global parameters
nameGlobs={'Group1','Group2'};
L=length(nameGlobs);
groupNames={'1','2'};
paramNames={'a','b','d'};
P=length(paramNames);
% Export raw results in a txt file
fid=fopen('RawDataResults.txt','wt');
str=repmat(' ,',1,20);
fprintf(fid,['Parameter , Group ,' str ' Mean , Std  \n']);
for p=1:P
    paramS={param1(:,p),param2(:,p)};
    for l=1:L
        N=length(paramS{l});
        str=repmat('%1.3g ,',1,N);
        fprintf(fid,'%s,',paramNames{p});        
        fprintf(fid,'%s,',nameGlobs{l});
        fprintf(fid,str,paramS{l});
        if N<20
            for n=1:20-N                        
                fprintf(fid,'-,');
            end
        end
        fprintf(fid,'%1.3g, %1.3g',[mean(paramS{l}),std(paramS{l})]);
        fprintf(fid,'\n');
    end
    figure(1)
    clf
    % Boxplot
    aboxplot([paramS{1},paramS{2}],...
        'Colorgrad','blue_down','colorrev',true,...
        'Labels',{'Group1','Group2'});
    ylabel(paramNames{p});
    % Plots statistical significance (t-test)
    [~,pStat]=ttest2(paramS{1},paramS{2});
    plotPvalueTop(pStat);    
    setFontsLinesPrint(gcf,['global' char(paramNames(p))]);   
end
fclose(fid);
close()

% Average curves
line=2;
font=20;
fontaxes=18;
styles={'b','r'};
Legende={'Group 1','Group 2'};
var_range={'1','2'};
V0=100;
temps=7:2:25;
comp=0;
figure(2)
clf;
figure(1)
for varName=var_range
    comp=comp+1;
    param=evalin('base',['param' char(varName)]);
    V=zeros(size(param,1),length(temps));
    for j=1:size(param,1)
        V(j,:)=HmodelV0(param(j,:),temps,V0);
        figure(1)
        hold on
        plot(temps,V(j,:),char(styles(comp)))
        hold off        
    end
    VMean=mean(V);
    stdErr=std(V)/sqrt(size(param,1));
    figure(2)
    hold on
    ind=find(temps>0);
    errorbar(temps(ind),VMean(ind),stdErr(ind),char(styles(comp)),'Linewidth',line)    
    hold off
end
figure(1)
xlabel('Time (days)','Fontsize',font)
ylabel('Tumor volume (mm^3)','Fontsize',font)
setFontsLinesPrint(gcf,'GlobalIndivPlot');
figure(2)
xlabel('Time (days)','Fontsize',font)
ylabel('Tumor volume (mm^3)','Fontsize',font)
hLeg=legend(Legende,'Location','Best');
set(hLeg,'Box','off');
setFontsLinesPrint(gcf,'GlobalPlot')

