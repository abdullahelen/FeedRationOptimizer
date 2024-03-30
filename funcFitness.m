function result = funcFitness(x, data, reqs)
    %% Set tolerance
    x(x(:, 1:18) < 0.05) = 0;
    x = round(x, 2);
    
    % Get features.
    ration = funcFeats(data, x);
    
    % Find the ones that have zero weight. 
    k = numel(find(x == 0));

    %% The difference between dry matter and "reqs.DMI".
    sumDM = sum(ration.DryMatter);
    minDM = reqs.DMI - min(sumDM, reqs.DMI);
    maxDM = max(sumDM, reqs.DMI * 1.05) - reqs.DMI * 1.05;
    diffDM = minDM + maxDM;

    %% The difference between crude protein and "reqs.CP".
    cp = reqs.CP / 1000.0;
    diffCP = cp - min(sum(ration.CrudeProtein), cp);
    
    %% Ash in the feed ration is at most 10% of the DMI.
    diffAsh = max(ration.AshRatio, 10) - 10;

    %% Sugar in the feed ration is at most 8% of the DMI.
    diffSugar = max(ration.SugarRatio, 8) - 8;

    %% Starch in the feed ration is at most 35% of the DMI.
    diffStarch = max(ration.StarchRatio, 35) - 35;

    %% Ether-extract in the feed ration is at most 6% of the DMI.
    diffEtherExtract = max(ration.EtherExtractRatio, 8) - 8;
    
    %% Roughage ratio should not be less than 40%
    diffForage = 40 - min(ration.ForageRatio, 40);
    
    %% The amount of calcium should not be less than "reqs.Ca"
    sumCa = sum(ration.Ca);
    minCa = reqs.Ca - min(sumCa, reqs.Ca);
    maxCa = max(sumCa, reqs.Ca * 1.5) - reqs.Ca * 1.5;
    diffCa = minCa + maxCa;
    
    %% The amount of phosphorus should not be less than "reqs.P"           
    sumP = sum(ration.P);
    minP = reqs.P - min(sumP, reqs.P);
    maxP = max(sumP, reqs.P * 1.5) - reqs.P * 1.5;
    diffP = minP + maxP;

    %% NDF (Neutral Detergent Fiber) Ratio
    minNDF = 25 - min(ration.NDFRatio, 25);
    maxNDF = max(ration.NDFRatio, 35) - 35;
    diffNDF = minNDF + maxNDF;

    % NDF, BW'nin minimum %1.5'i kadardır.
    % bw = (Cattle.BW * 1.5) / 100.0;
    % diffNDF = bw - min(sum(ration.NDF), bw);
    
    %% The amount of salt should be between 50 and 100 grams.
    minSalt = 50 - min(ration.Salt, 50);
    maxSalt = max(ration.Salt, 75) - 75;
    diffSalt = minSalt + maxSalt;
    
    %% Sodium Bicarbonate (NaHCO3) between 0.7 and 1.5 at DM
    minNaHCO3 = 50 - min(ration.NaHCO3, 50);
    maxNaHCO3 = max(ration.NaHCO3, 75) - 75;
    diffNaHCO3 = minNaHCO3 + maxNaHCO3;    
    
    %% Fitness score
    result = ration.TotalPrice * (1.0 + diffDM * size(x, 2) + ...
        diffAsh * 1.5 + diffSugar + diffStarch + diffEtherExtract + ...
        diffForage * 1.5 + diffCP + diffSalt + diffNaHCO3 + ...
        (diffCa + diffP) * 0.1 + diffNDF * 2.5  - k * 0.1);
end
