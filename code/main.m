%% main.m 
%%% ================================================ %%% 
%%% =========== Semester project at LASA ==========  %%%
%%% ============ Reinforcement Learning ============ %%% 
%%% ================= Main Script ================== %%% 
%%% ================================================ %%%
close all;
clear all;
clc; 
addpath(genpath('./stored_mdps'));
addpath(genpath('./draw'));
addpath(genpath('./utils'));
addpath(genpath('./methods'));
set(0,'DefaultTextInterpreter','Latex') 

%% init
%model_name = 'free_grid_2d'; % defines model's name 
%model_name = 'obstacle_grid_2d';
model_name = 'maze_2d'; % defines model's name 
stochasticy = true; 
discount = 1;

%% configure mdp and draw state and action space
mdp = configure_mdp(model_name,stochasticy,discount);
draw_mdp(mdp);

%% policy iteration and other mdp solving algos
tic
% with bellman
%[pi_star,mdp] = bellman_solve_mdp(mdp);
% with Q-learning
%[pi_star,mdp] = qlearning_solve_mdp(mdp);
% with SARSA
%[pi_star,mdp] = sarsa_solve_mdp(mdp);
% with SARSA(lambda) 
%[pi_star,mdp] = sarsa_lambda_solve_mdp(mdp);
% with Watkins Q(lambda) 
%[pi_star,mdp] = qlearning_lambda_solve_mdp(mdp);
toc
%% plots the optimal policy 
%draw_policy(pi_star,mdp.states);
 
%% imitation reinforcement learning methods
  load('misc/policy/subopt_policy_3.mat','pi'); pi_m = pi;
  il_method = 'av'; % 'ac' % 'av' % 'naive'
  switch il_method 
      case 'ac'
          [pi_star,mdp] = ac_imitation_learning_off(pi_m, mdp);
          draw_compliance_cmap(pi,mdp.states)
      case 'av'
          [pi_star,mdp] = av_imitation_learning_off(pi_m, mdp);
          draw_decision_map(pi,mdp.states)
      case 'naive'
          [pi_star,mdp] = naive_imitation_learning(pi_m, mdp);
      otherwise
          error('Unknwown imitation learning method')
  end
 