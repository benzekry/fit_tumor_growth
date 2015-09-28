colormapBW=[1/255*[138,138,138];[1,1,1]];

x1 = normrnd(5,2,10000,1); % First data set of 10000 values with mean 5
x2 = normrnd(10,2,10000,1); % Second data set of 10000 values with mean 10
x3 = normrnd(15,2,10000,1); % Third data set of 10000 values with mean 15

x = cat(2,x1,x2,x3); % Concatenate the data sets in a 10000 x 3 matrix

%aboxplot(x,'labels',[5,10,15]); % Advanced box plot

aboxplot([paramS{1},paramS{2}],...
     'Colorgrad','blue_down','colorrev',true);%
                  %'Colormap',colormapBW)%,...
%                 'Colorrev',0,...
%                 'Labels',{'Group1','Group2'})