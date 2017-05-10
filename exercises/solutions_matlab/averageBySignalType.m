function [summary] = averageBySignalType(statistic, signalTypes)
% For each signal type, compute the average statistic
%
% Parameters
% ----------
% statistic : array
% signalTypes : cell-array of strings
%
% Returns
% -------
% summary : structure
%   The average statistic for each signal type, where the signal type is a
%   field in the structure
%
types = unique(signalTypes);

for typeIndex = 1:length(types)
    currentType = types{typeIndex};
    summary.(currentType) = mean(statistic(...
        ismember(signalTypes, currentType)));
end

end