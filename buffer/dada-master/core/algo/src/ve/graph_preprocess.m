function [ M, Factors, nodeName ] = graph_preprocess
% M:         the moralized graph of a bayesian network
%
% Factors:   the initial factors from M (the moralized Alarm Bayesian 
%            Network) including all node potentials and edge potentials
%
% nodeNames: a cell array used to map a variable to its index by its name

%% Extract the Alarom Bayesian Network
alarm;% Load the Bayesian network
G = graph;

%% Graph Moralization (from Bayesian Network to MRF)
[M, nodeName] = moralizedGraph(G);

%% Transform the CPDs into node and edge potentials for the initial factors
% For each Factor{i}, there're three elements,
% -- Factors{i}{1}: a cell array of string with names of each node in the
%                   factor
% -- Factors{i}{2}: a integer vector with each element as the number of
%                   states/cardinalities of its corresponding node
% -- Factors{i}{3}: a column cell array with each element as a row cell
%                   array including the states of its corresponding point
% -- Factors{i}{4}: a full table for the factor based on the order of names
%                   in Factors{i}{1}. The states of the variable at the 
%                   left end are the least significant and the states 
%                   variable at the right end is the most significant. 
%                   
%                   To illustrate clearly, one example is shown below.
%                            A        B       C        Factor(A,B,C)
%                            a_1      b_1     c_1      0.06
%                            a_2      b_1     c_1      0.12
%                            a_1      b_2     c_1      0.14
%                            a_2      b_2     c_1      0.08
%                            a_1      b_1     c_2      0.07
%                            a_2      b_1     c_2      0.03
%                            a_1      b_2     c_2      0.15
%                            a_2      b_2     c_2      0.25


nnodes = numel(G);
Factors = cell(nnodes,1); % the number of the initial factors is the same as the number of nodes
for i = 1:nnodes
    
    % Factors{i}{1}: Names of nodes within this Factor
    tmp = G{i}{4}; % Parents of node i
    tmp{end + 1} = G{i}{1}; % Combine node i and its parents as a factor
    Factors{i}{1} = tmp';
    
    % Factors{i}{2}: Number of states for each node
    Factors{i}{2} = [];
    for j = 1:numel(Factors{i}{1})
        idx = strcmp(nodeName, Factors{i}{1}{j});
        Factors{i}{2} = [Factors{i}{2};G{idx}{2}];
    end

    % Factors{i}{3}: States for each node
    Factors{i}{3} = [];
    for j = 1:numel(Factors{i}{1})
        idx = strcmp(nodeName, Factors{i}{1}{j});
        Factors{i}{3} = [Factors{i}{3};G{idx}(3)];
    end
    
    % Factors{i}{4}: Potential Combinations
    Factors{i}{4} = G{i}{6}(:);
end

end

