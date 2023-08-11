function crosspop=BwCrossover(crosspop,pop,nvar,nCross,npop,nCannibalism,func)

individual.Position=[];
individual.Cost=[];
a=repmat(individual,nvar,1);

indexno=randperm(nCross);


for k=1:2:nCross
    %%  parents' choosing
    r1=indexno(k);
    r2=indexno(k+1);
    
    p1=pop(r1);
    p2=pop(r2);
    %% sexual Cannibalism
     if pop(r1).Cost < pop(r2).Cost
        a(1) = pop(r1);
    else
        a(1) = pop(r2);    
     end
    %% Reproduction
for i=1:2:nvar
        
    x1=p1.Position;
    x2=p2.Position;
    
    alpha=rand(size(x1));
    
    y1=alpha.*x1+(1-alpha).*x2;
    y2=alpha.*x2+(1-alpha).*x1;
    
    a(i+1).Position=y1;
    a(i+2).Position=y2;
    a(i+1).Cost=func(a(i+1).Position);
    a(i+2).Cost=func(a(i+2).Position);
end
  
    Costs=[a.Cost];
    [value order]=sort(Costs);
    a=a(order);
    %% Sibling Cannibalism
     if nvar>2
         for l=0:nCannibalism
             crosspop(k+l)=a(l+1);
         end
     elseif nvar==2
         for l=0:nCannibalism+1
             crosspop(k+l)=a(l+1);
         end
     elseif nvar==1
         for l=0:nCannibalism+2
             crosspop(k+l)=a(l+1);
         end
     end
end
end