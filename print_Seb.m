function print_Seb(format,file)
if isequal(format,'-dpdf')
    print_pdf(gcf,file)
else
    print(format,file)
end

function print_pdf(hf,file)
set(hf,'PaperUnits','centimeters');
PaperPosition=get(hf,'PaperPosition');
set(hf,'PaperSize',[PaperPosition(3),PaperPosition(4)]);
set(hf,'PaperPosition',[0,0,PaperPosition(3),PaperPosition(4)]);
print('-dpdf',file)