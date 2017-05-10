function [coefficient] = coefficientOfDetermination(residualSumOfSquares, ...
    totalSumOfSquares)
% The proportion of variance captured by the model
coefficient = 1 - residualSumOfSquares ./ totalSumOfSquares;
end