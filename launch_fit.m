load Data
param0 = [0.5 0.4 0.00188];
% Fits
[param1,R2_1] = fitGlobal(Group1,time1,param0,'Group1');
[param2,R2_2] = fitGlobal(Group2,time2,param0,'Group2');
display('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
display(['The median R2 of Group 1 is ' num2str(median(R2_1)) ', range ('...
    num2str(min(R2_1)) ' - ' num2str(max(R2_1)) ')']);
display(['The median R2 of Group 2 is ' num2str(median(R2_2)) ', range ('...
    num2str(min(R2_2)) ' - ' num2str(max(R2_2)) ')']);
save('GlobalFit')