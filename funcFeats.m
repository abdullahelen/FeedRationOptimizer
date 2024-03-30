function result = funcFeats(data, x)
    % Weight of the nutrients
    weights = x';

    % Total weight of the feed ration
    result.TotalWeight = sum(weights);

    % Total price
    result.TotalPrice = sum(data.Price .* weights);

    % Crude Protein
    result.CrudeProtein = (data.CP / 100) .* weights;

    % Dry Matters
    result.DryMatter = (data.DM / 100.0) .* weights;
    % Sum of Dry Matter
    totalDM = sum(result.DryMatter);

    % Metabolical Energy
    result.TotalME = sum(data.ME .* weights);

    % Net Energy for Lactation (NEl)
    result.TotalNEL = sum(data.NEL .* weights);

    % Ash amounts
    result.Ash = (data.Ash / 100.0) .* result.DryMatter;
    % Ash ratio
    result.AshRatio = (sum(result.Ash) / totalDM) * 100;

    % Sugar amounts
    result.Sugar = (data.Sugar / 100.0) .* result.DryMatter;
    % Sugar ratio
    result.SugarRatio = (sum(result.Sugar) / totalDM) * 100;

    % Starch amounts
    result.Starch = (data.Starch / 100.0) .* result.DryMatter;
    % Starch ratio
    result.StarchRatio = (sum(result.Starch) / totalDM) * 100;

    % Ether-extract amounts
    result.EtherExtract = (data.EtherExtract / 100.0) .* result.DryMatter;
    % Ether-extract ratio
    result.EtherExtractRatio = (sum(result.EtherExtract) / totalDM) * 100;

    % Forage amounts
    result.Forage = weights(data.Type == 1);
    % Forage ratio
    result.ForageRatio = (sum(result.Forage) / result.TotalWeight) * 100;
    
    % Calcium (Ca) amounts
    result.Ca = (data.Ca / 100) .* (weights * 1000);
    
    % Phosphor (P) amounts
    result.P = (data.P / 100) .* (weights * 1000);
    
    % Sodium (Na) amounts
    result.Na = (data.Na / 100) .* (weights * 1000);
    
    % NDF amounts
    result.NDF = (data.NDF / 100) .* weights;
    % NDF ratio
    result.NDFRatio = (sum(result.NDF) / totalDM) * 100;
    
    % Salt amounts
    result.Salt = weights(22) * 1000;
    
    % Sodium Bicarbonate (NaHCO3) between 0.7 and 1.5 at DM
    result.NaHCO3 = weights(23) * 1000;
end
