function layout=RBLMultiRowFurther(Layout,n,expectedRow,row,column)
expectedColumn=n/expectedRow;
layout=zeros(expectedRow,expectedColumn);
if expectedRow>expectedColumn
    t=expectedRow; expectedRow=expectedColumn; expectedColumn=t;
end
if expectedColumn>=column    % circle
    amount=zeros(row-expectedRow+1,1);
    for i=1:row-expectedRow+1
        amount(i)=size(union(Layout(i:i+expectedRow-1,:),0),1);
    end
    [~,position]=sort(amount,'descend');
    for i1=1:expectedRow
        for j1=1:column
            layout(i1,j1)=Layout(position(1)+i1-1,j1);
        end
    end
    if position(1)-1~=0     % up fold&rotate
        for fold=1:column
            if Layout(position(1)-1,fold)~=0
                for i2=1:3
                    if fold-2+i2==0||fold-2+i2==expectedColumn+1
                        continue;
                    end
                    if layout(1,fold-2+i2)==0
                        layout(1,fold-2+i2)=Layout(position(1)-1,fold);
                        Layout(position(1)-1,fold)=0;
                        break;
                    end
                end
            end
        end
    end
    if position(1)+expectedRow<=row     % down fold&rotate
        for fold=1:column
            if Layout(position(1)+expectedRow,fold)~=0
                for i2=1:3
                    if fold-2+i2==0||fold-2+i2==expectedColumn+1
                        continue;
                    end
                    if layout(expectedRow,fold-2+i2)==0
                        layout(expectedRow,fold-2+i2)=Layout(position(1)+expectedRow,fold);
                        Layout(position(1)+expectedRow,fold)=0;
                        break;
                    end
                end
            end
        end
    end
    if position(1)-1~=0     % up cut&paste
        for i3=1:position(1)-1
            for j3=1:column
                if Layout(i3,j3)~=0
                    for i31=1:expectedColumn
                        for j31=1:expectedRow
                            if layout(j31,i31)==0
                                layout(j31,i31)=Layout(i3,j3);
                                Layout(i3,j3)=0;
                                break;
                            end
                        end
                        if Layout(i3,j3)==0
                            break;
                        end
                    end
                end
            end
        end
    end
    if position(1)+expectedRow<=row     % down cut&paste
        for i3=1:row-position(1)-expectedRow+1
            for j3=1:column
                if Layout(position(1)+expectedRow-1+i3,j3)~=0
                    for i31=1:expectedColumn
                        for j31=1:expectedRow
                            if layout(j31,i31)==0
                                layout(j31,i31)=Layout(position(1)+expectedRow-1+i3,j3);
                                Layout(position(1)+expectedRow-1+i3,j3)=0;
                                break;
                            end
                        end
                        if Layout(position(1)+expectedRow-1+i3,j3)==0
                            break;
                        end
                    end
                end
            end
        end
    end
elseif expectedRow>=row
    amount=zeros(column-expectedColumn+1,1);
    for i=1:column-expectedColumn+1
        amount(i)=size(union(Layout(:,i:i+expectedColumn-1),0),1);
    end
    [~,position]=sort(amount,'descend');
    for i1=1:expectedColumn
        for j1=1:row
            layout(j1,i1)=Layout(j1,position(1)+i1-1);
        end
    end
    if position(1)-1~=0     % left fold&rotate
        for fold=1:row
            if Layout(fold,position(1)-1)~=0
                for i2=1:3
                    if fold-2+i2==0||fold-2+i2==expectedRow+1
                        continue;
                    end
                    if layout(fold-2+i2,1)==0
                        layout(fold-2+i2,1)=Layout(fold,position(1)-1);
                        Layout(fold,position(1)-1)=0;
                        break;
                    end
                end
            end
        end
    end
    if position(1)+expectedColumn<=column     % right fold&rotate
        for fold=1:row
            if Layout(fold,position(1)+expectedColumn)~=0
                for i2=1:3
                    if fold-2+i2==0||fold-2+i2==expectedRow+1
                        continue;
                    end
                    if layout(fold-2+i2,expectedColumn)==0
                        layout(fold-2+i2,expectedColumn)=Layout(fold,position(1)+expectedColumn);
                        Layout(fold,position(1)+expectedColumn)=0;
                        break;
                    end
                end
            end
        end
    end
    if position(1)-1~=0     % left cut&paste
        for i3=1:position(1)-1
            for j3=1:row
                if Layout(j3,i3)~=0
                    for i31=1:expectedRow
                        for j31=1:expectedColumn
                            if layout(i31,j31)==0
                                layout(i31,j31)=Layout(j3,i3);
                                Layout(j3,i3)=0;
                                break;
                            end
                        end
                        if Layout(j3,i3)==0
                            break;
                        end
                    end
                end
            end
        end
    end
    if position(1)+expectedColumn<=column     % right cut&paste
        for i3=1:column-position(1)-expectedColumn+1
            for j3=1:row
                if Layout(j3,position(1)+expectedColumn-1+i3)~=0
                    for i31=1:expectedRow
                        for j31=1:expectedColumn
                            if layout(i31,j31)==0
                                layout(i31,j31)=Layout(j3,position(1)+expectedColumn-1+i3);
                                Layout(j3,position(1)+expectedColumn-1+i3)=0;
                                break;
                            end
                        end
                        if Layout(j3,position(1)+expectedColumn-1+i3)==0
                            break;
                        end
                    end
                end
            end
        end
    end
