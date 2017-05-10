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