function Stallion=exchange(Stallion)

nStallion=length(Stallion);



for i=1:nStallion
    
   [value,index]=min([Stallion(i).group.cost]);
   
   
   
   
   if value<Stallion(i).cost
       
       bestgroup=Stallion(i).group(index);
       
       Stallion(i).group(index).pos=Stallion(i).pos;
       Stallion(i).group(index).cost=Stallion(i).cost;
       
       
       Stallion(i).pos=bestgroup.pos;
       Stallion(i).cost=bestgroup.cost;
       
       
       
       
       
   end
    
    
    
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%                          www.matlabnet.ir                         %
%                   Free Download  matlab code and movie            %
%                          Shahab Poursafary                        %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%