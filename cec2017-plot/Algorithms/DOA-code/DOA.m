
function [vMin,theBestVct,Convergence_curve]=DOA(SearchAgents_no,Max_iter,lb,ub,dim,fhd,varargin)
P= 0.5;  % Hunting or Scavenger?  rate.  See section 3.0.4, P and Q parameters analysis
Q= 0.7;  % Group attack or persecution? 
beta1= -2 + 4* rand();  % -2 < beta < 2     Used in Eq. 2, 
beta2= -1 + 2* rand();  % -1 < beta2 < 1    Used in Eq. 2,3, and 4
naIni= 2; % minimum number of dingoes that will attack
naEnd= SearchAgents_no /naIni; % maximum number of dingoes that will attack
na= round(naIni + (naEnd-naIni) * rand()); % number of dingoes that will attack, used in Attack.m Section 2.2.1: Group attack
Positions=initialization(SearchAgents_no,dim,ub,lb);
 for i=1:size(Positions,1)
      Fitness(i)=feval(fhd,Positions(i,:)',varargin{:}); % get fitness     
 end
[vMin minIdx]= min(Fitness);  % the min fitness value vMin and the position minIdx
theBestVct= Positions(minIdx,:);  % the best vector
[vMax maxIdx]= max(Fitness); % the max fitness value vMax and the position maxIdx
Convergence_curve=zeros(1,Max_iter);
Convergence_curve(1)= vMin;
survival= survival_rate(Fitness,vMin,vMax);  % Section 2.2.4 Dingoes'survival rates
t=0;% Loop counter
% Main loop
for t=1:Max_iter       
   for r=1:SearchAgents_no
      sumatory=0;
    if rand() < P  % If Hunting?
           sumatory= Attack( SearchAgents_no, na, Positions, r );     % Section 2.2.1, Strategy 1: Part of Eq.2   
           if rand() < Q  % If group attack?                
                 v(r,:)=  beta1 * sumatory-theBestVct; % Strategy 1: Eq.2
           else  %  Persecution
               r1= round(1+ (SearchAgents_no-1)* rand()); % 
               v(r,:)= theBestVct + beta1*(exp(beta2))*((Positions(r1,:)-Positions(r,:))); % Section 2.2.2, Strategy 2:  Eq.3
           end  
    else % Scavenger
        r1= round(1+ (SearchAgents_no-1)* rand());
        v(r,:)=   (exp(beta2)* Positions(r1,:)-((-1)^getBinary)*Positions(r,:))/2; % Section 2.2.3, Strategy 3: Eq.4
    end
    if survival(r) <= 0.3  % Section 2.2.4, Algorithm 3 - Survival procedure
         band=1; 
         while band 
           r1= round(1+ (SearchAgents_no-1)* rand());
           r2= round(1+ (SearchAgents_no-1)* rand());
           if r1 ~= r2 
               band=0;
           end
         end
              v(r,:)=   theBestVct + (Positions(r1,:)-((-1)^getBinary)*Positions(r2,:))/2;  % Section 2.2.4, Strategy 4: Eq.6
    end 
     % Return back the search agents that go beyond the boundaries of the search space .  
        Flag4ub=v(r,:)>ub;
        Flag4lb=v(r,:)<lb;
        v(r,:)=(v(r,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
    % Evaluate new solutions
     Fnew= feval(fhd,v(r,:)',varargin{:});;
     % Update if the solution improves
     if Fnew <= Fitness(r)
        Positions(r,:)= v(r,:);
        Fitness(r)= Fnew;
     end
     if Fnew <= vMin
         theBestVct= v(r,:);
         vMin= Fnew;
     end 
   end
   Convergence_curve(t+1)= vMin; 
   [vMax maxIdx]= max(Fitness);
    survival= survival_rate( Fitness, vMin, vMax); % Section 2.2.4 Dingoes'survival rates
 end
%_____________________________________________________End DOA Algorithm]%
