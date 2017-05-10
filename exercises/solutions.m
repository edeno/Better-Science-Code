function [coefficient_of_determination, adjusted_R2, ...
    averageCoefficientOfDetermination, averageAdjustedR2] = solutions()
% Signals (s1-s5)
s1 = [1, 1, 1, 1, 1, 1];
s2 = [-1, 1, -1, 1, -1, 1];
s3 = [1, 2, 3, 4, 5, 6];
s4 = [-1, -1, -1, -1, -1, -1];
s5 = [1, 1, 1, 0, 0, 0];

% signal types
signalTypes = {'A', 'B', 'B', 'A', 'B'};

time = 1:6;

% Combine signals
signals = [s1; s2; s3; s4; s5];
nSignals = size(signals, 1);

residual_sum_of_squares = zeros(nSignals, 1);
total_sum_of_squares = zeros(nSignals, 1);


for signalIndex = 1:nSignals
    currentSignal = signals(signalIndex, :);
    residual_sum_of_squares(signalIndex, :) = residualSumOfSquares(currentSignal);
    total_sum_of_squares(signalIndex, :) = totalSumOfSquares(currentSignal);
end

coefficient_of_determination = coefficientOfDetermination( ...
    residual_sum_of_squares, total_sum_of_squares);

adjusted_R2 = adjustedcoefficientOfDetermination(coefficient_of_determination, length(time), 1);

averageCoefficientOfDetermination = averageBySignalType(...
    coefficient_of_determination, signalTypes);
averageAdjustedR2 = averageBySignalType(adjusted_R2, signalTypes);


end

function [detrendedSignal] = detrendConstant(signal)
% Remove a mean trend from a signal
%
% Fits a constant model (intercept) to the data
% and removes linear prediction of that signal
%
% Parameters
% ----------
% signal : array
%   The data from which the constant trend will be removed
% 
% Returns
% -------
% detrendedSignal : array
%   The signal with a constant trend removed.
%
detrendedSignal = signal - mean(signal);
end

function [detrendedSignal] = detrendLinear(signal)
% Remove a linear trend from a signal
%
% Fits a linear regression model (intercept and slope) to the data
% and removes linear prediction of that signal
%
% Parameters
% ----------
% signal : array
%   The data from which the linear trend will be removed
% 
% Returns
% -------
% detrendedSignal : array
%   The signal with the linear trend removed.
%
linearCoefficients = glmfit(1:length(signal), signal);
linearTrend = glmval(linearCoefficients, 1:length(signal), 'identity')';
detrendedSignal = signal - linearTrend;
end

function [detrendedSignal] = detrend(signal, detrendType)
% Remove a pattern from a signal
%
% Parameters
% ----------
% signal : array
%   The data from which the trend will be removed
% detrendType : {'constant', 'linear'}
%   The type of detrending
% 
% Returns
% -------
% detrendedSignal : array
%   The signal with the trend removed.
%
switch(detrendType)
    case 'constant'
        detrendedSignal = detrendConstant(signal);
    case 'linear'
        detrendedSignal = detrendLinear(signal);
end

end

function [sumSquared] = sumOfSquares(signal)
% 
sumSquared = sum(signal.^2);
end

function [coefficient] = coefficientOfDetermination(residualSumOfSquares, ...
    totalSumOfSquares)
% The proportion of variance captured by the model
coefficient = 1 - residualSumOfSquares ./ totalSumOfSquares;
end

function [residual] = residualSumOfSquares(signal)
% Measure the discrepancy between the data and the linear model prediction. 
%
residual = sumOfSquares(detrend(signal, 'linear'));
end

function [total] = totalSumOfSquares(signal)
% Measure the discrepency between the data and a constant model.
total = sumOfSquares(detrend(signal, 'constant'));
end

function [adjusted] = adjustedcoefficientOfDetermination(...
    coefficientOfDetermination, nData, nParameters)
% A penalized version of the coefficient of determination given the number
% parameters and data points
adjusted = coefficientOfDetermination - (1 - coefficientOfDetermination) ...
    * nParameters / (nData - nParameters - 1);
end

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