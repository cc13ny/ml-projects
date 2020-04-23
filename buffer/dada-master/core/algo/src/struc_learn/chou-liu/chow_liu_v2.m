function [ px, pxx, I, TreeAdjMat, npot, epot] = chow_liu_2
% Structure Learning of tree-structured MRFs:
%   Find MLE undirected tree using Chow-Liu algorithm
% This function is specified for binary values for each node.
%
% px:  a N-by-2 matrix, each row of which represents the empirical
%      probabilities of each node for binary state, i.e. 0 and 1.
% 
% pxx: a N-by-N marginal matrix, pxx(i,j) of which represents the empirical
%      marginal for the edge between node x_i and node x_j
%
% TreeAdjMat: a N-by-N adjacency matrix to indicate the existence of edges
%% Stepup
C = dlmread('chowliu-input.txt'); % C(i,j): the value of case(image) i = 1:N, node(object type) j = 1:M
[N, M] = size(C);

%% Step1: Compute each edge weight based on the empirical mutual information
% % Empirical Node Probabilities: [px(1,:) = p(x = 0)]  [px(2,:) = p(x = 1)]
% px = [1 - sum(C)/N; sum(C)/N];
% px = px';

% Empirical Marginals
numval = 2;% 0 and 1;
pxx = zeros(M,M,numval,numval);
values = [0,1];

imgs = C';

for v1=1:numval,
  for v2=1:numval,
    A = double(imgs==values(v1));
    B = double(imgs==values(v2));
    pxx(:,:,v1,v2) = A*B';
  end;
end;


%     % i = 0 and j = 0
%     pxx(:,:,1,1) = (1 - C)' * (1 - C);
%     
%     % i = 0 and j = 1
%     pxx(:,:,1,2) = (1 - C)' * C;
% 
%     % i = 1 and j = 0
%     pxx(:,:,2,1) = pxx(:,:,1,2)';
% 
%     % i = 1 and j = 1
%     pxx(:,:,2,2) = C' * C;

pxx = pxx/N;

% Empirical Node Probabilities:
px2 = reshape(pxx,M^2,numval^2);
px = px2(find(eye(M)),find(eye(numval)));

% Compute the empirical mutual information
minprob = 1/N;% avod prob == 0
hx  = -sum(px.*log(max(px,minprob)),2);
hx  = hx(:,ones(1,M));
hxx = -sum(sum(pxx.*log(max(pxx,minprob)),3),4);
I = -hxx+hx+hx'; % mutual information
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Step2: Find a Maximum Spanning Tree with Kruskal or Prim's Algorithm
[TreeAdjMat, ~] = MinimumSpanningTree( -I );% find max weight spanning tree
TreeAdjMat = TreeAdjMat - diag(diag(TreeAdjMat));% no edges between the same node

%% Step3: Output a pairwise MRF with edge and node potentials as specified
npot = px; %node potentials
epot = repmat(TreeAdjMat,[1,1,numval, numval]).* max(pxx,minprob); %edge potentials

% Write UAI file for Markov Network
fid = fopen( 'chowliu-output.uai', 'w' );
    fprintf(fid,'%s\n', 'MARKOV');
    fprintf(fid,'%d\n', M); %numbers of nodes
    fprintf(fid, '%d ', 2*ones(1,M)); %numbers of cardinalities of each variable
    fprintf(fid, '\n%d\n', (M + sum(sum(TreeAdjMat))/2));%numbers of cliques
    for i = 0:M-1
        fprintf(fid,'1 %d\n',i);
    end
    
    for i = 0:M-1
        for j = (i+1):M-1
            if (TreeAdjMat(i+1,j+1) == 1)
                fprintf(fid, '2 %d %d\n',i,j);
            end
        end
    end
     
    for i = 0:M-1
        fprintf(fid, '\n%d\n',numval);
        fprintf(fid,' %f',px(i+1,:));
        fprintf(fid,'%s\n', ' ');
    end
    
    statCombs = numval * numval;
    for i = 0:M-1
        for j = (i+1):M-1
            if (TreeAdjMat(i+1,j+1) == 1)
                fprintf(fid,'%s\n', ' ');
                fprintf(fid, '%d\n',statCombs);
                tmp = reshape(epot(i+1,j+1,:,:),2,2);
                fprintf(fid,' %f',tmp(1,:));
                fprintf(fid,'%s\n', ' ');
                fprintf(fid,' %f',tmp(2,:));
                fprintf(fid,'%s\n', ' ');
            end
        end
    end
    
    
    
fclose(fid);


end

