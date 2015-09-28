function y=HmodelV0(param,temps,V0)
a=param(1);c=param(2);d=param(3);
K0=2*V0;
[~,Xp]=ode45(@G,temps,[V0 K0]);
y=Xp(:,1)';

function dX=G(~,X)
dX(1)=a*X(1).*log(X(2)./X(1));
dX(2)=c*X(1) - d*X(1)^(2/3)*X(2);
dX=reshape(dX,2,1);
end
end