else amount=zeros(row-expectedRow+1,column-expectedColumn+1);
    for i=1:row-expectedRow+1
        for j=1:column-expectedColumn+1
            amount(i,j)=size(union(Layout(i:i+expectedRow-1,j:j+expectedColumn-1),0),1);
        end
    end
    [~,position]=sort(amount(:),'descend');
    headrow=mod(position(1),row-expectedRow+1);
    if headrow==0
        headrow=row-expectedRow+1;
    end
    headcolumn=(position(1)-headrow)/(row-expectedRow+1)+1;
    for i1=1:expectedRow
        for j1=1:expectedColumn
            layout(i1,j1)=Layout(headrow+i1-1,headcolumn+j1-1);
        end
    end
    if headrow-1~=0     % up fold&rotate
        for fold=headcolumn:headcolumn+expectedColumn-1
            if Layout(headrow-1,fold)~=0
                for i2=1:3
                    if fold-2+i2==headcolumn-1||fold-2+i2==headcolumn+expectedColumn
                        continue;
                    end
                    if layout(1,fold-1+i2-headcolumn)==0
                        layout(1,fold-1+i2-headcolumn)=Layout(headrow-1,fold);
                        Layout(headrow-1,fold)=0;
                        break;
                    end
                end
            end
        end
    end
    if headrow+expectedRow<=row     % down fold&rotate
        for fold=headcolumn:headcolumn+expectedColumn-1
            if Layout(headrow+expectedRow,fold)~=0
                for i2=1:3
                    if fold-2+i2==headcolumn-1||fold-2+i2==headcolumn+expectedColumn
                        continue;
                    end
                    if layout(expectedRow,fold-1+i2-headcolumn)==0
                        layout(expectedRow,fold-1+i2-headcolumn)=Layout(headrow+expectedRow,fold);
                        Layout(headrow+expectedRow,fold)=0;
                        break;
                    end
                end
            end
        end
    end
    if headcolumn-1~=0     % left fold&rotate
        for fold=headrow:headrow+expectedRow-1
            if Layout(fold,headcolumn-1)~=0
                for i2=1:3
                    if fold-2+i2==headrow-1||fold-2+i2==headrow+expectedRow
                        continue;
                    end
                    if layout(fold-1+i2-headrow,1)==0
                        layout(fold-1+i2-headrow,1)=Layout(fold,headcolumn-1);
                        Layout(fold,headcolumn-1)=0;
                        break;
                    end
                end
            end
        end
    end
    if headcolumn+expectedColumn<=column     % right fold&rotate
        for fold=headrow:headrow+expectedRow-1
            if Layout(fold,headcolumn+expectedColumn)~=0
                for i2=1:3
                    if fold-2+i2==headrow-1||fold-2+i2==headrow+expectedRow
                        continue;
                    end
                    if layout(fold-1+i2-headrow,expectedColumn)==0
                        layout(fold-1+i2-headrow,expectedColumn)=Layout(fold,headcolumn+expectedColumn);
                        Layout(fold,headcolumn+expectedColumn)=0;
                        break;
                    end
                end
            end
        end
    end
    if headrow-1~=0     % up cut&paste
        for i3=1:headrow-1
            for j3=1:column
                if Layout(i3,j3)~=0
                    for i31=1:expectedColumn
                        for j31=1:expectedRow
                            if layout(j31,i31)==0
                                layout(j31,i31)=Layout(i3,j3);
                                Layout(i3,j3)=0;
                                break;
                            end
                        end
                        if Layout(i3,j3)==0
                            break;
                        end
                    end
                end
            end
        end
    end
    if headrow+expectedRow<=row     % down cut&paste
        for i3=1:row-headrow-expectedRow+1
            for j3=1:column
                if Layout(headrow+expectedRow-1+i3,j3)~=0
                    for i31=1:expectedColumn
                        for j31=1:expectedRow
                            if layout(j31,i31)==0
                                layout(j31,i31)=Layout(headrow+expectedRow-1+i3,j3);
                                Layout(headrow+expectedRow-1+i3,j3)=0;
                                break;
                            end
                        end
                        if Layout(headrow+expectedRow-1+i3,j3)==0
                            break;
                        end
                    end
                end
            end
        end
    end
    if headcolumn-1~=0     % left cut&paste
        for i3=1:headcolumn-1
            for j3=headrow:headrow+expectedRow-1
                if Layout(j3,i3)~=0
                    for i31=1:expectedRow
                        for j31=1:expectedColumn
                            if layout(i31,j31)==0
                                layout(i31,j31)=Layout(j3,i3);
                                Layout(j3,i3)=0;
                                break;
                            end
                        end
                        if Layout(j3,i3)==0
                            break;
                        end
                    end
                end
            end
        end
    end
    if headcolumn+expectedColumn<=column     % right cut&paste
        for i3=1:column-headcolumn-expectedColumn+1
            for j3=headrow:headrow+expectedRow-1
                if Layout(j3,headcolumn+expectedColumn-1+i3)~=0
                    for i31=1:expectedRow
                        for j31=1:expectedColumn
                            if layout(i31,j31)==0
                                layout(i31,j31)=Layout(j3,headcolumn+expectedColumn-1+i3);
                                Layout(j3,headcolumn+expectedColumn-1+i3)=0;
                                break;
                            end
                        end
                        if Layout(j3,headcolumn+expectedColumn-1+i3)==0
                            break;
                        end
                    end
                end
            end
        end
    end
end
