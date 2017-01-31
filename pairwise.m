function [Layout,iterations]=pairwise(flow,length,n,layout)
[Row,~]=size(layout);
tf=zeros(n);
tf1=zeros(1,n*(n-1)/2);
k=1; iterations=-1;
tfcurrent=totalflow(flow,length,n,layout);
tfmin=tfcurrent-1;
while tfcurrent>tfmin
    tfcurrent=tfmin;
    Layout=layout;
    layout1=layout;
    for i=1:n-1
        for j=i+1:n
            if Row==1
                t=layout1(j);
                layout1(j)=layout1(i);
                layout1(i)=t;
            else [row1,column1]=find(layout==i);
                [row2,column2]=find(layout==j);
                t=layout1(row2,column2);
                layout1(row2,column2)=layout1(row1,column1);
                layout1(row1,column1)=t;
            end
            tf(i,j)=totalflow(flow,length,n,layout1);
            tf1(k)=tf(i,j);
            k=k+1;
            layout1=layout;
        end
    end
    tfmin=min(tf1(:));
    [row,column]=find(tf==tfmin,1);
    if Row==1
        t=layout(column);
        layout(column)=layout(row);
        layout(row)=t;
        iterations=iterations+1;
    else [row3,column3]=find(layout==row);
        [row4,column4]=find(layout==column);
        t=layout(row3,column3);
        layout(row3,column3)=layout(row4,column4);
        layout(row4,column4)=t;
        iterations=iterations+1;
    end
end