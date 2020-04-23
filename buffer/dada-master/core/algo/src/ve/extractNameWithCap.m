% Extract names of variable and convert their names and states into capatial letters 
function [varNames, vars] = extractNameWithCap(vars)
    nvars = numel(vars);
    varNames = cell(nvars,1);
    for i = 1:nvars
        vars{i}{1} = upper(vars{i}{1});
        vars{i}{2} = upper(vars{i}{2});
        varNames{i} = vars{i}{1};
    end
end
