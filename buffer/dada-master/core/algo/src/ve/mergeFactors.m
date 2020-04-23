function [T] = mergeFactors(Factors)
   nFactors = numel(Factors);
   T = Factors{1};
   for j = 2:nFactors
       % Here, I use a example to illustrate the following steps
       %    T{1} = {A, B, D}, 
       %    Factors{j}{1} = {C, D, E, B},
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       U = union(T{1},Factors{j}{1},'stable');% U = {A, B, D,   C, E}
       I = intersect(T{1},Factors{j}{1},'stable'); % I = {B, D}
       [D, idxD] = setdiff(Factors{j}{1},T{1},'stable'); % D = {C, E}, idxD = [1, 3], the index of D in {C, D, E, B}
       ID = union(I, D, 'stable');% ID ={B, D, C, E}
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

       % update the 1st item: names of nodes in this combined factor
       T{1} = U; % {A, B, D, C, E}

       % update the 2nd item: number of states for each node in this combined factor
       T{2} = [T{2};Factors{j}{2}(idxD)];

       % update the 3rd item 
       T{3} = [T{3};Factors{j}{3}(idxD)];
       
       % update the 4th item
       nTStateCombs = cumprod(T{2}); % for {A, B, D, C, E} with 2 states for each variable, then [2, 4, 8, 16, 32]
       npreTStateCombs = [1;nTStateCombs(2:end)]; % e.g. [1, 2, 4, 8, 16]
       nFStateCombs  = cumprod(Factors{j}{2}); % for {C, D, E, B} with 2 states for each variable, then [2, 4, 8, 16]
       T{4} = repmat(T{4}, [nTStateCombs(end)/nTStateCombs(numel(U) - numel(D)),1]); % extend T{4} if needed

       [~, idxID] = intersect(U,ID,'stable'); % Indices of {B, D, C, E} in U = {A, B, D, C, E}, i.e. idxID = [2,3,4,5]
       [~, ~,orderID] = intersect(Factors{j}{1}, ID,'stable'); % for reording {B, D, C, E} as {C, D, E, B} 
       %[~, ~,orderID] = intersect(ID, Factors{j}{1},'stable'); % for reording {C, D, E, B} as {B, D, C, E}
       
       
%        %%%%%%%%%%%%
%        for n = 1:nFStateCombs(end) 
%            j,n,
%            % n --> e.g. c_1d_2e_1b_2
%            r = mod(n,nFStateCombs);
%            r = r + (r==0).*nFStateCombs;
%            idxFStates = [];
%            if numel(r) == 1
%                idxFStates = r(1);
%            else
%                idxFStates = [r(1); ceil(r(2:end)./nFStateCombs(1:end-1))];
%            end
%            
%            % Calculate m
%            idxIDTStates = idxFStates(orderID);% e.g. c_1d_2e_1b_2 --> b_2d_2c_1e_1
%            nIdxIDTStates = numel(idxIDTStates);
%            tmp = (1:nTStateCombs(end))';
%            m = true(nTStateCombs(end),1);
%            for idx = 1:nIdxIDTStates
%                idxIDTState = idxID(idx);
%                TStateCombs = nTStateCombs(idxIDTState);
%                r = tmp/TStateCombs;
%                r = r + (r == 0)*TStateCombs;
%                preTStateCombs = npreTStateCombs(idxIDTState);
%                subs = ceil(r/preTStateCombs);
%                m = m & (subs == idxIDTStates(idx));
%            end
%            
%            % Multiply
%            T{4}(m) = T{4}(m) * Factors{j}{4}(n);
%        end
       
       %join the full table of {A, B, D} with {C, D, E, B} as {A, B, D, C, E} by multiplying f_1(a,b,d) with the corresponding f_2(c,d,e,b)
       for m = 1:nTStateCombs(end) % e.g. 1:32, loop for each potential in {A, B, D, C, E}
           r = mod(m,nTStateCombs(idxID)); % e.g. m = 7 with [4, 8, 16, 32] for [B, D, C, E], r = [3, 7, 7, 7]
           r = r + (r == 0).* nTStateCombs(idxID);
           idxTStates = [];
           if idxID(1)~= 1 %Then we can calculate which states for {B, D, C, E} when m = 7
               idxTStates = ceil(r./nTStateCombs(idxID - 1)); % b_2d_2c_1e_1 when m = 7
           else
               tmp = idxID;
               tmp(1) = [];
               if ~isempty(tmp)
                   idxTStates = [r(1); ceil(r(2:end)./nTStateCombs(tmp - 1))];
               else
                   idxTStates = r(1);
               end
           end

           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
           idxFStates = idxTStates(orderID); % b_2d_2c_1e_1 --> c_1d_2e_1b_2
           if numel(idxFStates)~= 1,
               n = nFStateCombs(1:end-1)' * (idxFStates(2:end)-1) + idxFStates(1);
           else
               n = idxFStates;
           end

           T{4}(m) = T{4}(m) * Factors{j}{4}(n);
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       end           
   end
end
