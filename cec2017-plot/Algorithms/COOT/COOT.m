% Max_iter: maximum iterations, N: populatoin size, Convergence_curve: Convergence curve
function [Convergence_curve,gBest,gBestScore]=COOT(N,Max_iter,lb,ub,dim,fhd,varargin)

if size(ub,1)==1
    ub=ones(1,dim).*ub;
    lb=ones(1,dim).*lb;
end

 NLeader=ceil(0.1*N);
 Ncoot=N-NLeader;
Convergence_curve = zeros(1,Max_iter);
gBest=zeros(1,dim);
 gBestScore=inf;
%Initialize the positions of Coots
% CootPos=rand(Ncoot,dim).*(ub-lb)+lb;
CootPos=rand(Ncoot,dim).*(ub-lb)+lb;
CootFitness=zeros(1,Ncoot);
%Initialize the locations of Leaders
LeaderPos=rand(NLeader,dim).*(ub-lb)+lb;
LeaderFit=zeros(1,NLeader);

for i=1:size(CootPos,1)
    CootFitness(1,i)= feval(fhd,CootPos(i,:)',varargin{:});
      if(gBestScore>CootFitness(1,i))
            gBestScore=CootFitness(1,i);
            gBest=CootPos(i,:);
      end  
end

for i=1:size(LeaderPos,1)  
    LeaderFit(1,i)=feval(fhd,LeaderPos(i,:)',varargin{:});
      if(gBestScore>LeaderFit(1,i))
            gBestScore=LeaderFit(1,i);
            gBest=LeaderPos(i,:);
      end   
end
Convergence_curve(1)=gBestScore;
l=2; %ÊÇL
% Loop counter
while l<Max_iter+1
 B=2-l*(1/Max_iter);
 A=1-l*(1/Max_iter);

    for i=1:size(CootPos,1) 
         if rand<0.5
            R=-1+2*rand;
            R1=rand();
         else  
              R=-1+2*rand(1,dim);
            R1=rand(1,dim);
         end
        k=1+mod(i,NLeader);
        if rand<0.5 %|| i==1
            CootPos(i,:)=2*R1.*cos(2*pi*R).*(LeaderPos(k,:)-CootPos(i,:))+LeaderPos(k,:); 
             % Check boundries
            Tp=CootPos(i,:)>ub;Tm=CootPos(i,:)<lb;CootPos(i,:)=(CootPos(i,:).*(~(Tp+Tm)))+ub.*Tp+lb.*Tm;
        else
            if rand<0.5 && i~=1%i>2*size(CootPos,1)/3%
                 CootPos(i,:)=(CootPos(i,:)+CootPos(i-1,:))/2;
            else
                Q=rand(1,dim).*(ub-lb)+lb;
%                 R1=0.2+ 0.6*rand;                
                  CootPos(i,:)=CootPos(i,:)+A*R1.*(Q-CootPos(i,:));               
            end
            Tp=CootPos(i,:)>ub;Tm=CootPos(i,:)<lb;CootPos(i,:)=(CootPos(i,:).*(~(Tp+Tm)))+ub.*Tp+lb.*Tm;  
        end
    end
    % fitness of location of Coots
   for i=1:size(CootPos,1)
    CootFitness(1,i)= feval(fhd,CootPos(i,:)',varargin{:});
    k=1+mod(i,NLeader); 
    % Update the location of coot
    if CootFitness(1,i)<LeaderFit(1,k)
        Temp=LeaderPos(k,:);
        TemFit= LeaderFit(1,k);
      LeaderFit(1,k)= CootFitness(1,i);
      LeaderPos(k,:)=CootPos(i,:);
       CootFitness(1,i)=TemFit;
       CootPos(i,:)=Temp;      
    end
   end
    % fitness of location of Leaders
    for i=1:size(LeaderPos,1)
         if rand<0.5
            R=-1+2*rand;
            R3=rand();
         else  
              R=-1+2*rand(1,dim);
            R3=rand(1,dim);
         end
        if rand<0.5             
            Temp=B*R3.*cos(2*pi*R).*(gBest-LeaderPos(i,:))+gBest;           
        else           
            Temp=B*R3.*cos(2*pi*R).*(gBest-LeaderPos(i,:))-gBest;           
        end   
        Tp=Temp>ub;Tm=Temp<lb;Temp=(Temp.*(~(Tp+Tm)))+ub.*Tp+lb.*Tm;
            TempFit=feval(fhd,Temp',varargin{:});
             % Update the location of Leader
         if(gBestScore>TempFit)
             LeaderFit(1,i)=gBestScore;
             LeaderPos(i,:)=gBest;
            gBestScore=TempFit;
            gBest=Temp;
         end
    end
 

    
    Convergence_curve(l)=gBestScore;
    l = l + 1;
end


