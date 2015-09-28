param0 = [0.5 0.4 0.00188];

i=9;
indices = find(Group1(i,:)>0);
Data = Group1(i,indices);
timeLoc = time1(indices);

plot(timeLoc,Data,'o','Markersize',10);
temps=timeLoc(1):0.1:timeLoc(end);
Vloc = HmodelV0(param0,temps,Data(1));
hold on
plot(temps,Vloc)
hold off
