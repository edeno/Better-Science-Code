'''Coding Exercises

Refactor this code by:
    1. Turning some of the code into small well-defined, well-named
       functions (Remember comments can often replaced by good
       function/variable names, duplicate code should be turned into
       functions)
    2. Using good function and variable names
    3. Documenting your functions using the numpy format:
         - https://github.com/numpy/numpy/blob/master/doc/example.py
         - https://github.com/numpy/numpy/blob/master/doc/HOWTO_DOCUMENT.rst.txt
       This description should include:
         - A one-line summary that does not use variable names or the
           function name
         - A few sentences giving an extended description
           (optional, only if time)
         - Parameters: Description of the function arguments, keywords
           and their respective types
         - Returns: Explanation of the returned values and their types
         - Example: how to use the function (optional, only if time)
    4. Write at least one test function for each of your small
       well-defined, well-named functions (should return true/false
       depending on whether the condition has been met)
    5. If you know how to use version control, create a repository and
       practice writing short commit messages each time you get something
       working.

Try to get all of these elements for at least one function.

HINT: Start with trying to write a `detrend` function, including
      documentation and a test function.

'''

import numpy as np

# Signals (s1-s5)
s1 = np.array([1, 1.5, 2.5, 3, 7, 8])
s2 = np.array([-1, 1, -1, 1, -1, 1])
s3 = np.array([1, 2, 3, 4, 3, 2])
s4 = np.array([-1, 0, -1.5, 2.1, -1.5, -1])
s5 = np.array([1, 1, 1, 0, 0, 0])

# signal types
sT = ['A', 'B', 'B', 'A', 'B']

time = np.arange(1, 7)

# Get the residual sum of squares for each signal

# Detrend signal: Subtract either the mean from each signal or the linear
# trend from the signal depending on the detrend type
detrendType = 'linear'

if detrendType == 'constant':
    s1_detrended = s1 - np.mean(s1)  # subtract the mean from the signal
    s2_detrended = s2 - np.mean(s2)  # subtract the mean from the signal
    s3_detrended = s3 - np.mean(s3)  # subtract the mean from the signal
    s4_detrended = s4 - np.mean(s4)  # subtract the mean from the signal
    s5_detrended = s5 - np.mean(s5)  # subtract the mean from the signal
elif detrendType == 'linear':
    dM = np.stack((np.ones(time.shape), time)).T  # design matrix
    c, _, _, _ = np.linalg.lstsq(dM, s1)  # linear coefficients
    lT = np.dot(dM, c)  # the linear trend
    s1_detrended = s1 - lT  # detrended signal

    dM = np.stack((np.ones(time.shape), time)).T  # design matrix
    c, _, _, _ = np.linalg.lstsq(dM, s2)  # linear coefficients
    lT = np.dot(dM, c)  # the linear trend
    s2_detrended = s2 - lT  # detrended signal

    dM = np.stack((np.ones(time.shape), time)).T  # design matrix
    c, _, _, _ = np.linalg.lstsq(dM, s3)  # linear coefficients
    lT = np.dot(dM, c)  # the linear trend
    s3_detrended = s3 - lT  # detrended signal

    dM = np.stack((np.ones(time.shape), time)).T  # design matrix
    c, _, _, _ = np.linalg.lstsq(dM, s4)  # linear coefficients
    lT = np.dot(dM, c)  # the linear trend
    s4_detrended = s4 - lT  # detrended signal

    dM = np.stack((np.ones(time.shape), time)).T  # design matrix
    c, _, _, _ = np.linalg.lstsq(dM, s5)  # linear coefficients
    lT = np.dot(dM, c)  # the linear trend
    s5_detrended = s5 - lT  # detrended signal


res_ss1 = np.sum(s1_detrended ** 2)  # residual sum of squares for signal 1
res_ss2 = np.sum(s2_detrended ** 2)  # residual sum of squares for signal 2
res_ss3 = np.sum(s3_detrended ** 2)  # residual sum of squares for signal 3
res_ss4 = np.sum(s4_detrended ** 2)  # residual sum of squares for signal 4
res_ss5 = np.sum(s5_detrended ** 2)  # residual sum of squares for signal 5


# Get the total sum of squares for each signal
# https://en.wikipedia.org/wiki/Total_sum_of_squares

# Detrend signal: Subtract either the mean from each signal or the linear
# trend from the signal depending on the detrend type
detrendType = 'constant'

if detrendType == 'constant':
    s1_detrended = s1 - np.mean(s1)  # subtract the mean from the signal
    s2_detrended = s2 - np.mean(s2)  # subtract the mean from the signal
    s3_detrended = s3 - np.mean(s3)  # subtract the mean from the signal
    s4_detrended = s4 - np.mean(s4)  # subtract the mean from the signal
    s5_detrended = s5 - np.mean(s5)  # subtract the mean from the signal
