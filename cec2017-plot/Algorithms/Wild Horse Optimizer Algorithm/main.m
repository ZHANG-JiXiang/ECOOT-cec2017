% Developed in MATLAB R2017b
% Source codes demo version 1.0
% _____________________________________________________

%  Author, inventor and programmer: Iraj Naruei and Farshid Keynia,
%  e-Mail: irajnaruei@iauk.ac.ir , irajnaruei@yahoo.com
% _____________________________________________________
%  Co-author and Advisor: Farshid Keynia
%
%         e-Mail: fkeynia@gmail.com
% _____________________________________________________
%  Co-authors: Amir Sabbagh Molahoseyni
%        
%         e-Mail: sabbagh@iauk.ac.ir
% _____________________________________________________

% You can find the WHO code at 
% _____________________________________________________
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear  
close all
clc

N=30; % Number of search agents

Function_name='F1'; % % Name of the test function that can be from F1 to F13 and cec01 to cec10

Max_iter=500; % Maximum number of iterations

% Load details of the selected benchmark function
[dim,fobj,ub, lb]  = Select_Functions(Function_name);
[Convergence_curve,gBest,gBestScore]=WHO(N,Max_iter,lb,ub,dim,fobj);

display(['The best location of WHO is: ', num2str(gBest)]);
display(['The best fitness of WHO is: ', num2str(gBestScore)]);
gBestScore
        



