function TotalFlow=totalflow(Flow,Length,n,Layout)
Distance=zeros(n);
[row,~]=size(Layout);
if row==1
    for i=1:n-1
        for j=i+1:n
            for k=i:j
                Distance(i,j)=Distance(i,j)+Length(Layout(k));
            end
            Distance(i,j)=Distance(i,j)-(Length(i)+Length(j))/2;
        end
    end
    Flow=Flow+Flow';
    Flow1=zeros(n);
    for i=1:n-1
        for j=i+1:n
            Flow1(i,j)=Flow(Layout(i),Layout(j));
        end
    end
    Aggregation=Flow1.*Distance;
    TotalFlow=sum(sum(Aggregation));
else
    for i=1:n-1
        for j=i+1:n
            [row1,column1]=find(Layout==i);
            [row2,column2]=find(Layout==j);
            Distance(i,j)=abs(row1-row2)+abs(column1-column2);
        end
    end
    Aggregation=Flow.*Distance;
    TotalFlow=sum(sum(Aggregation));
end
    