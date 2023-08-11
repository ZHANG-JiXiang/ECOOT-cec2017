function [new_BestCostBw]=BWOA(N,MaxIter,lb,ub,dim,func,RepNo)

BestRepBWO=zeros(RepNo,1);

for rep=1:RepNo
nPop=N;
nvar=dim;
%% Settings the inputs   
pc=0.8;                                 % Percent of Crossover 
nCross=round(pc*nPop/2)*2;              % Number of selected Parents
% pMutation=1-pc;                         % Percent of Mutation
pMutation=0.4;
nMutation=round(pMutation*nPop);        % Number of Mutants

pCannibalism=0.5;
nCannibalism=round(pCannibalism*nvar);

%% Initialization

individual.Position=[];
individual.Cost=[];

pop=repmat(individual,nPop,1);

% Generating the initial population
for i=1:nPop    
    pop(i).Position=initializationBW(dim,ub,lb);
    pop(i).Cost=func(pop(i).Position); 
end

% Sorting the Population
Costs=[pop.Cost];
[Costs SortOrder]=sort(Costs);
pop=pop(SortOrder);
WorstCost=Costs(end);
BestCost=Costs(1);
% The outputs storage
BestSol=[]; 
BestCostBw=zeros(MaxIter,1);


%% Main Loop

for it=1:MaxIter
    
        
    % Crossover Operator- Generating the Pop2 population
    crosspop=repmat(individual,nCross,1);
    crosspop=BwCrossover(crosspop,pop,nvar,nCross,nPop,nCannibalism,func);
       
    % Mutation- Generating the Pop3 population
    pop3=repmat(individual,nMutation,1);
    randnum=randperm(nCross);
    for k=1:nMutation
       i=randnum(k);     
        q=Mutate(pop(i));
        q.Cost=func(q.Position);
       pop3(k)=q;
    end
    
    % Unify the Populations (pop, pop2, pop3)
    [pop]=[crosspop
        pop3];
         
    
    % Sorting the Population based on fitness value
    Costs=[pop.Cost];
    [Costs SortOrder]=sort(Costs);
    pop=pop(SortOrder);
    WorstCost=max(WorstCost,Costs(end));
    
    % deleting the extra Individuals
    pop=pop(1:nPop);
    Costs=Costs(1:nPop);
    
    % Savingt the Results
    BestSol=pop(1);
    BestCostBw(it)=Costs(1);
%    
% disp(['Iteration ' num2str(it) ':   ' ...
%          'Best Cost Bw = ' num2str(BestCostBw(it))]);

end
BestRepBWO(rep)=BestCostBw(end);
end
medianBwo=median(BestRepBWO);
meanBwo=mean(BestRepBWO);
BestOfAllBwo=min(BestRepBWO);
WorstBwo=max(BestRepBWO);
StdBwo=std(BestRepBWO);
% disp([ 'The Best Bwo = ' num2str(BestOfAllBwo)])
% disp([ 'Mean Bwo = ' num2str(meanBwo)])
% disp([ 'Median Bwo = ' num2str(medianBwo)])
% disp([ 'Worst Bwo = ' num2str(WorstBwo)])
% disp([ 'Std Bwo = ' num2str(StdBwo)])
new_BestCostBw=BestCostBw';
end