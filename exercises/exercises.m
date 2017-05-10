%% Coding Exercises
%
% The goal of this code is to compute the average coefficient of
% determination and average adjusted coefficient of determination by signal
% type.
%
% Refactor this code by:
%     1. Turning some of the code into small well-defined, well-named
%        functions (Remember comments can often replaced by good
%        function/variable names, duplicate code should be turned into
%        functions)
%     2. Using good function and variable names
%     3. Documenting your functions using the numpy format:
%          - https://github.com/numpy/numpy/blob/master/doc/example.py
%          - https://github.com/numpy/numpy/blob/master/doc/HOWTO_DOCUMENT.rst.txt
%        This description should include:
%          - A one-line summary that does not use variable names or the
%               function name
%          - A few sentences giving an extended description
%               (optional, only if time)
%          - Parameters: Description of the function arguments, keywords
%            and their respective types
%          - Returns: Explanation of the returned values and their types
%          - Example: How to use the function (optional, only if time)
%     4. Write at least one test function for each of your small
%        well-defined, well-named functions (should return true/false
%        depending on whether the condition has been met)
%     5. If you know how to use version control, create a repository and
%        practice writing short commit messages each time you get something
%        working.
%
% Try to get all of these elements for at least one function.
%
% HINT: Start with trying to write a `detrend` function, including
% documentation and a test function.


%%
clear variables; clc;

% Signals (s1-s5)
s1 = [1, 1, 1, 1, 1, 1];
s2 = [-1, 1, -1, 1, -1, 1];
s3 = [1, 2, 3, 4, 5, 6];
s4 = [-1, -1, -1, -1, -1, -1];
s5 = [1, 1, 1, 0, 0, 0];

% signal types
sT = {'A', 'B', 'B', 'A', 'B'};

time = 1:6;

%% Get the residual sum of squares for each signal

%Detrend signal: Subtract either the mean from each signal or the linear
% trend from the signal depending on the detrend type
detrendType = 'linear';

switch(detrendType)
    case 'constant'
        s1_detrended = s1 - mean(s1); % subtract the mean from the signal
        s2_detrended = s2 - mean(s2); % subtract the mean from the signal
        s3_detrended = s3 - mean(s3); % subtract the mean from the signal
        s4_detrended = s4 - mean(s4); % subtract the mean from the signal
        s5_detrended = s5 - mean(s5); % subtract the mean from the signal
    case 'linear'
        c = glmfit(1:length(s1), s1); % linear coefficients
        lT = glmval(c, 1:length(s1), 'identity')';  % the linear trend
        s1_detrended = s1 - lT; % detrended signal
        
        c = glmfit(1:length(s2), s2); % linear coefficients
        lT = glmval(c, 1:length(s2), 'identity')';  % the linear trend
        s2_detrended = s2 - lT; % detrended signal
        
        c = glmfit(1:length(s3), s3); % linear coefficients
        lT = glmval(c, 1:length(s3), 'identity')';  % the linear trend
        s3_detrended = s3 - lT; % detrended signal
        
        c = glmfit(1:length(s4), s4); % linear coefficients
        lT = glmval(c, 1:length(s4), 'identity')';  % the linear trend
        s4_detrended = s4 - lT; % detrended signal
        
        c = glmfit(1:length(s5), s5); % linear coefficients
        lT = glmval(c, 1:length(s5), 'identity')';  % the linear trend
        s5_detrended = s5 - lT; % detrended signal
end

res_ss1 = sum(s1_detrended.^2); % residual sum of squares for signal 1
res_ss2 = sum(s2_detrended.^2); % residual sum of squares for signal 2
res_ss3 = sum(s3_detrended.^2); % residual sum of squares for signal 3
res_ss4 = sum(s4_detrended.^2); % residual sum of squares for signal 4
res_ss5 = sum(s5_detrended.^2); % residual sum of squares for signal 5

%% Get the total sum of squares for each signal
% https://en.wikipedia.org/wiki/Total_sum_of_squares

% Detrend signal: Subtract either the mean from each signal or the linear
% trend from the signal depending on the detrend type
detrendType = 'constant';

