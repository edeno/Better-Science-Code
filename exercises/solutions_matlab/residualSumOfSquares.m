function [residual] = residualSumOfSquares(signal)
% Measure the discrepancy between the data and the linear model prediction. 
%
residual = sumOfSquares(detrend(signal, 'linear'));
end