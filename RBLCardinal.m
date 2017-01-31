function Layout=RBLCardinal(Flow,Length,n)
[~,rank]=sort(Flow(:),'descend');
row=mod(rank,n);
row(row==0)=n;
column=(rank-row)./n+1;
layout0=zeros(1,n);
deptset=zeros(1,n);
depttemp=zeros(2,(n-2)*(n-3)/2);
layout0(1)=row(1);
layout0(2)=column(1);
deptset([1 2])=[row(1) column(1)];
candidates=n-2; i=1; j=0; k=2;  %k=no.set
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
            totalflow00=zeros(1,k+1);
            for i2=1:k+1
                i1=1;
                layout00=zeros(1,k+1);
                layout00(i2)=diff;
                for j2=1:k+1
                    if layout00(j2)==0
                        layout00(j2)=layout0(i1);
                        i1=i1+1;
                    else continue;
                    end
                end
                totalflow00(i2)=totalflow(Flow,Length,k+1,layout00);
            end
            totalflowmin=min(totalflow00(:));
            [~,column00]=find(totalflow00==totalflowmin,1);
            layout00=zeros(1,k+1);
            layout00(column00)=diff;
            i5=1;
            for j5=1:k+1
                if layout00(j5)==0
                    layout00(j5)=layout0(i5);
                    i5=i5+1;
                else continue;
                end
            end
            for i6=1:k+1
                layout0(i6)=layout00(i6);
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
        totalflow00=zeros(1,k+1);
        for i2=1:k+1
            i1=1;
            layout00=zeros(1,k+1);
            layout00(i2)=diff;
            for j2=1:k+1
                if layout00(j2)==0
                    layout00(j2)=layout0(i1);
                    i1=i1+1;
                else continue;
                end
            end
            totalflow00(i2)=totalflow(Flow,Length,k+1,layout00);
        end
        totalflowmin=min(totalflow00(:));
        [~,column00]=find(totalflow00==totalflowmin,1);
        layout00=zeros(1,k+1);
        layout00(column00)=diff;
        i5=1;
        for j5=1:k+1
            if layout00(j5)==0
                layout00(j5)=layout0(i5);
                i5=i5+1;
            else continue;
            end
        end
        for i6=1:k+1
            layout0(i6)=layout00(i6);
        end
        deptset(k+1)=diff;
        k=k+1; candidates=candidates-1;
    end
    i=i+1;
end
Layout=layout0;