function [total] = totalSumOfSquares(signal)
% Measure the discrepency between the data and a constant model.
total = sumOfSquares(detrend(signal, 'constant'));
end