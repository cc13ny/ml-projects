function [ order ] = minFillElimOrder(M, nodeNames)
% Greedily find an elimination order which minimizes the number of edges 
% that need to be added to the graph due to its elimination
%
% Break ties by minimizing the first one of nodes which meet the
% requirements
% 
% The number of added fill edges is caculated from the moralized Bayesian
% Network. So the edge between parents of any node will not be the fill
% edge

nnodes = size(M, 1); 
marked = false(1, nnodes); % used to mark whether a node is added to the order
order  = zeros(1, nnodes);
nFillEdges = 0;
inducedWidth = 0;
isVarsinLgstCliq = 0;

% Because we need to order all nodes in an elimination order, thus there're
% nnodes rounds for selecting node. At each round, one node is selected
% from the candiates (available nodes). A variable newFill is used to
% record for each candidate about how many fill edges are added if this
% candidate is eliminated from the modified graph. The term "modified"
% means that the original graph will be modified at each round by
% eliminating the selected variable.

for i=1:nnodes
    candidates  = find(~marked); % indices of candidates among nodes
    ncandidates = numel(candidates);
    newFill = zeros(ncandidates,1);
    
    for j = 1:ncandidates
        nbrs = M(candidates(j),:); % find the neighbours of candidate j
        nnbrs = sum(nbrs); % number of neighbours
        nbrSubGraph = M(nbrs, nbrs); % Need to check the connections between these neighbours
        
        % For n nodes, the number of connections of the fully connected
        % graph of these nodes is n*(n-1)/2. So the number of new fill
        % edges is the same as the number of connections of the fully
        % connected graph of neighbours minus the existing number of
        % connections between them
        
        newFill(j) = nnbrs * (nnbrs - 1)/2 - sum(sum(nbrSubGraph))/2;
    end
    
    % Find the node with minimal fills using the strategy of choosing the
    % first such node for breaking ties
    [nAddedFills, minFillIdx] = min(newFill);
    
    % Update the unmber of fill-in edges
    nFillEdges = nFillEdges + nAddedFills;
    
    % Update the induced width if needed
    nvarsinFac = sum(M(minFillIdx,:));    
    if inducedWidth < nvarsinFac,
        inducedWidth = nvarsinFac;
        isVarsinLgstCliq = M(minFillIdx, :);
        isVarsinLgstCliq(minFillIdx) = 1;
    end
    
    % Update the order
    order(i) = candidates(minFillIdx);
    
    % Mark the variable to be true
    marked(order(i)) = true; % the selected node has been added
    
    % Modification of the graph M (1):
    %   make connection between neighbors of the variable
    nbrs = M(order(i),:);
    nnbrs = sum(nbrs);
    nbrSubGraph = ones(nnbrs, nnbrs); % the subgraph of the neighbour is full connected
    nbrSubGraph(logical(eye(nnbrs))) = 0;
    M(nbrs, nbrs) = nbrSubGraph;
    
    % Modification of the graph M (2):
    %   eliminate the selected varaible
    M(order(i),:) = zeros(1, nnodes);
    M(:,order(i)) = zeros(nnodes, 1);
end

% Print out the ordering
disp('The elimination ordering found by the min-fill heuristic is:')
disp(nodeNames(order));

% Print out the added fill edges
disp(['The number of added fill edges is: '  num2str(nFillEdges)]);
fprintf('%s\n',' ');

% Print out the induced width of this graph and the variables of the 
% largest clique
disp(['The induced width is: ' num2str(inducedWidth)]);
fprintf('%s\n',' ');
disp('The variables in the largest cliques is :');
disp(nodeNames(isVarsinLgstCliq));

end

