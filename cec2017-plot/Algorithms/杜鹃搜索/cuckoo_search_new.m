function [fmin,bestnest,bestnestiniter]=cuckoo_search_new(n,N_IterTotal,lowerbound,upperbound,nd,fhd,varargin)
pa=0.25;              % Discovery rate of alien eggs/solutions
%% Simple bounds of the search domain
Lb=lowerbound.*ones(1,nd);     % Lower bounds
Ub=upperbound.*ones(1,nd);      % Upper bounds
% Random initial solutions
for i=1:n,
nest(i,:)=Lb+(Ub-Lb).*rand(size(Lb));
end
% Get the current best of the initial population
fitness=10^10*ones(n,1);
[fmin,bestnest,nest,fitness]=get_best_nest(nest,nest,fitness,fhd,varargin);

%% Starting iterations
for iter=1:N_IterTotal,
    % Generate new solutions (but keep the current best)
     new_nest=get_cuckoos(nest,bestnest,Lb,Ub);   
     [fnew,best,nest,fitness]=get_best_nest(nest,new_nest,fitness,fhd,varargin);
    % Discovery and randomization
      new_nest=empty_nests(nest,Lb,Ub,pa) ;
    % Evaluate this set of solutions
      [fnew,best,nest,fitness]=get_best_nest(nest,new_nest,fitness,fhd,varargin);
      % Find the best objective so far
      if fnew<fmin,
          fmin=fnew;
          bestnest=best;
      end
      bestnestiniter(iter)=fmin;
    % Display the results every 100 iterations
%     if ~mod(iter,100),
%        disp(strcat('Iteration = ',num2str(iter))); 
%        % bestnest
% %        fmin
%     end
end %% End of iterations

%% Post-optimization processing and display all the nests
% disp(strcat('The best solution=',num2str(bestnest)));
% disp(strcat('The best fmin=',num2str(fmin)));

%% --------------- All subfunctions are list below ------------------
%% Get cuckoos by ramdom walk
function nest=get_cuckoos(nest,best,Lb,Ub)
% Levy flights
n=size(nest,1);
% For details about Levy flights, please read Chapter 3 of the book:
% X. S. Yang, Nature-Inspired Optimization Algorithms, Elesevier, (2014).
beta=3/2;
sigma=(gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);

for j=1:n,
    s=nest(j,:);
    % This is a simple way of implementing Levy flights
    % For standard random walks, use step=1;
    %% Levy flights by Mantegna's algorithm
    u=randn(size(s))*sigma;
    v=randn(size(s));
    step=u./abs(v).^(1/beta);
  
    % In the next equation, the difference factor (s-best) means that 
    % when the solution is the best solution, it remains unchanged.     
    stepsize=0.01*step.*(s-best);
    % Here the factor 0.01 comes from the fact that L/100 should be the
    % typical step size for walks/flights where L is the problem scale; 
    % otherwise, Levy flights may become too aggresive/efficient, 
    % which makes new solutions (even) jump out side of the design domain 
    % (and thus wasting evaluations).
    % Now the actual random walks or flights
    s=s+stepsize.*randn(size(s));
    % Apply simple bounds/limits
    nest(j,:)=simplebounds(s,Lb,Ub);
end

%% Find the current best solution/nest among the population
function [fmin,best,nest,fitness]=get_best_nest(nest,newnest,fitness,fhd,varargin)
% Evaluating all new solutions
for j=1:size(nest,1)
    varargin{:}
    fnew=feval(fhd,newnest(j,:)',varargin{:});
    if fnew<=fitness(j)
       fitness(j)=fnew;
       nest(j,:)=newnest(j,:);
    end
end
% Find the current best
[fmin,K]=min(fitness) ;
best=nest(K,:);

%% Replace some not-so-good nests by constructing new solutions/nests
function new_nest=empty_nests(nest,Lb,Ub,pa)
% A fraction of worse nests are discovered with a probability pa
n=size(nest,1);
% Discovered or not -- a status vector
K=rand(size(nest))>pa;
% Notes: In the real world, if a cuckoo's egg is very similar to 
% a host's eggs, then this cuckoo's egg is less likely to be discovered. 
% so the fitness should be related to the difference in solutions.  
% Therefore, it is a good idea to do a random walk in a biased way 
% with some random step sizes.  
%% New solution by biased/selective random walks
stepsize=rand*(nest(randperm(n),:)-nest(randperm(n),:));
new_nest=nest+stepsize.*K;
for j=1:size(new_nest,1)
    s=new_nest(j,:);
  new_nest(j,:)=simplebounds(s,Lb,Ub);  
end

% Application of simple bounds/constraints
function s=simplebounds(s,Lb,Ub)
  % Apply the lower bound
  ns_tmp=s;
  I=ns_tmp<Lb;
  ns_tmp(I)=Lb(I);
  
  % Apply the upper bounds 
  J=ns_tmp>Ub;
  ns_tmp(J)=Ub(J);
  % Update this new move 
  s=ns_tmp;