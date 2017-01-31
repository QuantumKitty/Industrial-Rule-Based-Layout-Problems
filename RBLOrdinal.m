function Layout=RBLOrdinal(Flow,n)
Flow2=Flow+Flow';
[~,rank]=sort(Flow(:),'descend');
row=mod(rank,n);
row(row==0)=n;
column=(rank-row)./n+1;
layout0=zeros(1,2*n);
deptset=zeros(1,n);
depttemp=zeros(2,(n-2)*(n-3)/2);
layout0(n)=row(1);
layout0(n+1)=column(1);
deptset([1 2])=[row(1) column(1)];
candidates=n-2; i=1; j=0; k=2; left=n; right=n+1;
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
            [~,order]=find(layout0==same);
            if layout0(order+1)==0
                layout0(order+1)=diff;
                right=right+1;
            elseif layout0(order-1)==0
                layout0(order-1)=diff;
                left=left-1;
            elseif Flow2(diff,layout0(order+1))>Flow2(diff,layout0(order-1))
                if order-left>right-order
                    for ii=right+1:-1:order+2
                        layout0(ii)=layout0(ii-1);
                    end
                    right=right+1;
                    layout0(order+1)=diff;
                else for ii=left-1:order-1
                        layout0(ii)=layout0(ii+1);
                    end
                    left=left-1;
                    layout0(order)=diff;
                end
            elseif order-left>right-order
                for ii=right+1:-1:order+1
                    layout0(ii)=layout0(ii-1);
                end
                right=right+1;
                layout0(order)=diff;
            else for ii=left-1:order-2
                    layout0(ii)=layout0(ii+1);
                end
                left=left-1;
                layout0(order-1)=diff;
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
        [~,order]=find(layout0==same);
        if layout0(order+1)==0
            layout0(order+1)=diff;
            right=right+1;
        elseif layout0(order-1)==0
            layout0(order-1)=diff;
            left=left-1;
        elseif Flow2(diff,layout0(order+1))>Flow2(diff,layout0(order-1))
            if order-left>right-order
                for ii=right+1:-1:order+2
                    layout0(ii)=layout0(ii-1);
                end
                right=right+1;
                layout0(order+1)=diff;
            else for ii=left-1:order-1
                    layout0(ii)=layout0(ii+1);
                end
                left=left-1;
                layout0(order)=diff;
            end
        elseif order-left>right-order
            for ii=right+1:-1:order+1
                layout0(ii)=layout0(ii-1);
            end
            right=right+1;
            layout0(order)=diff;
        else for ii=left-1:order-2
                layout0(ii)=layout0(ii+1);
            end
            left=left-1;
            layout0(order-1)=diff;
        end
        deptset(k+1)=diff;
        k=k+1; candidates=candidates-1;
    end
    i=i+1;
end
Layout=zeros(1,n);
for i=1:n
    Layout(i)=layout0(i+left-1);
end