% *************************************************************************
% Optimization of Feed Ration Cost in Dairy Cattle by Genetic Algorithm
% 
% Abdullah ELEN (aelen@bandirma.edu.tr) and Ertuğ ATICI
% Bandirma Onyedi Eylul University, Faculty of Engineering and Natural
% Sciences, Software Engineering, Bandirma/Turkiye
% *************************************************************************

clc;
clear;

%% 1. Characteristics of dairy cattle.
cattle = struct();
cattle.BW  = 500;	% Body weight in kg
cattle.WOL = 10;	% Week of lactation
cattle.Ym  = 20;	% Targetted amount of milk in kg
cattle.Fm  = 3.5;	% Fat-corrected milk

%% 2. Get requirements for the dairy cattle.
reqs = funcRequirements(cattle);

disp('<strong>Characteristics of Dairy Cattle:</strong>');
disp([9, '- Body Weight (BW): ', num2str(cattle.BW), ' Kg']);
disp([9, '- Week of Lactation (WOL): ', num2str(cattle.WOL)]);
disp([9, '- Targeted Amount of Milk (Ym): ', num2str(cattle.Ym), ' Kg']);
disp([9, '- Fat-corrected Milk (Fm): %', num2str(cattle.Fm)]);
disp(' ');
disp('<strong>Requirements:</strong>');
disp([9, '- Dry Material Intake (DMI): ', num2str(reqs.DMI), ' Kg']);
disp([9, '- Crude Protein (CP): ', num2str(reqs.CP), ' gr']);
disp([9, '- Digestible Crude Protein (DCP): ', num2str(reqs.DCP), ' gr']);
disp([9, '- Net Energy for Maintenance (NEm): ', num2str(reqs.NEm), ' Mcal']);
disp([9, '- Net Energy for Lactation (NEL): ', num2str(reqs.NEL * cattle.Ym), ' Mcal']);
disp([9, '- Metabolical Energy (ME): ', num2str(reqs.ME * cattle.Ym), ' Mcal']);
disp([9, '- Metabolical Energy for Maintenance (MEm): ', num2str(reqs.MEm), ' Mcal']);
disp([9, '- Calcium (Ca): ', num2str(reqs.Ca), ' gr']);
disp([9, '- Phosphor (P): ', num2str(reqs.P), ' gr']);
disp(' ');

%% 3. The dataset used in the preparation of feed rations for cattle.
disp('<strong>Dataset:</strong>');
data = funcDataset();
disp(data);
disp(' ');

% Control random number generator.
rng('shuffle');

%% 4. Run GA for optimal feed ration solution.
result = funcGA(data, reqs);

% Convert from Kilograms to Grams.
vTbl = [data(:, 1:4), table(round(result.X' * 1000), 'VariableNames', {'Amount'})];
indices = find(vTbl.Amount == 0);
vTbl(indices, :) = [];
vTbl.("#") = (1:size(vTbl, 1))';

%% 5. Creating a report for the NRC and GA result.
gaResult = funcReport(data, cattle, reqs, result.X);
disp(' ');
disp('<strong>Results:</strong>');
disp(vTbl);
disp(gaResult.Table);
disp(' ');

%% 6. Export results to Excel file.
warning('off','MATLAB:xlswrite:AddSheet');
writetable(gaResult.Table, 'Results.xlsx', 'Sheet', 'SolutionGA');
writetable(vTbl, 'Results.xlsx', 'Sheet', 'FeedRation');
writetable(gaResult.TableFeats, 'Results.xlsx', 'Sheet', 'Characteristics');
