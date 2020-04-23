function [ Factors ] = sumProdElimVar(Factors, Z)
   dispFactors(Factors); %an be deleted
   
   % 1. Find all factors including Z from the whole Factors   
   [ZFactors, idxZFactors] = findZFactors(Factors, Z);
   
   % 2. Delete all factors including Z from the whole Factors
   Factors(idxZFactors,:) = [];%instead of Factors(idxZFactors)%

   % 3. Merge all factors including Z
   T = mergeFactors(ZFactors);
   dispZFactors(Z, ZFactors); %can be deleted
   
   % 4. Create of a new factor by Eliminateing Z
   [T] = createFacByElimZ(T, Z);

   % 5. Add new Factor into the remaining Factos without Z
   Factors{end+1,:} = T;%instead of Factors{end+1}%
   dispFacAftElimZ(T, Z); %can be deleted
   
end

%% The functions shown below are for the concrete implementation of steps of the function above
% Find the factors including the variable Z (which will be eliminated)
function [ZFactors, idxZFactors] = findZFactors(Factors, Z)
   idxZFactors = [];
   for j = 1:numel(Factors)
       if sum(strcmp(Factors{j}{1},Z))~= 0
           idxZFactors = [idxZFactors;j];
       end
   end
   ZFactors = Factors(idxZFactors,:);%instead of Factors(idxZFactors)%
end

% Eliminate Z from one factor 
function [T] = createFacByElimZ(T, Z)
   % Delete Z from T{1}
   idxZ = find(ismember(T{1},Z));
   T{1}(idxZ) = [];
   
   % Delete the number of states of Z from T{2}
   nZStates = T{2}(idxZ);
   nTStateCombs = cumprod(T{2});
   nPreZStateCombs = 1;
   if idxZ ~= 1,
        nPreZStateCombs = nTStateCombs(idxZ - 1);
   end
   T{2}(idxZ) = [];
   
   % Delete the states of Z from T{3}
   T{3}(idxZ) = [];

   % Update T{4} by eliminateing Z
   m = nPreZStateCombs;
   elimZmat = repmat(eye(m, m),1, nZStates);

   n = m * nZStates;
   nZGroups = numel(T{4})/n;

   tmp = zeros(m*nZGroups,1);
   for k = 1:nZGroups
       tmp((1:m)+(k-1)*m) = elimZmat * T{4}((1:n)+(k-1)*n);
   end
   T{4} = tmp;% 
end

%% The functions shown below are only for debug purposes
% For debug: display each factor with the names of its variables
function dispFactors(Factors)
   disp('------------------FFFFFFFFFactors--------------------');
   for jj = 1:numel(Factors)
       fprintf('%d th factor:\n', jj);
       disp(Factors{jj}{1});
       disp('********************************');
   end
   disp('---------------------------------------------');
   pause;
end

% For debug: display Z and the factors including Z
function dispZFactors(Z, ZFactors)
   fprintf('%s\n',' ');
   disp('/////////////////////////////////////////');
   disp([ '[ ' Z ' ] to be eliminated']);
   disp('/////////////////////////////////////////');
   fprintf('%s\n',' ');
   pause;

   disp('------------------ZZZZZZZZZZZFactors--------------------');
   nZFactors = numel(ZFactors);
   for jj = 1:nZFactors
       fprintf('%d th zfactor:\n', jj);
       disp(ZFactors{jj}{1});
       disp('********************************');
   end
   disp('---------------------------------------------');
   fprintf('%s\n',' ');
   pause;
end

% For debug: display ZFactors after eliminating Z
function dispFacAftElimZ(T, Z)
   disp(['============ Factor by Eliminateing [' Z '] ============']);      

   fprintf('%s\n',' ');
   disp(T{1});
   fprintf('%s\n',' ');

   disp('===================================================');
   fprintf('%s\n',' ');
   pause;
end
