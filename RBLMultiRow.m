function [layout,row,column]=RBLMultiRow(Flow,n)
[~,rank]=sort(Flow(:),'descend');
row=mod(rank,n);
row(row==0)=n;
column=(rank-row)./n+1;
layout0=zeros(2*n-5,2*n-1);
deptset=zeros(1,n);
depttemp=zeros(2,(n-2)*(n-3)/2);
deptnowhere=zeros(1,n);
layout0(n-2,n)=row(1);
layout0(n-2,n+1)=column(1);
deptset([1 2])=[row(1) column(1)];
candidates=n-2; i=1; j=0; k=2; kdeptnowhere=1;
while candidates>0
    l=1;h=j;
    while h~=0
        same=intersect(depttemp([1 2],l),deptset);
        if isempty(same)
            l=l+1; h=h-1;
            continue;
        elseif size(same,1)==2
            for ii=l:j
                depttemp([1 2],ii)=depttemp([1 2],ii+1);
            end
            j=j-1; h=h-1;
            continue;
        else diff=setxor(depttemp([1 2],l),same);
            [row1,column1]=find(layout0==same);
            if isempty(row1)
                deptnowhere(kdeptnowhere)=diff;
                kdeptnowhere=kdeptnowhere+1;
            end
            if row1==n-2
                if layout0(n-2,column1+1)==0
                    layout0(n-2,column1+1)=diff;
                elseif layout0(n-2,column1-1)==0
                    layout0(n-2,column1-1)=diff;
                elseif size(union(layout0(n-3,:),0),2)>size(union(layout0(n-1,:),0),2)
                    if layout0(n-1,column1)==0
                        layout0(n-1,column1)=diff;
                    elseif layout0(n-3,column1)==0
                        layout0(n-3,column1)=diff;
                    elseif layout0(n-1,column1+1)==0
                        layout0(n-1,column1+1)=diff;
                    elseif layout0(n-1,column1-1)==0
                        layout0(n-1,column1-1)=diff;
                    elseif layout0(n-3,column1+1)==0
                        layout0(n-3,column1+1)=diff;
                    elseif layout0(n-3,column1-1)==0
                        layout0(n-3,column1-1)=diff;
                    else deptnowhere(kdeptnowhere)=diff;
                        kdeptnowhere=kdeptnowhere+1;
                    end
                else if layout0(n-3,column1)==0
                        layout0(n-3,column1)=diff;
                    elseif layout0(n-1,column1)==0
                        layout0(n-1,column1)=diff;
                    elseif layout0(n-3,column1+1)==0
                        layout0(n-3,column1+1)=diff;
                    elseif layout0(n-3,column1-1)==0
                        layout0(n-3,column1-1)=diff;
                    elseif layout0(n-1,column1+1)==0
                        layout0(n-1,column1+1)=diff;
                    elseif layout0(n-1,column1-1)==0
                        layout0(n-1,column1-1)=diff;
                    else deptnowhere(kdeptnowhere)=diff;
                        kdeptnowhere=kdeptnowhere+1;
                    end
                end
            elseif row1<n-2
                if layout0(row1-1,column1)==0
                    layout0(row1-1,column1)=diff;
                elseif layout0(row1,column1+1)==0
                    layout0(row1,column1+1)=diff;
                elseif layout0(row1,column1-1)==0
                    layout0(row1,column1-1)=diff;
                elseif layout0(row1+1,column1)==0
                    layout0(row1+1,column1)=diff;
                elseif layout0(row1-1,column1+1)==0
                    layout0(row1-1,column1+1)=diff;
                elseif layout0(row1-1,column1-1)==0
                    layout0(row1-1,column1-1)=diff;
                elseif layout0(row1+1,column1+1)==0
                    layout0(row1+1,column1+1)=diff;
                elseif layout0(row1+1,column1-1)==0
                    layout0(row1+1,column1-1)=diff;
                else deptnowhere(kdeptnowhere)=diff;
                    kdeptnowhere=kdeptnowhere+1;
                end
            elseif row1>n-2
                if layout0(row1+1,column1)==0
                    layout0(row1+1,column1)=diff;
                elseif layout0(row1,column1+1)==0
                    layout0(row1,column1+1)=diff;
                elseif layout0(row1,column1-1)==0
                    layout0(row1,column1-1)=diff;
                elseif layout0(row1-1,column1)==0
                    layout0(row1-1,column1)=diff;
                elseif layout0(row1+1,column1+1)==0
                    layout0(row1+1,column1+1)=diff;
                elseif layout0(row1+1,column1-1)==0
                    layout0(row1+1,column1-1)=diff;
                elseif layout0(row1-1,column1+1)==0
                    layout0(row1-1,column1+1)=diff;
                elseif layout0(row1-1,column1-1)==0
                    layout0(row1-1,column1-1)=diff;
                else deptnowhere(kdeptnowhere)=diff;
                    kdeptnowhere=kdeptnowhere+1;
                end
            end
            deptset(k+1)=diff;
            for ii=l:j
                depttemp([1 2],ii)=depttemp([1 2],ii+1);
            end
            k=k+1; j=j-1; l=1; h=j; candidates=candidates-1;
        end
    end
    same=intersect([row(i+1),column(i+1)],deptset);
    if row(i+1)>=column(i+1)
        i=i+1; continue;
    elseif isempty(same)
        depttemp([1 2],j+1)=[row(i+1),column(i+1)];
        j=j+1;
    elseif size(same,2)==2
        i=i+1; continue;
    else diff=setxor([row(i+1) column(i+1)],same);
        [row1,column1]=find(layout0==same);
        if isempty(row1)
            deptnowhere(kdeptnowhere)=diff;
            kdeptnowhere=kdeptnowhere+1;
        end
        if row1==n-2
            if layout0(n-2,column1+1)==0
                layout0(n-2,column1+1)=diff;
            elseif layout0(n-2,column1-1)==0
                layout0(n-2,column1-1)=diff;
            elseif size(union(layout0(n-3,:),0),2)>size(union(layout0(n-1,:),0),2)
                if layout0(n-1,column1)==0
                    layout0(n-1,column1)=diff;
                elseif layout0(n-3,column1)==0
                    layout0(n-3,column1)=diff;
                elseif layout0(n-1,column1+1)==0
                    layout0(n-1,column1+1)=diff;
                elseif layout0(n-1,column1-1)==0
                    layout0(n-1,column1-1)=diff;
                elseif layout0(n-3,column1+1)==0
                    layout0(n-3,column1+1)=diff;
                elseif layout0(n-3,column1-1)==0
                    layout0(n-3,column1-1)=diff;
                else deptnowhere(kdeptnowhere)=diff;
                    kdeptnowhere=kdeptnowhere+1;
                end
            else if layout0(n-3,column1)==0
                    layout0(n-3,column1)=diff;
                elseif layout0(n-1,column1)==0
                    layout0(n-1,column1)=diff;
                elseif layout0(n-3,column1+1)==0
                    layout0(n-3,column1+1)=diff;
                elseif layout0(n-3,column1-1)==0
                    layout0(n-3,column1-1)=diff;
                elseif layout0(n-1,column1+1)==0
                    layout0(n-1,column1+1)=diff;
                elseif layout0(n-1,column1-1)==0
                    layout0(n-1,column1-1)=diff;
                else deptnowhere(kdeptnowhere)=diff;
                    kdeptnowhere=kdeptnowhere+1;
                end
            end
        elseif row1<n-2
            if layout0(row1-1,column1)==0
                layout0(row1-1,column1)=diff;
            elseif layout0(row1,column1+1)==0
                layout0(row1,column1+1)=diff;
            elseif layout0(row1,column1-1)==0
                layout0(row1,column1-1)=diff;
            elseif layout0(row1+1,column1)==0
                layout0(row1+1,column1)=diff;
            elseif layout0(row1-1,column1+1)==0
                layout0(row1-1,column1+1)=diff;
            elseif layout0(row1-1,column1-1)==0
                layout0(row1-1,column1-1)=diff;
            elseif layout0(row1+1,column1+1)==0
                layout0(row1+1,column1+1)=diff;
            elseif layout0(row1+1,column1-1)==0
                layout0(row1+1,column1-1)=diff;
            else deptnowhere(kdeptnowhere)=diff;
                kdeptnowhere=kdeptnowhere+1;
            end
        elseif row1>n-2
            if layout0(row1+1,column1)==0
                layout0(row1+1,column1)=diff;
            elseif layout0(row1,column1+1)==0
                layout0(row1,column1+1)=diff;
            elseif layout0(row1,column1-1)==0
                layout0(row1,column1-1)=diff;
            elseif layout0(row1-1,column1)==0
                layout0(row1-1,column1)=diff;
            elseif layout0(row1+1,column1+1)==0
                layout0(row1+1,column1+1)=diff;
            elseif layout0(row1+1,column1-1)==0
                layout0(row1+1,column1-1)=diff;
            elseif layout0(row1-1,column1+1)==0
                layout0(row1-1,column1+1)=diff;
            elseif layout0(row1-1,column1-1)==0
                layout0(row1-1,column1-1)=diff;
            else deptnowhere(kdeptnowhere)=diff;
                kdeptnowhere=kdeptnowhere+1;
            end
        end
        deptset(k+1)=diff;
        k=k+1; candidates=candidates-1;
    end
    i=i+1;
