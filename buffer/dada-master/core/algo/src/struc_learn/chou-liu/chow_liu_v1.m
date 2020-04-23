function [ px, pxx, I, TreeAdjMat, npot, epot] = chow_liu_v1
%CHOW-LIU Summary of this function goes here
%   Detailed explanation goes here

%% Stepup
C = dlmread('chowliu-input.txt');

%% Step1: Compute each edge weight based on the empirical mutual information
% collect counts and calculate joint probabilities

[N, M] = size(C);

% Node Probabilities px(1,:) = p(x = 0), px(2,:) = p(x = 1)
px = [1 - sum(C)/N; sum(C)/N];
px = px';

% Marginal Probabilities/ Edge Potentials/ Joint Probabilities
numval = 2;% 0 and 1;
pxx = zeros(M,M,numval,numval);

    % i = 0 and j = 0
    pxx(:,:,1,1) = (1 - C)' * (1 - C);
    tmp = pxx(:,:,1,1);
    pxx(:,:,1,1) = tmp - diag(diag(tmp));

    % i = 0 and j = 1
    pxx(:,:,1,2) = (1 - C)' * C;
    tmp = pxx(:,:,1,2);
    pxx(:,:,1,2) = tmp - diag(diag(tmp));

    % i = 1 and j = 0
    pxx(:,:,2,1) = pxx(:,:,1,2)';

    % i = 1 and j = 1
    pxx(:,:,2,2) = C' * C;
    tmp = pxx(:,:,2,2);
    pxx(:,:,2,2) = tmp - diag(diag(tmp));

pxx = pxx/N;

% Compute the empirical mutual information
I = zeros(M,M);

Pxpx = zeros(M,M,numval,numval); 

for i = 1:numval
    for j = 1:numval
        Pxpx(:,:,i,j) = px(:,i) * px(:,j)';
    end
end

pxxnil = pxx == 0;
tmp = pxx;
tmp(pxxnil) = 1;

Iij = pxx .* log(tmp./Pxpx);

I = sum(sum(Iij,3),4);

%% Step2: Find a Maximum Spanning Tree with Kruskal or Prim's Algorithm
[TreeAdjMat, ~] = MinimumSpanningTree( -I );% find max weight spanning tree
TreeAdjMat = TreeAdjMat - diag(diag(TreeAdjMat));

%% Step3: Output a pairwise MRF with edge and node potentials as specified
npot = px; %node potentials
epot = repmat(TreeAdjMat,[1,1,numval, numval]).* (pxx./Pxpx); %edge potentials

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
