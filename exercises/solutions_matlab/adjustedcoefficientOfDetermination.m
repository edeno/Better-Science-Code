function [adjusted] = adjustedcoefficientOfDetermination(...
    coefficientOfDetermination, nData, nParameters)
% A penalized version of the coefficient of determination given the number
% parameters and data points
adjusted = coefficientOfDetermination - (1 - coefficientOfDetermination) ...
    * nParameters / (nData - nParameters - 1);
end