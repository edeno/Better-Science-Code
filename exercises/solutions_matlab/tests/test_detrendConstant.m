function [isTestPassed] = test_detrendConstant()
testSignal = [2, 2, 2, 0, 0, 0];
detrendedSignal = detrendConstant(testSignal);
expectedSignal = [1, 1, 1, -1, -1, -1];

isTestPassed = all(abs(detrendedSignal - expectedSignal) < 1E-8);
end

