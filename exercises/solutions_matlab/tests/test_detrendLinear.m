function [isTestPassed] = test_detrendLinear()
testSignal = 1:6;
detrendedSignal = detrendLinear(testSignal);
expectedSignal = zeros(size(testSignal));

isTestPassed = all(abs(detrendedSignal - expectedSignal) < 1E-8);
end

