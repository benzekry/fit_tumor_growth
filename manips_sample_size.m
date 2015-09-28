Fit1 = load('Group1/fitGroup1.mat');
Fit2 = load('Group2/fitGroup2.mat');
p0 = [mean(Fit1.param(:,1)), std(Fit1.param(:,1))/sqrt(10)];
p1 = p0(1) - 0.2;
display(['The number of animals required to detect a difference of 0.2 in a with a'...
    ' power of 95% is'])
nout = sampsizepwr('t2', p0, p1, 0.95)