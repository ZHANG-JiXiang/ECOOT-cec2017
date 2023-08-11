%_________________________________________________________________________%
%  Dingo Optimization Algorithm (DOA) source code                         %
%                                                                         %
%  Developed in MATLAB 9.4.0.813654 (R2018a)                              %
%                                                                         %
%  Author: Dr. Hernan Peraza-Vazquez                                      %
%          MTA. Gustavo Echavarria-Castillo                               %
%                                                                         %
%  e-mail:  hperaza@ipn.mx        gechavarriac1700@alumno.ipn.mx          %
%                                                                         %
%  Programmer:  Dr. Hernan Peraza-Vazquez                                 %
%  Main paper:                                                            %
%  A Bio-Inspired Method for Engineering Design Optimization Inspired by  %
%  Dingoes Hunting Strategies.                                            %
%  Mathematical Problems in Engineering. (2021). Hindawi.                 %                                                      %
%  DOI:   doi.org/10.1155/2021/9107547                                    %
%_________________________________________________________________________%   
function [ band ] = findrep( val, vector )
% return 1= repeated  0= not repeated
band= 0;
for i=1:size(vector, 2)
    if val== vector(i)
        band=1;
        break;
    end
end
end
%_________________________________________________________________________%
%[Used in vectorAttack.m for Strategy 1: Group Attack Eq.2, Section 2.2.1]%