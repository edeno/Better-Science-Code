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