clc
clear
close all
addpath(genpath(pwd))
a=1;
dimension=30;
lowerbound= -100;
upperbound = 100;
Max_iterations=500; % 最大迭代数
pop=30;             % 种群大小
a=1;
value=[];
%%
fhd=str2func('cec17_func');
   
func_num=30;    % 测试函数名     25.28.29.30
Fun_name=['F' num2str(func_num)]; 

[~,~,BestforAEO]=AEO(pop,Max_iterations,lowerbound,upperbound,dimension,fhd,func_num);
[~,~,BestforSSA]=SSA(pop,Max_iterations,lowerbound,upperbound,dimension,fhd,func_num);
[~,~,BestforHHO]=HHO(pop,Max_iterations,lowerbound,upperbound,dimension,fhd,func_num);
[~,~,BestforWOA]=WOA(pop,Max_iterations,lowerbound,upperbound,dimension,fhd,func_num);
[~,BestforPSO]=PSO(pop,Max_iterations,lowerbound,upperbound,dimension,fhd,func_num);
 [~,~,BestforBOA]=BOA(pop,Max_iterations,lowerbound,upperbound,dimension,fhd,func_num);
[BestforECOOT,~,~]=ECOOT(pop,Max_iterations,lowerbound,upperbound,dimension,fhd,func_num);
[BestforCOOT,~,~]=COOT(pop,Max_iterations,lowerbound,upperbound,dimension,fhd,func_num);
[~,~,BestforAVOA]=AVOA(pop,Max_iterations,lowerbound,upperbound,dimension,fhd,func_num);
t=1:1:Max_iterations;
semilogy(t,BestforPSO,'y-+','Color',[1 0.07843 0.57647]','linewidth',1,'MarkerIndices',1:15:Max_iterations)
hold on
semilogy(t,BestforWOA,'b-.','linewidth',1,'MarkerIndices',1:15:Max_iterations)
hold on
semilogy(t,BestforBOA,'k--','linewidth',1)
hold on
semilogy(t,BestforHHO,'c','linewidth',1)
hold on
semilogy(t,BestforAEO,'g-^','linewidth',1,'MarkerIndices',1:15:Max_iterations)
hold on
semilogy(t,BestforAVOA,'-o','Color',[1 0.5 0]','linewidth',1,'MarkerIndices',1:15:Max_iterations)
hold on
semilogy(t,BestforCOOT,'d--','Color',[0.5451 0.53725 0.53725]','linewidth',1,'MarkerIndices',1:15:Max_iterations)
hold on
semilogy(t,BestforECOOT,'r-*','linewidth',1,'MarkerIndices',1:15:Max_iterations)
hold on
legend('PSO','WOA','BOA','HHO','AEO','AVOA','COA','ECOA')


title( Fun_name);
xlabel('迭代次数');
ylabel('适应度值');