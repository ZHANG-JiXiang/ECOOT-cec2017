% Developed in MATLAB R2017b
% Source codes demo version 1.0
% _____________________________________________________

%  Author, inventor and programmer: Iraj Naruei and Farshid Keynia,
%  e-Mail: irajnaruei@iauk.ac.ir , irajnaruei@yahoo.com
% _____________________________________________________
%  Co-author and Advisor: Farshid Keynia
%
%         e-Mail: fkeynia@gmail.com
% _____________________________________________________
%  Co-authors: Amir Sabbagh Molahoseyni
%        
%         e-Mail: sabbagh@iauk.ac.ir
% _____________________________________________________
% You can find the Wild Horse Optimizer code at 
% _____________________________________________________
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Max_iter: maximum iterations, N: populatoin size, Convergence_curve: Convergence curve
function [Convergence_curve,gBest,gBestScore]=WHO(N,Max_iter,lb,ub,dim,fhd,varargin)

if size(ub,1)==1
    ub=ones(1,dim)*ub;
    lb=ones(1,dim)*lb;
end
 PS=0.2;     % Stallions Percentage 
 PC=0.13;    % Crossover Percentage
 NStallion=ceil(PS*N); % number Stallion
 Nfoal=N-NStallion;

Convergence_curve = zeros(1,Max_iter);
gBest=zeros(1,dim);
 gBestScore=inf;
 
 %create initial population
 empty.pos=[];
empty.cost=[];

group=repmat(empty,Nfoal,1);

for i=1:Nfoal 
   group(i).pos=lb+rand(1,dim).*(ub-lb);
   group(i).cost=feval(fhd,group(i).pos',varargin{:});
end

Stallion=repmat(empty,NStallion,1);

for i=1:NStallion 
   Stallion(i).pos=lb+rand(1,dim).*(ub-lb);
   Stallion(i).cost=feval(fhd,Stallion(i).pos',varargin{:});
 
end
  ngroup=length(group);
  a=randperm(ngroup);
  group=group(a);

i=0;
k=1;
for j=1:ngroup
i=i+1;    
  Stallion(i).group(k)=group(j);  
if i==NStallion
    i=0;
    k=k+1;
end
end
Stallion=exchange(Stallion);
[value,index]=min([Stallion.cost]);

WH=Stallion(index); % global
   gBest=WH.pos;
   gBestScore=WH.cost;

Convergence_curve(1)=WH.cost;
l=2; % Loop counter
while l<Max_iter+1
TDR=1-l*((1)/Max_iter);

for i=1:NStallion
    
   ngroup=length(Stallion(i).group);
    [~,index]=sort([Stallion(i).group.cost]);
    Stallion(i).group=Stallion(i).group(index);
   
   for j=1:ngroup
    
    if rand>PC
            z=rand(1,dim)<TDR;
            r1=rand;
            r2=rand(1,dim);
            idx=(z==0);
            r3=r1.*idx+r2.*~idx;
            rr=-2+4*r3;

           Stallion(i).group(j).pos= 2*r3.*cos(2*pi*rr).*(Stallion(i).pos-Stallion(i).group(j).pos)+(Stallion(i).pos);
    else
    A=randperm(NStallion);
    A(A==i)=[];
    a=A(1);
    c=A(2);
%     B=randperm(ngroup);
%     BB=randperm(ngroup);
%     b1=B(1);b2=BB(1);
    x1=Stallion(c).group(end).pos;
    x2=Stallion(a).group(end).pos;

       y1=(x1+x2)/2;   % Crossover

    Stallion(i).group(j).pos=y1;
    end
   

    Stallion(i).group(j).pos=min(Stallion(i).group(j).pos,ub);
    Stallion(i).group(j).pos=max(Stallion(i).group(j).pos,lb);
    
    
Stallion(i).group(j).cost=feval(fhd,Stallion(i).group(j).pos',varargin{:});
    
   end

    R=rand;
%     z=rand(1,dim)<TDR;
%             r1=rand;
%             r2=rand(1,dim);
%             idx=(z==0);
%             r3=r1.*idx+r2.*~idx;
%             rr=-2+4*r3;

       if R<0.5
        k= 2*r3.*cos(2*pi*rr).*(WH.pos-(Stallion(i).pos))+WH.pos;
        else
        k= 2*r3.*cos(2*pi*rr).*(WH.pos-(Stallion(i).pos))-WH.pos;
       end

    k=min(k,ub);
    k=max(k,lb);
    fk=feval(fhd,k',varargin{:});
    if fk<Stallion(i).cost
      Stallion(i).pos  =k;
      Stallion(i).cost=fk;
    end
end
    Stallion=exchange(Stallion);
     [value,index]=min([Stallion.cost]);
   if value<WH.cost
       WH=Stallion(index);
   end
   gBest=WH.pos;
   gBestScore=WH.cost;
    Convergence_curve(l)=WH.cost;
    l = l + 1;
end


