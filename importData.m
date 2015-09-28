clear all
time1 = xlsread('DataExample.xlsx','G2:O2');
Group1 = xlsread('DataExample.xlsx','G3:O22');
time2 = time1;
Group2 = xlsread('DataExample.xlsx','G31:O50');
save Data;