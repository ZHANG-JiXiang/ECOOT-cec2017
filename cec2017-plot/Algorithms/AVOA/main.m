%African Vulture Optimization alghorithm

% Read the following publication first and cite if you use it

% @article{abdollahzadeh2021african,
%   title={African Vultures Optimization Algorithm: A New Nature-Inspired Metaheuristic Algorithm for Global Optimization Problems},
%   author={Abdollahzadeh, Benyamin and Gharehchopogh, Farhad Soleimanian and Mirjalili, Seyedali},
%   journal={Computers \& Industrial Engineering},
%   pages={107408},
%   year={2021},
%   publisher={Elsevier},
%   url = {https://www.sciencedirect.com/science/article/pii/S0360835221003120}
% }


clear all 
close all
clc

% Population size and stoppoing condition 
pop_size=30;  
max_iter=100;  

% Define your objective function's details here
fobj = @ObjectiveFunction;
variables_no=10;
lower_bound=-100; % can be a vector too
upper_bound=100; % can be a vector too
      
[Best_vulture1_F,Best_vulture1_X,convergence_curve]=AVOA(pop_size,max_iter,lower_bound,upper_bound,variables_no,fobj);


figure 

% Best optimal values for the decision variables 
subplot(1,2,1)
parallelcoords(Best_vulture1_X)
xlabel('Decision variables')
ylabel('Best estimated values ')
box on

% Best convergence curve
subplot(1,2,2)
plot(convergence_curve);
title('Convergence curve of AVOA')
xlabel('Current_iteration');
ylabel('Objective value');
box on

