function [TreeRank, E, bels, msg_neg] = maxProdBelProg( filename )
%SUMPRODBELPROG Summary of this function goes here
%   Detailed explanation goes here
%% Setup: Read UAI file and build the Graph (MARKOV & BAYES)
% npot: potentials of all nodes
% epot: potentials of all edges
% E: a logical matrix for indicating the existences of edges

[ npot, epot, E ] = treebp_MRF( filename );
nnodes = size(npot, 1);
bels = zeros(nnodes,1);

%% Tree Rank: defined by the distances from the root or the numbers of nodes it goes through
TreeRank(1:nnodes) = 0; % 0 for root, higher rank represents bigger distances from root
marked = false(1, nnodes);
root = (1:nnodes == randi(nnodes));
marked(root) = true;
pointer = root;

while prod(marked) == 0,
    pointer = ~marked & logical(sum(E(pointer,:),1)); % point to children
    TreeRank(~marked) = TreeRank(~marked) + 1;
    marked(pointer) = true;
end

%% Collect Evidence Phase/ Bottom-Up Belief State
[bels, msg_neg] = BottomUpBelProp(root, E, TreeRank, npot, epot);


%% Distribute Evidence Phase/ Top-Down Belief State

bels = TopDownBelProp(root, bels, msg_neg, E, TreeRank, epot);

end

function [bel_nodes, msg_neg] = BottomUpBelProp(nodes, E, TR, np, ep)
    % nodes is a logical vector to indicate the existence of which nodes
    num = sum(nodes);
    nnodes = size(np,1);
    bel_nodes = zeros(nnodes,2);
    msg_neg = zeros(nnodes, nnodes, 2);
    idx = find(nodes);
    for i = 1:num
        nodei = idx(i); 
        TR_node = TR(nodei);
        children = E(nodei, :)&(TR > TR_node);
        bel_node = 0;
        bel_children = zeros(size(np,1),2);
        if sum(children)~= 0,
            % This transformation is used to extract the edge potentials
            % for each child (node). At the end, ep_st becomes a matrix
            % with dimension, (numbers of children)-by-(product of numbers 
            % of cardinalities for all variables)
            ep_st = ep(nodei, children, :, :);
            ep_st = reshape(ep_st, [sum(children), 2*2]);
            
            % bel_children is a nnodes-by-2 matrix with the corresponding
            % bels of children
            
            [bel_children, msg_children] = BottomUpBelProp(children, E, TR, np, ep);
            msg_node = [max(bel_children(children, :).* ep_st(:, logical([1 0 1 0])) ,[], 2),...
                        max(bel_children(children, :).* ep_st(:, logical([0 1 0 1])) ,[], 2)];
            %msg_node,pause,
            msg_children(nodei, children,:) = msg_node;%
            msg_children(children, nodei,:) = msg_node;%
            msg_neg = msg_neg + msg_children;
            bel_node = np(nodei,:).* prod(msg_node);
            bel_node = bel_node/sum(bel_node);% normalization
            bel_nodes = bel_nodes + bel_children;
        else
            bel_node = np(idx(i));
        end
        
        bel_nodes(nodei,:) = bel_node;
    end
end

function [bel_nodes] = TopDownBelProp(nodes, bel, msg_neg, E, TR, ep)
    num = sum(nodes);
    bel_nodes = zeros(size(E,1),2);
    bel_nodes(nodes,:) = bel(nodes,:);
    idx = find(nodes);
    for i = 1:num
        nodei = idx(i);
        
        TR_node = TR(nodei);
        children = E(nodei, :)&(TR > TR_node);
        bel_node = 0;
        bel_children = zeros(size(E,1),2);
        if sum(children)~=0
        
            msg = msg_neg(nodei, children,:);
            msg = reshape(msg, [sum(children), 2]);
            
            ep_ts = ep(nodei, children, :, :);
            ep_ts = reshape(ep_ts, [sum(children), 2*2]);
          
            
            bel_msg = (ones(sum(children), 1) * bel(nodei,:))./msg;
            
            msg_node = [max(bel_msg.* ep_ts(:, logical([1 1 0 0])) ,[],2),...
                        max(bel_msg.* ep_ts(:, logical([0 0 1 1])) ,[],2)];
            bel_neg = bel(children,:).* msg_node;
            bel_node = bel_neg./(sum(bel_neg,2)*ones(1,2));
            
            tmp = bel;
    
            tmp(children,:) = bel_node;
                        
            bel_children = TopDownBelProp(children, tmp, msg_neg, E, TR, ep);
            
            bel_nodes = bel_nodes + bel_children;
        end
        
    end

    
end
