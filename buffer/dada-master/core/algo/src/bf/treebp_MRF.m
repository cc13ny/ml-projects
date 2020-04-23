function [ npot, epot, TreeAdjMat ] = treebp_MRF( filename )
%TREEBP_MRF Summary of this function goes here
%   Detailed explanation goes here

fid = fopen(filename, 'r');
fgetl(fid);% 1st line: MARKOV

nnodes = str2num(fgetl(fid)); % 2nd line: Numbers of variables
numval = 2;
npot = zeros(nnodes,numval);
epot = zeros(nnodes, nnodes, numval, numval);
TreeAdjMat = zeros(nnodes, nnodes);

fgetl(fid); % 3rd line: Numbers of cardinalities for all variables
ncliques = str2num(fgetl(fid)); %4nd line: numbers of cliques
nedges = ncliques - nnodes;
E = zeros(nedges,2);

for i = 1:nnodes
    fgetl(fid);% ignore all the cliques for each single node
end

for k = 1:nedges
    tline = fgetl(fid);
    nodes = strsplit(tline);
    
    i = str2num(nodes{2});
    j = str2num(nodes{3});
    
    E(k,:) = [i j];
    
    TreeAdjMat(i+1,j+1) = 1;
    TreeAdjMat(j+1,i+1) = 1;
end

fgetl(fid);% the line after all cliques (nodes and edges)

for i = 1:nnodes
    fgetl(fid);% ignore the number of conditional probabilities

    tline = fgetl(fid);
    probs = strsplit(tline);
    prob0 = str2double(probs{2});
    
    prob1 = str2double(probs{3});
    
    npot(i, :) = [prob0, prob1];
    fgetl(fid);% ignore the blanket 
end

for k = 1:nedges
    fgetl(fid); % ignore the number of conditional probabilities
    
    i = E(k,1);
    j = E(k,2);
    
    for l = 1:numval
        tline = fgetl(fid);
        probs = strsplit(tline);
    
        prob0 = str2double(probs{2});
        prob1 = str2double(probs{3});
        
        epot(i+1,j+1, l,:) = [prob0 prob1];
    end
    
    epot(j+1,i+1,:,:) = reshape(epot(i+1,j+1,:,:),[numval, numval])';
    fgetl(fid);% ignore the blanket 
end

TreeAdjMat = logical(TreeAdjMat);

fclose(fid);

end