elif detrendType == 'linear':
    dM = np.stack((np.ones(time.shape), time)).T  # design matrix
    c, _, _, _ = np.linalg.lstsq(dM, s1)  # linear coefficients
    lT = np.dot(dM, c)  # the linear trend
    s1_detrended = s1 - lT  # detrended signal

    dM = np.stack((np.ones(time.shape), time)).T  # design matrix
    c, _, _, _ = np.linalg.lstsq(dM, s2)  # linear coefficients
    lT = np.dot(dM, c)  # the linear trend
    s2_detrended = s2 - lT  # detrended signal

    dM = np.stack((np.ones(time.shape), time)).T  # design matrix
    c, _, _, _ = np.linalg.lstsq(dM, s3)  # linear coefficients
    lT = np.dot(dM, c)  # the linear trend
    s3_detrended = s3 - lT  # detrended signal

    dM = np.stack((np.ones(time.shape), time)).T  # design matrix
    c, _, _, _ = np.linalg.lstsq(dM, s4)  # linear coefficients
    lT = np.dot(dM, c)  # the linear trend
    s4_detrended = s4 - lT  # detrended signal

    dM = np.stack((np.ones(time.shape), time)).T  # design matrix
    c, _, _, _ = np.linalg.lstsq(dM, s5)  # linear coefficients
    lT = np.dot(dM, c)  # the linear trend
    s5_detrended = s5 - lT  # detrended signal


total_ss1 = np.sum(s1_detrended ** 2)  # total sum of squares for signal 1
total_ss2 = np.sum(s2_detrended ** 2)  # total sum of squares for signal 2
total_ss3 = np.sum(s3_detrended ** 2)  # total sum of squares for signal 3
total_ss4 = np.sum(s4_detrended ** 2)  # total sum of squares for signal 4
total_ss5 = np.sum(s5_detrended ** 2)  # total sum of squares for signal 5

# Get the coefficent of determination (R^2) for each signal
# https://en.wikipedia.org/wiki/Coefficient_of_determination
# The coefficient of determination should be >= 0 and <= 1
cod1 = 1 - res_ss1 / total_ss1  # coefficient of determination for signal 1
cod2 = 1 - res_ss2 / total_ss2  # coefficient of determination for signal 2
cod3 = 1 - res_ss3 / total_ss3  # coefficient of determination for signal 3
cod4 = 1 - res_ss4 / total_ss4  # coefficient of determination for signal 4
cod5 = 1 - res_ss5 / total_ss5  # coefficient of determination for signal 5

# Get average coefficient of determination by signal type
cod = np.stack((cod1, cod2, cod3, cod4, cod5))

# average coefficient of determination for signals of Type A
mean_COD = {
    'A': np.mean(cod[np.in1d(sT, 'A')]),
    'B': np.mean(cod[np.in1d(sT, 'B')])
}

# Get the adjusted coefficient of determination for each signal
# https://en.wikipedia.org/wiki/Coefficient_of_determination#Adjusted_R2

n = len(s1)  # number of data points
p = 1  # number of parameters
# adjusted coefficient of determination for signal 1
adjustedCOD_1 = cod1 - (1 - cod1) * p / (n - p - 1)

n = len(s2)  # number of data points
p = 1  # number of parameters
# adjusted coefficient of determination for signal 2
adjustedCOD_2 = cod2 - (1 - cod2) * p / (n - p - 1)

n = len(s3)  # number of data points
p = 1  # number of parameters
# adjusted coefficient of determination for signal 3
adjustedCOD_3 = cod3 - (1 - cod3) * p / (n - p - 1)

n = len(s4)  # number of data points
p = 1  # number of parameters
# adjusted coefficient of determination for signal 4
adjustedCOD_4 = cod4 - (1 - cod3) * p / (n - p - 1)

n = len(s5)  # number of data points
p = 1  # number of parameters
# adjusted coefficient of determination for signal 5
adjustedCOD_5 = cod5 - (1 - cod5) * p / (n - p - 1)

# Get the average adjusted coefficient of determination by signal type
adjustedCOD = np.stack((adjustedCOD_1, adjustedCOD_2,
                        adjustedCOD_3, adjustedCOD_4, adjustedCOD_5))

# average adjusted coefficient of determination for signals of Type A, B
mean_adjustedCOD = {
    'A': np.mean(adjustedCOD[np.in1d(sT, 'A')]),
    'B': np.mean(adjustedCOD[np.in1d(sT, 'B')])
}
