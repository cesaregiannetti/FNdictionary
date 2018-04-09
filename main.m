%% Load geometry (and FEM matrices)
load brain
%% Recall uniform dictionary
movefile('Dictionary_3_132730.mat','Dictionary.mat');
%% Reduced basis generation
FN_basis
%% Recall generated basis
load Dict3peak-L1_2018-04-08_14-45
%% Reduced model evaluation
FN_rom