switch(detrendType)
    case 'constant'
        s1_detrended = s1 - mean(s1); % subtract the mean from the signal
        s2_detrended = s2 - mean(s2); % subtract the mean from the signal
        s3_detrended = s3 - mean(s3); % subtract the mean from the signal
        s4_detrended = s4 - mean(s4); % subtract the mean from the signal
        s5_detrended = s5 - mean(s5); % subtract the mean from the signal
    case 'linear'
        c = glmfit(1:length(s1), s1); % linear coefficients
        lT = glmval(c, 1:length(s1), 'identity')';  % the linear trend
        s1_detrended = s1 - lT; % detrended signal
        
        c = glmfit(1:length(s2), s2); % linear coefficients
        lT = glmval(c, 1:length(s2), 'identity')';  % the linear trend
        s2_detrended = s2 - lT; % detrended signal
        
        c = glmfit(1:length(s3), s3); % linear coefficients
        lT = glmval(c, 1:length(s3), 'identity')';  % the linear trend
        s3_detrended = s3 - lT; % detrended signal
        
        c = glmfit(1:length(s4), s4); % linear coefficients
        lT = glmval(c, 1:length(s4), 'identity')';  % the linear trend
        s4_detrended = s4 - lT; % detrended signal
        
        c = glmfit(1:length(s5), s5); % linear coefficients
        lT = glmval(c, 1:length(s5), 'identity')';  % the linear trend
        s5_detrended = s5 - lT; % detrended signal
end

total_ss1 = sum(s1_detrended.^2); % total sum of squares for signal 1
total_ss2 = sum(s2_detrended.^2); % total sum of squares for signal 2
total_ss3 = sum(s3_detrended.^2); % total sum of squares for signal 3
total_ss4 = sum(s4_detrended.^2); % total sum of squares for signal 4
total_ss5 = sum(s5_detrended.^2); % total sum of squares for signal 5

%% Get the coefficent of determination (R^2) for each signal
% https://en.wikipedia.org/wiki/Coefficient_of_determination
% The coefficient of determination should be >= 0 and <= 1
cod1 = 1 - res_ss1 ./ total_ss1; % coefficient of determination for signal 1
cod2 = 1 - res_ss2 ./ total_ss2; % coefficient of determination for signal 2
cod3 = 1 - res_ss3 ./ total_ss3; % coefficient of determination for signal 3
cod4 = 1 - res_ss4 ./ total_ss4; % coefficient of determination for signal 4
cod5 = 1 - res_ss5 ./ total_ss5; % coefficient of determination for signal 5

%% Get average coefficient of determination by signal type
cod = [cod1; cod2; cod3; cod4; cod5];

% average coefficient of determination for signals of Type A
mean_cod.A = mean(cod(ismember(sT, 'A')));
% average coefficient of determination for signals of Type B
mean_cod.B = mean(cod(ismember(sT, 'B')));

%% Get the adjusted coefficient of determination for each signal
% https://en.wikipedia.org/wiki/Coefficient_of_determination#Adjusted_R2

n = length(s1); % number of data points
p = 1;  % number of parameters
adjustedCOD_1 = cod1 - (1 - cod1) * p / (n - p - 1); % adjusted R^2 for signal 1

n = length(s2); % number of data points
p = 1;  % number of parameters
adjustedCOD_2 = cod2 - (1 - cod2) * p / (n - p - 1); % adjusted R^2 for signal 2

n = length(s3); % number of data points
p = 1;  % number of parameters
adjustedCOD_3 = cod3 - (1 - cod3) * p / (n - p - 1); % adjusted R^2 for signal 3

n = length(s4); % number of data points
p = 1;  % number of parameters
adjustedCOD_4 = cod4 - (1 - cod3) * p / (n - p - 1); % adjusted R^2 for signal 4

n = length(s5); % number of data points
p = 1;  % number of parameters
adjustedCOD_5 = cod5 - (1 - cod5) * p / (n - p - 1); % adjusted R^2 for signal 5

%% Get the average adjusted R^2 by signal type
adjustedCOD = [adjustedCOD_1; adjustedCOD_2; adjustedCOD_3; adjustedCOD_4; adjustedCOD_5];

% average adjusted coefficient of determination for signals of Type A
mean_adjustedCOD.A = mean(adjustedCOD(ismember(sT, 'A')));

% average adjusted coefficient of determination for signals of Type B
mean_adjustedCOD.B = mean(adjustedCOD(ismember(sT, 'B')));
