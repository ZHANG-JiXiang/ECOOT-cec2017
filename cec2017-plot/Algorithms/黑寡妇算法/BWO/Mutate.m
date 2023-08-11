function q=Mutate(p) 
    x=p.Position;
    nvar=numel(x);
    randrand=randperm(nvar);
    j1=randrand(1);
    j2=randrand(2);
    
    n1j=x(j1);
    n2j=x(j2);
    x(j1)=n2j;
    x(j2)=n1j;
   
    q.Position=x;

end