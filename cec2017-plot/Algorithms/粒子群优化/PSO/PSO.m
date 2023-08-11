
%% 参数初始化
function [fitnesszbest,yy]=PSO(sizepop,maxgen,popmin,popmax,D,fhd,varargin)
c1 = 1.5;       % 学习因子
c2 = 1.5;
w=0.7;          % 惯性权重
Vmax = 0.5;     % 速度的范围
Vmin = -0.5;  
%% 种群初始化
for i = 1:sizepop
    % 随机产生一个种群
    pop(i,:) = rand(1,D)*10-5;    % 初始化位置
    V(i,:) = 0.5 * rands(1,D);   % 初始化速度
    % 适应度计算
    fitness(i) =  feval(fhd,pop(i,:)',varargin{:}); 
end
%% 个体极值和群体极值
[bestfitness,bestindex] = max(fitness);   % 默认将第一代的最大适应度值设置为最佳
zbest = pop(bestindex,:);   % 全局最佳
gbest = pop;                % 个体最佳
fitnessgbest = fitness;     % 个体最佳适应度值
fitnesszbest = bestfitness;   % 全局最佳适应度值
%% 迭代寻优
for i = 1:maxgen
       for j = 1:sizepop
        % 速度更新
        V(j,:) = w*V(j,:) + c1*rand*(gbest(j,:) - pop(j,:)) + c2*rand*(zbest - pop(j,:));  
        % 速度越界检查
        if (V(j,:)>Vmax)
        V(j,:)=Vmax;
        end
        if (V(j,:)<Vmin)
        V(j,:)= Vmin;
        end
%        V(j,find(V(j,:)<Vmin)) = Vmin;
        % 种群更新
        pop(j,:) = pop(j,:) + V(j,:);
        % 个体范围越界检查
        if ((pop(j,:)>popmax))
        pop(j,:)=popmax;
        end
        if pop(j,:)<popmin
        pop(j,:)=popmin;
        end
%         pop(j,find(pop(j,:)>popmax)) = popmax;
%         pop(j,find(pop(j,:)<popmin)) = popmin;
        % 适应度值计算
       fitness(j) =  feval(fhd,pop(j,:)',varargin{:});
       end
       for j = 1:sizepop
        % 个体最优更新
        if fitness(j) < fitnessgbest(j)
            gbest(j,:) = pop(j,:);
            fitnessgbest(j) = fitness(j);
        end
        % 全局最优更新
        if fitness(j) < fitnesszbest
            zbest = pop(j,:);
            fitnesszbest = fitness(j);
        end
       end 
    % 记录每一代的最优值
    yy(i) = fitnesszbest;          
end
end
 
