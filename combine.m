clc;clear;close all;format long g

%% elepsoid points
ss=10000; % the number of points
ss1=100; % The number of points on the circumference of the elepsoid
all_x = rand(1,ss1)*20;
all_y = (abs(1-((all_x-10).^2)/100)*25).^0.5;
m=rand(1,ss1);
u1=(m<0.5);u2=(m>=0.5)*-1;all_y=all_y.*(u1+u2)+5;

ss2=ss-ss1;
all_x2 = rand(1,ss2)*20;
all_y2 = (abs(1-((all_x2-10).^2)/100)*25).^0.5;
all_y2=all_y2.*(rand(ss2,1)*2-1)'+5;

point=[1:ss;[all_x' ;all_x2']';[all_y all_y2]]';
list_CH=[
    point(point(:,2)==min(point(:,2)),:)
    point(point(:,3)==max(point(:,3)),:)
    point(point(:,2)==max(point(:,2)),:)
    point(point(:,3)==min(point(:,3)),:)
    point(point(:,2)==min(point(:,2)),:)];


%%  combine 
out=cell(4,1);
out{1}=(1:ss)';
out{2}=(1:ss)';
out{3}=(1:ss)';
out{4}=(1:ss)';

m12={};
per=0.1; % Ratio of extreme points (h) to total points (n) 
num=0;
i=0;

while num<=size(out,1)-3
    
    i=i+1;
    l1=zeros(size(out{i},1),1);
    if size(out{i},1)>0 && size(out{i},2)>0 &&  size(out{i},1)/ss>=per
        
        for j=1:size(out{i},1)
            x11=list_CH(i,2);
            x21=list_CH(i+1,2);
            x31=point(out{i}(j),2);
            if x11~=x31 && x21~=x31
                x12=list_CH(i,3);
                x22=list_CH(i+1,3);
                x32=point(out{i}(j),3);
                l1(j,1)=det([x11 x12 1;x21 x22 1;x31 x32 1]); 
            end
        end
        distance=find(l1>0);
        new=out{i}(  l1==max(l1)  );
        out(i,1)={out{i}(distance)};
        num=0;
        elseif size(out{i},1)>0 && size(out{i},2)>0 &&  size(out{i},1)/ss<=per
            m12{i,1} = Ch_2d([out{i};list_CH(i);list_CH(i+1)],point);
            out{i}=[];
    else 
        num=num+1;
    end
    
    if size(distance,1)>0 && size(out{i},1)/ss>per
        list_CH=[list_CH(1:i,:)  ;point(point(:,1)==new,:)  ;list_CH(i+1:end,:)   ];
        out = sortcell(out,i,cell(size(out,1)+1,1));
    end
    i=mod(i,size(out,1));
    if i==size(out,1)
        i=0;
    end
end


plot(point(:,2),point(:,3),'.') ; axis equal
hold on

for i=1:size(m12,1)
    if size(m12{i},1)~=0
    hold on
    plot(m12{i}(:,2),m12{i}(:,3),'r','LineWidth',1.5)

    end
end
hold on

plot(list_CH(:,2),list_CH(:,3),'b','LineWidth',1.5)
axis equal



