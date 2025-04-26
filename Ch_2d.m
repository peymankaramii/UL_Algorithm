% PUL function
function list_CH = Ch_2d(out,point)

point=sortrows([out point(out,2) point(out,3)],2);
ss= size(out,1);

list_CH=point(1,:);
v=ss+1;
i=0;

while list_CH(1,1)~=v
    i=i+1;
    %%% Calculate length unit
    X=zeros(1,ss); Y=zeros(1,ss);
    q1=list_CH(i,2);
    q2=list_CH(i,3);
    for j=1:ss
        q3=point(j,2);
        q4=point(j,3);
        q5=q1-q3;
        q6=q2-q4;
        l=(q5^2+q6^2)^0.5;
        X(j)=q1-    q5/l;%X by 1 meter
        Y(j)=q2-    q6/l;%Y by 1 meter
    end
    e1=find(point(:,1)==list_CH(i,1));   X(e1)=[];   Y(e1)=[];

    if i==1
        mini=find(Y==min(Y))+1;
        list_CH=[list_CH  ;  point(mini,:)];
    else
        %%% maping points
        r=(( list_CH(i-1,2)-list_CH(i,2) )^2    +     ( list_CH(i-1,3)-list_CH(i,3) )^2)^0.5;
        x2=list_CH(i,2) + ( list_CH(i,2)-list_CH(i-1,2) )/r;
        y2=list_CH(i,3) + ( list_CH(i,3)-list_CH(i-1,3) )/r;
        
        a=(X'-list_CH(i-1,2)).^2  +  (Y'-list_CH(i-1,3)).^2;
        b=(X'-x2).^2  +  (Y'-y2).^2;
        c=(a-b+(r+1)^2)/2/(r+1);
        maxi=find(c==max(c));
        
        if maxi>=e1
            maxi=maxi+1;
        end
        list_CH=[list_CH  ;  point(maxi,:)];
    end
    v=list_CH(end,1);
end

end