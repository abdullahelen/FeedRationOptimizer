function result = funcReport(data, cattle, zooTech, x)
    % GA
    resultRation = funcFeats(data, x);
    
    % ID, Criterion, Expected Value (ZooTekni), Found Value (GA)
    varTypes = {'uint32', 'categorical', 'categorical', 'categorical'};
    tableResult = table('Size', [12, 4], ...
        'VariableTypes', varTypes, ...
        'VariableNames', {'#', 'Requirements', 'NRC', 'GA'});
    
    idx = 1;
    
    %% 1. Dry Material Intake (DMI)
    gaDMI = round(sum(resultRation.DryMatter), 2);
    tableResult(idx, :) = {idx, 'Dry Material Intake (DMI)', ...
        [num2str(round(zooTech.DMI, 2)), ' Kg'], [num2str(gaDMI), ' Kg']};
    
    idx = idx + 1;
    
    %% 2. Crude Protein (CP)
    gaCP = round(sum(resultRation.CrudeProtein) * 1000, 2);
    tableResult(idx, :) = {idx, 'Crude Protein (CP)', ...
        [num2str(round(zooTech.CP, 2)), ' g'], [num2str(gaCP), ' g']};
    
    idx = idx + 1;
    
    %% 3. Metabolical Energy (ME)
    gaME = round(resultRation.TotalME, 2);
    tableResult(idx, :) = {idx, 'Metabolical Energy (ME)', ...
        [num2str(round(zooTech.ME * cattle.Ym + zooTech.MEm, 2)), ' Mcal'], [num2str(gaME), ' Mcal']};
    
    idx = idx + 1;
    
    %% 4. Net Energy for Lactation (NEL)
    gaNEL = round(resultRation.TotalNEL, 2);
    tableResult(idx, :) = {idx, 'Net Energy for Lactation (NEL)', ...
        [num2str(round(zooTech.NEL * cattle.Ym + zooTech.NEm, 2)), ' Mcal'], [num2str(gaNEL), ' Mcal']};
    
    idx = idx + 1;
    
    %% 5. Ash Ratio
    gaAshRatio = round(resultRation.AshRatio, 2);
    tableResult(idx, :) = {idx, 'Ash Ratio', ...
        '%10≤ DM', ['%', num2str(gaAshRatio)]};
    
    idx = idx + 1;
    
    %% 6. Sugar Ratio
    gaSugarRatio = round(resultRation.SugarRatio, 2);
    tableResult(idx, :) = {idx, 'Sugar Ratio', ...
        '%8≤ DM', ['%', num2str(gaSugarRatio)]};
    
    idx = idx + 1;
    
    %% 7. Starch Ratio
    gaStarchRatio = round(resultRation.StarchRatio, 2);
    tableResult(idx, :) = {idx, 'Starch Ratio', ...
        '%35≤ DM', ['%', num2str(gaStarchRatio)]};
    
    idx = idx + 1;
    
    %% 8. Ether-extract Ratio
    gaEtherExtractRatio = round(resultRation.EtherExtractRatio, 2);
    tableResult(idx, :) = {idx, 'Ether-extract Ratio', ...
        '%6≤ DM', ['%', num2str(gaEtherExtractRatio)]};
    
    idx = idx + 1;
                
    %% 9. Forage Ratio
    gaForageRatio = round(resultRation.ForageRatio, 2);
    tableResult(idx, :) = {idx, 'Forage Ratio', ...
        '%40≥ DM', ['%', num2str(gaForageRatio)]};
    
    idx = idx + 1;
                
    %% 10. NDF Ratio
    gaNDFRatio = round(resultRation.NDFRatio, 2);
    tableResult(idx, :) = {idx, 'NDF Ratio', ...
        '%25<NDF<%35 DM', ['%', num2str(gaNDFRatio)]};
    
    idx = idx + 1;
    
    %% 11. Calcium (Ca) Amount
    gaCa = round(sum(resultRation.Ca), 2);
    tableResult(idx, :) = {idx, 'Calcium (Ca) Amount', ...
        [num2str(round(zooTech.Ca, 2)), ' g'], [num2str(gaCa), ' g']};
    
    idx = idx + 1;
    
    %% 12. Phosphor (P) Amount
    gaP = round(sum(resultRation.P), 2);
    tableResult(idx, :) = {idx, 'Phosphor (P) Amount', ...
        [num2str(round(zooTech.P, 2)), ' g'], [num2str(gaP), ' g']};
    
    idx = idx + 1;
    
    %% 13. Total Price
    tableResult(idx, :) = {idx, 'Total Price', ...
        '-', [num2str(round(resultRation.TotalPrice, 2)), ' TL']};
    
    idx = idx + 1;
    
    %% 14. Total Weight
    tableResult(idx, :) = {idx, 'Total Weight', ...
        '-', [num2str(round(resultRation.TotalWeight, 2)), ' Kg']};
    
%             % 13. Sodium (Na) Amount
%             gaNa = round(sum(resultRation.Na), 2);
%             tableResult(idx, :) = {idx, 'Sodium (Na) Amount', ...
%                 '??? g', [num2str(gaNa), ' g']};
    
    
    result.Table = tableResult;
    
    
    varTypes = {'uint32', 'categorical', 'categorical'};
    tableFeats = table('Size', [4, 3], ...
        'VariableTypes', varTypes, ...
        'VariableNames', {'#', 'Feature', 'Value'});
    
    tableFeats(1, :) = {1, 'Body Weight (BW)', [num2str(cattle.BW), ' Kg']};
    tableFeats(2, :) = {2, 'Week of Lactation (WOL)', num2str(cattle.WOL)};
    tableFeats(3, :) = {3, 'Targeted Amount of Milk (Ym)', [num2str(cattle.Ym), ' Kg']};
    tableFeats(4, :) = {4, 'Fat-corrected Milk (Fm)', ['%', num2str(cattle.Fm)]};
    
    result.TableFeats = tableFeats;

    result.TotalWeight = resultRation.TotalWeight;
    result.TotalPrice = resultRation.TotalPrice;
end
