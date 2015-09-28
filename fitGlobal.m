function [param,R2] = fitGlobal(DataSet,timeGlobal,param0,nameGlob)
% Fits all the individuals growth data in DataSet corresponding to times
% timeGlobal with the H model and log transformed residuals starting from the initial measured volume.
% param0 is the initial guess of parameters. Bounds are applied in the fit.
% Results are exported in folder nameGlob
N = size(DataSet,1);
P = length(param0);
param = zeros(N,P);
paramNames = {'a';'b';'d'};%'K_0'};
R2 = zeros(1,N);
Res = cell(1,N);
ResTot = [];
mkdir(nameGlob)
for i = 1:N
    indices = find(DataSet(i,:)>0);
    time = timeGlobal(indices);
    Data = DataSet(i,indices);
    name = [nameGlob '/' num2str(i)];
    [param(i,:), R2(i), Res{i}] = identParamFlog(time,Data,param0,name);
    ResTot = [ResTot,reshape(Res{i},1,length(Res{i}))];
end
for j = 1:P
    plot(1:N,param(:,j),'*')
    setFontsLinesPrint(gcf,[nameGlob '/' char(paramNames(j))]);    
end
plot(1:length(ResTot),ResTot,'*')
setFontsLinesPrint(gcf,[nameGlob '/Residuals']);   
histogram(ResTot)
setFontsLinesPrint(gcf,[nameGlob '/ResidualsHist']);
save([nameGlob '/' 'fit' nameGlob])

    function [param,R2,ResLoc] = identParamFlog(time,Data,param0,name)
        V0 = Data(1);
        options = optimset('Display','iter','MaxFunEvals',1000);%'Algorithm','levenberg-marquardt');
        [param, resnorm] = lsqcurvefit(@HmodelLog,param0,time,log(Data),...
            0.1*param0,...
            10*param0,options)
        VLogloc = HmodelLog(param,time);
        ResLoc = log(Data)-VLogloc;
        DataMoy = 1/length(log(Data))*sum(log(Data));
        SStot = sum((log(Data)-DataMoy).^2);
        R2 = 1-resnorm/SStot;
        
        function y = HmodelLog(param,temps)
            y = log(Hmodel(param,temps));
        end
        
        function y = Hmodel(param,temps)
            a = param(1);c = param(2);d = param(3);
            K0 = 2*V0;
            [~,Xp] = ode45(@G,temps,[V0 K0]);
            y = Xp(:,1)';
            function dX = G(~,X)
                dX(1) = a*X(1).*log(X(2)./X(1));
                dX(2) = c*X(1) - d*X(1)^(2/3)*X(2);
                dX = reshape(dX,2,1);
            end
        end
        
        function y = HmodelFull(param,temps)
            a = param(1);c = param(2);d = param(3);
            K0 = 2*V0;
            [~, Xp] = ode45(@G,temps,[V0 K0]);
            y = Xp;
            function dX = G(~,X)
                dX(1) = a*X(1).*log(X(2)./X(1));
                dX(2) = c*X(1) - d*X(1)^(2/3)*X(2);
                dX = reshape(dX,2,1);
            end
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        font = 20;
        t0 = time(1);T = time(end);
        temps = t0:0.1:T;
        Xp = HmodelFull(param,temps);
        plot(temps,Xp(:,1))
%         yLim = get(gca,'YLim');
        hold on
        plot(time,Data,'*','Markersize',5)
        plot(temps,Xp(:,2),'r')
        set(gca,'YLim',[0, 2500], 'XLim', [5, 20]);
        hold off
        
        xlabel('Time (days)','Fontsize',font)
        ylabel('Tumor size (mm^3)','Fontsize',font)
        setFontsLinesPrint(gcf,name);
    end
end