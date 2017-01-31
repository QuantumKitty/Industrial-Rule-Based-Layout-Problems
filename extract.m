function [Flow,Length,n]=extract(filename)
F=importdata(filename);
n=F(1);
Flow0=zeros(n);
Flow=zeros(n);
Length=zeros(1,n);
for i=1:n
    for j=1:n
        Flow0(i,j)=F(n*j+i+1);
    end
end
for j=1:n-1
    for i=j+1:n
        Flow(j,i)=Flow0(i,j)+Flow0(j,i);
    end
end
for k=1:n
    Length(k)=F(k+1);
end