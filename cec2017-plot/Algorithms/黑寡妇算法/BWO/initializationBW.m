function X=initializationBW(dim,ub,lb)

Boundary_no= size(ub,2); % numnber of boundaries

% In case of equal boundaries for all variables  

if Boundary_no==1
    X=rand(1,dim).*(ub-lb)+lb;
end

%  different lb and ub
if Boundary_no>1
    for i=1:dim
        ub_i=ub(i);
        lb_i=lb(i);
        X(:,i)=rand(1).*(ub_i-lb_i)+lb_i;
    end
end