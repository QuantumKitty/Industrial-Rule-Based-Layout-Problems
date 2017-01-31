clear; clc;
format compact;
%---------------------------------------------------------------------------------
Single_Multi=0;   % 0/1 : SingleRow / MultiRow
Rows=3;           % Number of Rows for MultiRow
Ord_Card=0;       % 0/1 : Ordinal / Cardinal
PWE_Switch=1;      % 0/1 : Pairwise off/on
Excel=0;          % 0/1 : Import data to excel off/on
IgnoreL=0;        % 0/1 : Run only for length one / Run for all lengths (For Multi-Row)
Parent_Folder='D:\RBLprogram\';      % Note: This folder must only contain other folders that contains files.
%---------------------------------------------------------------------------------
excel_row=2;
write_title=0;
if Excel==1&&isempty(xlsread('Instances Results.xlsx',Single_Multi+1,'C2'))
    write_title=1;
end
foldlist=dir(Parent_Folder);
for i=3:length(foldlist)
    filelist=dir(strcat(Parent_Folder,foldlist(i).name));
    for j=3:length(filelist)
        tic;
        [Flow,Length,n]=extract(strcat(Parent_Folder,foldlist(i).name,'\',filelist(j).name));
        if Single_Multi==0||IgnoreL==1||size(union(Length(1,:),1),2)==1
            if Single_Multi~=0
                method='MultiRow';
            elseif Ord_Card==0&&PWE_Switch==0
                method='Ordinal';
            elseif Ord_Card~=0&&PWE_Switch==0
                method='Cardinal';
            elseif Ord_Card==0&&PWE_Switch~=0
                method='Ordinal+Pairwise';
            else method='Cardinal+Pairwise';
            end
            disp(strcat('FolderName:',foldlist(i).name));
            disp(strcat('FileName:',filelist(j).name));
            disp(strcat('MethodTaken:',method));
            disp(strcat('No.Department=',num2str(n)));
            if Single_Multi==0
                if Ord_Card==0
                    layout=RBLOrdinal(Flow,n);
                else layout=RBLCardinal(Flow,Length,n);
                end
                Layout=[];
                if PWE_Switch==1
                    [layout,iterations]=pairwise(Flow,Length,n,layout);
                end
                for k=1:n
                    Layout=strcat(Layout,strcat(num2str(layout(k)),','));
                end
                disp(strcat('Layout=',Layout));
                TotalFlow=totalflow(Flow,Length,n,layout);
            else [layout1,row,column]=RBLMultiRow(Flow,n);
                disp('Layout before folding, rotating, cuting and pasting:');
                disp(layout1);
                disp(strcat('Layout after folding, rotating, cuting and pasting (with setting row=',num2str(Rows),'):'));
                if mod(n,Rows)~=0
                    disp(strcat('[',num2str(n),'] departments cannot be divided by [',num2str(Rows),...
                        '] rows, please try a different number of rows.'));
                    TotalFlow=0;
                else if Rows>n/Rows
                        disp(strcat('[',num2str(Rows),'*',num2str(n/Rows),'] is equal to [',num2str(n/Rows),...
                            '*',num2str(Rows),'], for better compution, set row=',num2str(n/Rows)));
                        r1=n/Rows;
                    else r1=Rows;
                    end
                    layout2=RBLMultiRowFurther(layout1,n,r1,row,column);
                    if PWE_Switch==1
                        [layout2,iterations]=pairwise(Flow,Length,n,layout2);
                    end
                    disp(layout2);
                    TotalFlow=totalflow(Flow,Length,n,layout2);
                end
            end
            disp(strcat('TotalFlow=',num2str(TotalFlow)));
            if PWE_Switch==1
                disp(strcat('PairwiseIterations=',num2str(iterations)));
            end
            time=toc;
            disp(strcat('RunTime=',num2str(time),'s'));
            disp('---------------------------------------------------------------------------------------');
            if Excel==1
                if write_title==1
                    exceldata0={foldlist(i).name,filelist(j).name,n};
                    xlrange0=strcat('A',num2str(excel_row),':C',num2str(excel_row));
                    xlswrite('Instances Results.xlsx',exceldata0,Single_Multi+1,xlrange0);
                end
                if PWE_Switch==0
                    exceldata={TotalFlow,time};
                    if Ord_Card==0&&Single_Multi==0
                        xlrange=strcat('D',num2str(excel_row),':E',num2str(excel_row));
                        xlswrite('Instances Results.xlsx',exceldata,1,xlrange);
                    elseif Ord_Card~=0&&Single_Multi==0
                        xlrange=strcat('F',num2str(excel_row),':G',num2str(excel_row));
                        xlswrite('Instances Results.xlsx',exceldata,1,xlrange);
                    else xlrange=strcat('D',num2str(excel_row),':E',num2str(excel_row));
                        xlswrite('Instances Results.xlsx',exceldata,2,xlrange);
                    end
                else exceldata={TotalFlow,iterations,time};
                    if Ord_Card==0&&Single_Multi==0
                        xlrange=strcat('H',num2str(excel_row),':J',num2str(excel_row));
                        xlswrite('Instances Results.xlsx',exceldata,1,xlrange);
                    elseif Ord_Card~=0&&Single_Multi==0
                        xlrange=strcat('K',num2str(excel_row),':M',num2str(excel_row));
                        xlswrite('Instances Results.xlsx',exceldata,1,xlrange);
                    else xlrange=strcat('F',num2str(excel_row),':H',num2str(excel_row));
                        xlswrite('Instances Results.xlsx',exceldata,2,xlrange);
                    end
                end
                excel_row=excel_row+1;
            end
        end
    end
end
if Excel==1
    [~,text,~]=xlsread('Instances Results.xlsx',1,'A1');
    if strcmp(text,'Instances')==0&&Single_Multi==0
        exceldata={'Instance','Source','Size','Ordinal-TF','Time (sec)','Cardinal-TF','Time (sec)',...
            'Ordinal-PWE-TF','Iterations','Time (sec)','Cardinal-PWE-TF','Iterations','Time (sec)'};
        xlswrite('Instances Results.xlsx',exceldata,1,'A1:M1');
    elseif strcmp(text,'Instances')==0&&Single_Multi==1
        exceldata={'Instance','Source','Size','MultiRow-TF','Time (sec)','MultiRow-PWE-TF','Time (sec)'};
        xlswrite('Instances Results.xlsx',exceldata,2,'A1:G1');
    end
end
disp('Finish!!!');
load handel;
sound(y,Fs);