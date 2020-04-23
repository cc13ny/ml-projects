%function [varFactors, evidFactors, vFactor, eFactor] =  condProbQuery( Factors, nodeNames, order, queryVars, evidences)
%function [varFactors, evidFactors, cprob] =  condProbQuery( Factors, nodeNames, order, queryVars, evidences)
function [varFactors] =  condProbQuery( Factors, nodeNames, order, queryVars, evidences)


% Factors: please refer to the function "graph_preprocess" for the details 
%          of Factors
%
% queryVars: a column cell array with each element as 
%            a pair (variable, state)
%
% Evidences: a column cell array with each element as 
%            a pair (variable, state)

%% 0. Setup
% Extract names of query variables and convert their names into capatial letters 
[queryVarNames, queryVars] = extractNameWithCap(queryVars);

% Extract names of evidences and convert their names into capatial letters 
[evidNames, evidences] = extractNameWithCap(evidences);

% Names of query variables and evidences
varNames = [queryVarNames; evidNames];

% Combine query variables and evidences into an unity
if size(queryVars,2) > 1
    queryVars = queryVars';
end

if size(evidences,2) > 1
    evidences = evidences';
end

vars = [queryVars;evidences];
%% 1. Factors for queryVars and Evidences
fprintf('%s\n', ' ');
disp('########### Initial Factors for queryVars and Evidences ############');
varFactors = Factors;
%for i=1:numel(nodeNames)
for i=1:37

    z = order(i);% index of variable to be eliminated
    Z = nodeNames{z};
    
    % Sum-Product-Elim-Var(Factors, Z)
    if sum(strcmp(varNames, Z)) == 0,
        varFactors = sumProdElimVar(varFactors, Z);
    end
end

% dispVarsFac(varFactors);% can be deleted
% 
% %% 2. Factors for Evidences
% nqueryVars = numel(queryVars);
% evidFactors = varFactors;
% ordQryVars = intersect(nodeNames, queryVarNames,'stable');
% 
% fprintf('%s\n', ' ');
% disp('########### Intial Factor for Evidences ############');
% for i=1:nqueryVars
%     Z = ordQryVars{i};
%     evidFactors = sumProdElimVar(evidFactors, Z);
% end
% 
% dispEvidFac(evidFactors);% can be deleted
% 
% %% 3. Merge Factors for Calculation of the probabilities of queryVars and Evidences
% vFactor = mergeFactors(varFactors);
%    
% %% 4. Merge Factors for Calculation of the probabilities of Evidences
% eFactor = mergeFactors(evidFactors);
% 
% %% 5. The specific probability for queryVars and Evidences
% vprob = specProb(vars, varNames, vFactor);
% 
% %% 6. The specific probability for Evidences
% eprob = specProb(evidences, evidNames, eFactor);
% 
% %% 7. Calculation of the conditional probability
% cprob = vprob/eprob;

end 

%% The functions below are for the concrete implementation of different parts of the function above
% % Extract names of variable and convert their names and states into capatial letters 
% function [varNames, vars] = extractNameWithCap(vars)
%     nvars = numel(vars);
%     varNames = cell(nvars,1);
%     for i = 1:nvars
%         vars{i}{1} = upper(vars{i}{1});
%         vars{i}{2} = upper(vars{i}{2});
%         varNames{i} = vars{i}{1};
%     end
% end

% Get access to the probability with specified values
function [specprob] = specProb(vars, varNames, Factor)
    % 1. Find the index of each variable in their factor
    [~,~, varinFacIdx] = intersect(varNames, Factor{1},'stable');
    
    % 2. Convert states to its equivalence number, e.g. NORMAL is the 2nd
    %    state of 'PVSAT', then its number is 2 for 'PVSAT'
    nvars = numel(vars);
    subscripts = zeros(1,nvars);% used for the related probability
    for i = 1:nvars
        varValue = vars{i}{2};
        idx = varinFacIdx(i);
        varStates = Factor{3}{idx};
                
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        subscripts(idx) = find(strcmp(varStates, varValue));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    end
    % 3. Find the index of the probability on the full table based on the
    %    subscript
    nVarStateCombs = cumprod(Factor{2});
    if numel(subscripts)~= 1,
       n = (subscripts(2:end)-1) * nVarStateCombs(1:end-1) + subscripts(1);
    else
       n = subscripts;
    end
    % 4. Get access to the probability    
    specprob = Factor{4}(n);
    
end


%% The functions below are only for debug purposes
% For debug: display the factors for evidents
function dispEvidFac(evidFactors)
   disp('$$$$$$$$$$$ Final Factosr for Evidences $$$$$$$$$$$$');
   for jj = 1:numel(evidFactors)
       fprintf('%d th factor:\n', jj);
       disp(evidFactors{jj}{1});
       disp('********************************');
   end
   disp('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
   pause;
end

% For debug: display the factors for query variable and evidents
function dispVarsFac(varFactors)
   disp('$$$$$$$$$ Final Factosr for queryVars and Evidences $$$$$$$$$$');
   for jj = 1:numel(varFactors)
       fprintf('%d th factor:\n', jj);
       disp(varFactors{jj}{1});
       disp('********************************');
   end
   disp('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
   pause;
end