end
if size(union(deptnowhere(1,:),0),2)~=1
    for circle=1:n-3
        for edge=1:2*circle
            if layout0(n-2-circle+edge-1,n+circle)==0
                layout0(n-2-circle+edge-1,n+circle)=deptnowhere(kdeptnowhere-1);
                kdeptnowhere=kdeptnowhere-1;
                if kdeptnowhere==1
                    break;
                end
            end
        end
        if kdeptnowhere==1
            break;
        end
        for edge=1:2*circle
            if layout0(n-2+circle,n+circle-edge+1)==0
                layout0(n-2+circle,n+circle-edge+1)=deptnowhere(kdeptnowhere-1);
                kdeptnowhere=kdeptnowhere-1;
                if kdeptnowhere==1
                    break;
                end
            end
        end
        if kdeptnowhere==1
            break;
        end
        for edge=1:2*circle
            if layout0(n-2+circle-edge+1,n-circle)==0
                layout0(n-2+circle-edge+1,n-circle)=deptnowhere(kdeptnowhere-1);
                kdeptnowhere=kdeptnowhere-1;
                if kdeptnowhere==1
                    break;
                end
            end
        end
        if kdeptnowhere==1
            break;
        end
        for edge=1:2*circle
            if layout0(n-2-circle,n+circle+edge-1)==0
                layout0(n-2-circle,n+circle+edge-1)=deptnowhere(kdeptnowhere-1);
                kdeptnowhere=kdeptnowhere-1;
                if kdeptnowhere==1
                    break;
                end
            end
        end
        if kdeptnowhere==1
            break;
        end
    end
end
for upcut=1:n-2
    if size(union(layout0(upcut,:),0),2)~=1
        break;
    end
end
upcut=upcut-1;
for downcut=2*n-5:-1:n-2
    if size(union(layout0(downcut,:),0),2)~=1
        break;
    end
end
downcut=2*n-5-downcut;
for leftcut=1:n
    if size(union(layout0(:,leftcut),0),1)~=1
        break;
    end
end
leftcut=leftcut-1;
for rightcut=2*n-1:-1:n
    if size(union(layout0(:,rightcut),0),1)~=1
        break;
    end
end
rightcut=2*n-1-rightcut;
row=2*n-5-upcut-downcut;
column=2*n-1-leftcut-rightcut;
layout=zeros(row,column);
for i=1:row
    for j=1:column
        layout(i,j)=layout0(i+upcut,j+leftcut);
    end
end
if row>column
    layout=layout';
    t=row; row=column; column=t;
end
