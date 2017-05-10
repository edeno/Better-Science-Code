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