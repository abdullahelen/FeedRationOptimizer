function result = funcGA(data, zooTech)
    %% Initials
    Dim = size(data, 1); % Dimension
    Lb = zeros(1, Dim); % Lower-bound
    Ub = ones(1, Dim) * zooTech.DMI; % Upper-bound
    
    %% Fitness function
    fitFunc = @(x) funcFitness(x, data, zooTech);
    
    %% GA options
    options = optimoptions('ga', ...
        'PopulationSize', 100, ...
        'MaxGenerations', 500, ...
        'MaxStallGenerations', 100, ...
        'SelectionFcn', {@selectionroulette}, ...
        'CrossoverFcn', {@crossoversinglepoint}, ... % crossoverscattered, crossoversinglepoint, crossoverintermediate
        'CrossoverFraction', 0.85, ...
        'PlotFcn', {'gaplotbestf', 'gaplotbestindiv', ...
            'gaplotexpectation', 'gaplotrange', 'gaplotdistance', ...
            'gaplotselection'});
    
    %% Find minimum of function using Genetic Algorithm.
    [x, Fval, exitFlag, Output] = ...
        ga(fitFunc, Dim, [], [], [], [], Lb, Ub, [], [], options);
    
    %% Set tolerance
    x(x(:, 1:18) < 0.05) = 0;
    x = round(x, 2);

    %% Set result
    result.X = x;
    result.Fval = Fval;
    result.exitFlag = exitFlag;
    result.Output = Output;
end
