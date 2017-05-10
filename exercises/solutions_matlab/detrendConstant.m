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