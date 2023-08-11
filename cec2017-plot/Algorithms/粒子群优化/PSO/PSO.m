
%% ������ʼ��
function [fitnesszbest,yy]=PSO(sizepop,maxgen,popmin,popmax,D,fhd,varargin)
c1 = 1.5;       % ѧϰ����
c2 = 1.5;
w=0.7;          % ����Ȩ��
Vmax = 0.5;     % �ٶȵķ�Χ
Vmin = -0.5;  
%% ��Ⱥ��ʼ��
for i = 1:sizepop
    % �������һ����Ⱥ
    pop(i,:) = rand(1,D)*10-5;    % ��ʼ��λ��
    V(i,:) = 0.5 * rands(1,D);   % ��ʼ���ٶ�
    % ��Ӧ�ȼ���
    fitness(i) =  feval(fhd,pop(i,:)',varargin{:}); 
end
%% ���弫ֵ��Ⱥ�弫ֵ
[bestfitness,bestindex] = max(fitness);   % Ĭ�Ͻ���һ���������Ӧ��ֵ����Ϊ���
zbest = pop(bestindex,:);   % ȫ�����
gbest = pop;                % �������
fitnessgbest = fitness;     % ���������Ӧ��ֵ
fitnesszbest = bestfitness;   % ȫ�������Ӧ��ֵ
%% ����Ѱ��
for i = 1:maxgen
       for j = 1:sizepop
        % �ٶȸ���
        V(j,:) = w*V(j,:) + c1*rand*(gbest(j,:) - pop(j,:)) + c2*rand*(zbest - pop(j,:));  
        % �ٶ�Խ����
        if (V(j,:)>Vmax)
        V(j,:)=Vmax;
        end
        if (V(j,:)<Vmin)
        V(j,:)= Vmin;
        end
%        V(j,find(V(j,:)<Vmin)) = Vmin;
        % ��Ⱥ����
        pop(j,:) = pop(j,:) + V(j,:);
        % ���巶ΧԽ����
        if ((pop(j,:)>popmax))
        pop(j,:)=popmax;
        end
        if pop(j,:)<popmin
        pop(j,:)=popmin;
        end
%         pop(j,find(pop(j,:)>popmax)) = popmax;
%         pop(j,find(pop(j,:)<popmin)) = popmin;
        % ��Ӧ��ֵ����
       fitness(j) =  feval(fhd,pop(j,:)',varargin{:});
       end
       for j = 1:sizepop
        % �������Ÿ���
        if fitness(j) < fitnessgbest(j)
            gbest(j,:) = pop(j,:);
            fitnessgbest(j) = fitness(j);
        end
        % ȫ�����Ÿ���
        if fitness(j) < fitnesszbest
            zbest = pop(j,:);
            fitnesszbest = fitness(j);
        end
       end 
    % ��¼ÿһ��������ֵ
    yy(i) = fitnesszbest;          
end
end
 
