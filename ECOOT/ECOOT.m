% Max_iter: maximum iterations, N: populatoin size, Convergence_curve: Convergence curve
function [Convergence_curve,gBest,gBestScore]=ECOOT(N,Max_iter,lb,ub,dim,fobj)
tic
if size(ub,1)==1
    ub=ones(1,dim).*ub;
    lb=ones(1,dim).*lb;
end

NLeader=ceil(0.1*N);
Ncoot=N-NLeader;
Convergence_curve = zeros(1,Max_iter);
gBest=zeros(1,dim);
gBestScore=inf;
q = 0.3; % 掉队率
d = 0.1; % 掉队距离比例因子

%Initialize the positions of Coots
% CootPos=rand(Ncoot,dim).*(ub-lb)+lb;
CootPos=lhsdesign(Ncoot,dim).*(ub-lb)+lb;
CootFitness=zeros(1,Ncoot);
%Initialize the locations of Leaders
LeaderPos=rand(NLeader,dim).*(ub-lb)+lb;
LeaderFit=zeros(1,NLeader);

for i=1:size(CootPos,1)
    CootFitness(1,i)=fobj(CootPos(i,:));
    if(gBestScore>CootFitness(1,i))
        gBestScore=CootFitness(1,i);
        gBest=CootPos(i,:);
    end
end

for i=1:size(LeaderPos,1)
    LeaderFit(1,i)=fobj(LeaderPos(i,:));
    if(gBestScore>LeaderFit(1,i))
        gBestScore=LeaderFit(1,i);
        gBest=LeaderPos(i,:);
    end
end
Convergence_curve(1)=gBestScore;
l=2; %是L
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
        if rand<0.5
           %%
            dist = norm(CootPos(i,:) - LeaderPos);
            if dist > d * mean(vecnorm(CootPos(i,:) - LeaderPos(k,:), 2, 2)) && rand() < q
            CootPos(i,:) = CootPos(i,:) + (rand(1, size(CootPos, 2)) - 0.5) * d * dist;
            else
                CootPos(i,:)=2*R1.*cos(2*pi*R).*(LeaderPos(k,:)-CootPos(i,:))+LeaderPos(k,:);
            end
            %%
            %           CootPos(i,:)=2*R1.*cos(2*pi*R).*(LeaderPos(k,:)-CootPos(i,:))+LeaderPos(k,:);
            % Check boundries
            Tp=CootPos(i,:)>ub;Tm=CootPos(i,:)<lb;CootPos(i,:)=(CootPos(i,:).*(~(Tp+Tm)))+ub.*Tp+lb.*Tm;
        else
            if rand<0.5 && i~=1%i>2*size(CootPos,1)/3%
                CootPos(i,:)=(CootPos(i,:)+CootPos(i-1,:))/2;
            else
                Q=rand(1,dim).*(ub-lb)+lb;
                %R1=0.2+ 0.6*rand;
                CootPos(i,:)=CootPos(i,:)+A*R1.*(Q-CootPos(i,:));
            end
            Tp=CootPos(i,:)>ub;Tm=CootPos(i,:)<lb;CootPos(i,:)=(CootPos(i,:).*(~(Tp+Tm)))+ub.*Tp+lb.*Tm;
        end
    end
    % fitness of location of Coots
    for i=1:size(CootPos,1)
        CootFitness(1,i)=fobj(CootPos(i,:));
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
        TempFit=fobj(Temp);
        % Update the location of Leader
        if(gBestScore>TempFit)
            LeaderFit(1,i)=gBestScore;
            LeaderPos(i,:)=gBest;
            gBestScore=TempFit;
            gBest=Temp;
        end
    end
    
    %% 二次插值
    PopPos=[CootPos;LeaderPos];
    for i=1:N
        PopFit(i) =  fobj(PopPos(i,:));
    end
    for i=1:N
        PopPos_mean=mean(PopPos(i,:));fit_mean=mean(PopFit(i));
        fenzi(i,:)=( PopPos(i,:).^2 - PopPos_mean.^2 ).*gBestScore+( PopPos_mean.^2 - gBest.^2).*PopFit(i)+(gBest.^2-PopPos(i,:).^2 ).*fit_mean;
        fenmu(i,:)=2.*( (PopPos(i,:)-PopPos_mean).*gBestScore + (PopPos_mean - gBest).*PopFit(i)+(gBest-PopPos(i,:)).*fit_mean);
        newPopPos(i,:)=fenzi(i,:)./fenmu(i,:);
    end
    for i=1:size(CootPos,1)
        CootFitness(1,i)=fobj(newPopPos(i,:));
        if(gBestScore>CootFitness(1,i))
            gBestScore=CootFitness(1,i);
            gBest=newPopPos(i,:);
        end
    end
    for i=Ncoot:N
        TempFit=fobj(newPopPos(i,:));
        if(gBestScore>TempFit)
            LeaderFit(1,i)=gBestScore;
            LeaderPos(i,:)=gBest;
            gBestScore=TempFit;
            gBest=newPopPos(i,:);
        end
    end
    %%
    Convergence_curve(l)=gBestScore;
    l = l + 1;
end
toc

