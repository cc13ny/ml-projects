function [ M, nodeName] = moralizedGraph( G )
% G: a cell-based representation Bayesian network with each cell as the
%    representation of each node
%
% M: a logical matrix used to indicate the existence of connections between 
%    nodes, i.e. 1's for the existence of connections & 0's for no 
%    connections

%% Setup
nnodes = numel(G);
M = zeros(nnodes, nnodes);

%% Extract names of all nodes for finding the index of any node
nodeName = cell(nnodes,1); % a cell array of strings
for i = 1:nnodes
    nodeName{i} = G{i}{1};
end

%% Build the moralized graph
for j = 1:nnodes
    node = G{j};
    parents = node{4}; % names of parents
    nparents = numel(parents);
    idxofpar = zeros(nparents, 1); % indices of parents
    
    % Mark the edges between the child and one of its parents
    for k = 1:nparents       
        % find the index of one specified parent
        idxofpar(k) = find(ismember(nodeName, parents{k}));
       
        M(j,idxofpar(k)) = 1;
        M(idxofpar(k),j) = 1;
    end
    
    % Moralization of parents: parents of any node should be connected
    for l = 1:nparents
        for m = (l+1):nparents
            M(idxofpar(l),idxofpar(m)) = 1;
            M(idxofpar(m),idxofpar(l)) = 1;      
        end 
    end
end

M = logical(M);

end
