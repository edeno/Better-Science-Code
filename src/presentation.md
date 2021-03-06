% Better Science Code
% Eric Denovellis


------------------

Presentation:  [https://edeno.github.io/Better-Science-Code](http://edeno.github.io/Better-Science-Code)

------------------

Repository:  [https://github.com/edeno/Better-Science-Code](https://github.com/edeno/Better-Science-Code)

------------------

Google Doc for Group Note Taking / Discussion:

[https://docs.google.com/document/d/1LDR8eF6rggOST7IuyM0qcXJhoLI6UwHaiwcwS1-RpPw/edit?usp=sharing](https://docs.google.com/document/d/1LDR8eF6rggOST7IuyM0qcXJhoLI6UwHaiwcwS1-RpPw/edit?usp=sharing)

------------------

Why should you care about producing good code

------------------

<span class='deemphasized-title'>Why should you care about producing good code</span>

REASON 1. Doing good science!

<aside class='notes'>All modern science depends on computing (data-collection, analysis, computational modeling).
We spend a lot of time designing and performing experiments. Why waste that effort by writing code with errors?<aside

------------------

<span class='deemphasized-title'>Why should you care about producing good code</span>

We want code that <span class='highlight'>works</span> (it does what you say it does) and is <span class='highlight'>reproducible</span> (you can get to the same result every time using the same data and code):

------------------

Don’t want to have to retract papers because the code had bugs

------------------

<span class='deemphasized-title'>Why should you care about producing good code</span>

Following good coding practices reduces the chance of making mistakes.

------------------

IT'S TOO EASY TO MAKE MISTAKES

------------------

> "As the complexity of a software program increases, the likelihood of undiscovered bugs quickly reaches certainty"
> -- <cite>Poldrack et al. 2017</cite>

------------------

We are writing *complex code*

<aside class="notes">
Good code should reduce your anxiety about making mistakes
</aside>

------------------

<span class='deemphasized-title'>Why should you care about producing good code</span>

REASON 2. Want to remember what the code does months later

------------------

> "The single biggest reason you should write nice code is so that your future self can understand it."
> -- <cite>Greg Wilson</cite>

> "All code has at least one collaborator and that is future you."
> -- <cite>Hadley Wickham</cite>

------------------

<span class='deemphasized-title'>Why should you care about producing good code</span>

REASON 3. Want to be able to share it with other people

------------------

<span class='deemphasized-title'>Why should you care about producing good code </span>

REASON 4. Avoid introducing new errors

<aside class='notes'>We'll talk about how writing good code (in particular testing your code) helps you avoid introducing new errors into your code</aside>

------------------

<span class='deemphasized-title'>Why should you care about producing good code </span>

REASON 5. Can serve as a resume for future employers


------------------

How to write good code???

------------------

Exercise in managing complexity:

* break problems down into smaller components
* eliminate unnecessary dependencies
* keep track of what you did (be organized)

------------------

Goal: Want to form good habits

------------------

Don’t be overwhelmed *and not do any of these things*

------------------

Don’t beat yourself up *if you don’t do all these things all the time*

<aside class="notes">
* just try to remember them and incorporate them gradually into your process
* it will slow your coding process initially, but you will gain precision, readability
* some of these will require more inertia (such as version control)
</aside>


------------------

<span class='deemphasized-title'>How to write good code???</span>

STEP 1. Decompose programs into small, well-defined functions

<aside class="notes">
Biggest mistakes I see in scientific code.
  1. Not writing functions at all.
  2. Not writing small enough functions
</aside>

------------------

```python
import numpy as np

def bad_function():
    X = np.load('/tmp/123.npy', mmap_mode='r')
    y, x1, x2 = X[:, 0], X[:, 1], X[:, 2]
    z1 = (x1 - x1.mean()) / x1.std()
    Q1, R1 = np.linalg.qr(z1, mode='reduced')
    b1 = np.linalg.solve(R1, np.dot(Q1.T, y1))
    z2 = (x2 - x2.mean()) / x2.std()
    Q2, R2 = np.linalg.qr(z1, mode='reduced')
    b2 = np.linalg.solve(R2, np.dot(Q2.T, y2))
    b = b1 - b2
    np.save('ans.npy', b)
```

<aside class='notes'>
-  `Def`: defines a function in python
</aside>

------------------

```python
import numpy as np

def better_function():
    y, x1, x2 = load_data('/tmp/123.npy')
    b1 = linear_regression(zscore(x1), y)
    b2 = linear_regression(zscore(x2), y)
    b = b1 - b2
    np.save('ans.npy', b)

def load_data(data_name):
    X = np.load(data_name, mmap_mode='r')
    return X[:, 0], X[:, 1], X[:, 2]

def zscore(x):
    return (x - x.mean()) / x.std()

def linear_regression(design_matrix, response):
    Q, R = np.linalg.qr(design_matrix, mode='reduced')
    return np.linalg.solve(R, np.dot(Q.T, response))

```

------------------

<span class='deemphasized-title'>How to write good code???</span>

Try to keep functions to less than 60 lines (small)

<aside class='notes'>Seeing a whole function on screen helps
you keep it in your working memory.</aside>

------------------

<span class='deemphasized-title'>How to write good code???</span>

Try to keep what the function does as simple as possible (well-defined)

<aside class="notes">
atomic = a function should do one "thing"

Think about if you came back to the function later, how long would it take you to understand what it does?
    * should be able to explain what it does in one sentence

pure = as few implicit contexts and side-effects as possible.
</aside>

------------------

<span class='deemphasized-title'>How to write good code???</span>

Be ruthless about eliminating duplication of code.

<aside class="notes">
* turn duplicated code into functions
* that way fixing a bug in your function, fixes it for every time the function is used instead of every separate instance
</aside>

------------------

<span class='deemphasized-title'>Small, well-defined, without duplicates</span>

```python
import numpy as np

def bad_function():
    X = np.load('/tmp/123.npy', mmap_mode='r')
    y, x1, x2 = X[:, 0], X[:, 1], X[:, 2]
    z1 = (x1 - x1.mean()) / x1.std()
    Q1, R1 = np.linalg.qr(z1, mode='reduced')
    b1 = np.linalg.solve(R1, np.dot(Q1.T, y1))
    z2 = (x2 - x2.mean()) / x2.std()
    Q2, R2 = np.linalg.qr(z1, mode='reduced')
    b2 = np.linalg.solve(R2, np.dot(Q2.T, y2))
    b = b1 - b2
    np.save('ans.npy', b)
```

------------------

<span class='deemphasized-title'>Small, well-defined, without duplicates</span>

```python
import numpy as np

def better_function():
    y, x1, x2 = load_data('/tmp/123.npy')
    b1 = linear_regression(zscore(x1), y)
    b2 = linear_regression(zscore(x2), y)
    b = b1 - b2
    np.save('ans.npy', b)

def load_data(data_name):
    X = np.load(data_name, mmap_mode='r')
    return X[:, 0], X[:, 1], X[:, 2]

def zscore(x):
    return (x - x.mean()) / x.std()

def linear_regression(design_matrix, response):
    Q, R = np.linalg.qr(design_matrix, mode='reduced')
    return np.linalg.solve(R, np.dot(Q.T, response))

```

------------------

Small, well-defined functions are more *maintainable*

<aside class="notes">
* breaks hard problems down into smaller problems
* limits the scope of your code
* makes it easier to debug or change (with unit testing)
* separation of concerns
</aside>

------------------

Small, well-defined functions are more *composable*

<aside class="notes">
* can reuse function in other programs
* can pass functions to other functions (function composition)
* makes you more efficient because you don’t have to rewrite code
* makes you more precise because you can focus on fixing bugs for one function, not many similar functions
</aside>


------------------

Small, well-defined functions are more *readable*

\* if you give them good names

------------------

STEP 2. Use good variable/function names to clarify what things do

------------------

<span class='deemphasized-title'>Use good variable/function names</span>

```python
import numpy as np

def bad_function():
    X = np.load('/tmp/123.npy', mmap_mode='r')
    y, x1, x2 = X[:, 0], X[:, 1], X[:, 2]
    z1 = (x1 - x1.mean()) / x1.std()
    Q1, R1 = np.linalg.qr(z1, mode='reduced')
    b1 = np.linalg.solve(R1, np.dot(Q1.T, y1))
    z2 = (x2 - x2.mean()) / x2.std()
    Q2, R2 = np.linalg.qr(z1, mode='reduced')
    b2 = np.linalg.solve(R2, np.dot(Q2.T, y2))
    b = b1 - b2
    np.save('ans.npy', b)
```

------------------

<span class='deemphasized-title'>Use good variable/function names</span>

```python
import numpy as np

def better_function():
    y, x1, x2 = load_data('/tmp/123.npy')
    b1 = linear_regression(zscore(x1), y)
    b2 = linear_regression(zscore(x2), y)
    b = b1 - b2
    np.save('ans.npy', b)

def load_data(data_name):
    X = np.load(data_name, mmap_mode='r')
    return X[:, 0], X[:, 1], X[:, 2]

def zscore(x):
    return (x - x.mean()) / x.std()

def linear_regression(design_matrix, response):
    Q, R = np.linalg.qr(design_matrix, mode='reduced')
    return np.linalg.solve(R, np.dot(Q.T, response))

```

------------------

<span class='deemphasized-title'>Use good variable/function names</span>

```python
import numpy as np

def better_function():
    response, design_matrix1, design_matrix2 = load_data(
        '/tmp/123.npy')
    coefficient1 = linear_regression(
        zscore(design_matrix1), response)
    coefficient2 = linear_regression(
        zscore(design_matrix2), response)
    coefficient_difference = coefficient1 - coefficient2
    np.save('ans.npy', coefficient_difference)

def load_data(data_name):
    X = np.load(data_name, mmap_mode='r')
    return X[:, 0], X[:, 1], X[:, 2]

def zscore(x):
    return (x - x.mean()) / x.std()

def linear_regression(design_matrix, response):
    Q, R = np.linalg.qr(design_matrix, mode='reduced')
    return np.linalg.solve(R, np.dot(Q.T, response))

```

------------------

You don’t need comments if the variable or function already tells you what it does (self-documenting)

<aside class="notes">
* People have been taught to use comments in their code
* Modern practice is to use commenting sparingly within the body of the code
* Use comments to document what the functions does at the beginning of the function (will come back to this)
* Doesn't mean never use comments, but don't use them to restate what the code already says.
* "If your code needs a comment to explain it, you've probably written confusing code."
* Makes it easier to read
* When it is difficult to come up with a meaningful name for the function (It is probably doing too much)
</aside>

------------------

Use the naming conventions of your language of choice (`snake_case` or `camelCase`) and <span class='highlight'>be consistent</span>

------------------

Avoid using abbreviations that are not commonly used

(`sw` vs. `spike_width`)

------------------

Prefer whole words

(`elec_poten` vs. `electric_potential`)

------------------

STEP 3. Document your functions

------------------

<span class='deemphasized-title'>Document your functions</span>

Easy thing: brief sentence describing the function without using the name of the function\*

\**this is the most important*

<aside class="notes">
* second line of defense in remembering what a function does
* The more important the function, the more it should be documented
* if using python, use the numpy format
* if using matlab, use the matlab format
* documentation often longer than the code itself
</aside>

------------------

<span class='deemphasized-title'>Document your functions</span>

```python
def zscore(x):
    return (x - x.mean()) / x.std()

def linear_regression(design_matrix, response):
    Q, R = np.linalg.qr(design_matrix, mode='reduced')
    return np.linalg.solve(R, np.dot(Q.T, response))
```

------------------

<span class='deemphasized-title'>Document your functions</span>

```python
def zscore(x):
    '''Number of standard deviations from the mean'''
    return (x - x.mean()) / x.std()

def linear_regression(design_matrix, response):
    Q, R = np.linalg.qr(design_matrix, mode='reduced')
    return np.linalg.solve(R, np.dot(Q.T, response))
```

------------------

<span class='deemphasized-title'>Document your functions</span>

```python
def zscore(x):
    '''Number of standard deviations from the mean'''
    return (x - x.mean()) / x.std()

def linear_regression(design_matrix, response):
    '''Calculate a linear least-squares regression for
    two sets of measurements'''
    Q, R = np.linalg.qr(design_matrix, mode='reduced')
    return np.linalg.solve(R, np.dot(Q.T, response))
```

------------------

<span class='deemphasized-title'>Document your functions</span>

* additional detail about what the function does or method it implements
* description of the parameters
* description of the outputs
* examples if you can

------------------

<span class='deemphasized-title'>Document your functions</span>

```python
def linear_regression(design_matrix, response):
    '''Calculate a linear least-squares regression for
    two sets of measurements

    Uses the QR decomposition to avoid numerical instability
    in taking the inverse.

    Parameters
    ----------
    design_matrix, response : array_like
        Two sets of measurements. Both arrays should have
        the same length.

    Returns
    -------
    coefficients : array_like
        Parameters estimated from the model.

    Examples
    --------
    >>> design_matrix = np.random.random(10)
    >>> response = np.random.random(10)
    >>> coefficients = linear_regression(design_matrix, response)

    '''
    Q, R = np.linalg.qr(design_matrix, mode='reduced')
    return np.linalg.solve(R, np.dot(Q.T, response))
```

------------------

STEP 4. Test your code

------------------

<span class='deemphasized-title'>Test your code</span>

Make sure your code works like you think it does

------------------

<span class='deemphasized-title'>Test your code</span>

Think about how your code can fail

------------------

Small, well-defined, well-named functions are easy to test!

------------------

<span class='deemphasized-title'>Test your code</span>

```python
import numpy as np

def zscore(x):
    '''Number of standard deviations from the mean'''
    return (x - x.mean()) / x.std()

def test_zscore():
    pass
```

------------------

<span class='deemphasized-title'>Test your code</span>

```python
import numpy as np

def zscore(x):
    '''Number of standard deviations from the mean'''
    return (x - x.mean()) / x.std()

def test_zscore():
    test_values = np.asarray([1, 3])
    expected_values = np.asarray([-1, 1])

    assert np.allclose(zscore(test_values), expected_values)
```

------------------

<span class='deemphasized-title'>Test your code</span>

<span class='highlight'>Unit tests</span> test a small component of your code (usually a small function) and makes sure it works like you think it works

<aside class="notes">
* Isolate small components of program and make sure they are correct
* doesn’t ensure that combinations of these functions work (integration testing)
</aside>

------------------

<span class='highlight'>Unit tests</span> prevent regression of your code

------------------

If you change your code, you want to know what still works and what has broken (Regression)

------------------

Functions should be simple to test

<aside class="notes">
* if the number of test cases is uncomfortably large, start looking for smaller units to test.
* your function is probably too complex
* After reproducing the bug, and before fixing it, you should write a test case that fails, thus illustrating the bug.
</aside>

------------------

If you find a bug, write a test.

<aside class="notes">
After reproducing the bug, and before fixing it, you should write a test case that fails, thus illustrating the bug.
</aside>


------------------

Use unit tests to define the requirements of your code

<aside class="notes">
* ensure that your function is well-defined
* some people even write unit tests before writing a function (test-driven development)
* also a form of documentation: examples for how you think your code should work
</aside>

------------------

You can use programs called <span class='highlight'>test runners</span> to run a group of unit tests automatically.

------------------

Matlab, Python, R have unit test packages

* [Matlab unit test framework](https://www.mathworks.com/help/matlab/matlab-unit-test-framework.html)
* [Python unit test](https://docs.python.org/3.4/library/unittest.html)
* [Pytest](http://doc.pytest.org/en/latest/)
* [R: testthat](https://github.com/hadley/testthat)

------------------

<span class='deemphasized-title'>Test your code</span>

There are also libraries available that will work with your version control system to run these tests every time you commit a new piece of code (<span class='highlight'>continuous integration<span>)

<aside class="notes">
* This all seems complicated but in the process of developing code, you should be writing tests to make sure it works. This process just formalizes the writing of tests and allows you to run them at a later time, ensuring peace of mind.
* yields more predictable code
* in order to write a test, you have to know what the function does
* people can look at your tests to understand your code (form of documentation)
</aside>

------------------

STEP 5. Use version control

------------------

<span class='deemphasized-title'>Use version control</span>

Sophisticated way to track change in your code over time

<aside class="notes">
* dropbox is a form of this (but not very sophisticated)
* microsoft word is also a form of this (but not very sophisticated)
* snapshots of all the files in a folder (repository)
* git is the most popular (some time is needed to learn this, but social/collaborative/popularity make it worth it)
</aside>

------------------

<span class='deemphasized-title'>Use version control</span>

![Github Desktop](img/github-desktop.png)

------------------

Version control stores the whole history of your project

------------------

![](img/commit-history.png)

------------------

<span class='deemphasized-title'>Use version control</span>

Helps you back up your work

------------------

<span class='deemphasized-title'>Use version control</span>

Go back to previous versions of your code

------------------

![](img/commit-history.png)

------------------

<span class='deemphasized-title'>Use version control</span>

Reduce code clutter and confusion

<aside class="notes">
* no more code_v1.m, code_v2.m
* which version of code was I using???
* which version of code worked???
* how is this different from other code I wrote???
</aside>

------------------

<span class='deemphasized-title'>Use version control</span>

Experiment with different versions of code (branches)

------------------

<span class='deemphasized-title'>Use version control</span>

Makes it easier to work with others

<aside class="notes">
* standardized way of not unintentionally overwriting each others code
* easy to share code (GitHub, Bitbucket, etc)
* makes it easier to document issues with code or data
* Use example from this presentation
<aside>

------------------

<span class='deemphasized-title'>Use version control</span>

Commit early and often (take a lot of snapshots of your code)

<aside class="notes">
* when you get a piece of code working, commit it (take a snapshot)
* Leave a short informative commit message (document what the commit is)
* don’t comment out code, just remove it, you can get back
* I personally use GitHub Desktop
    * easy to use user interface
<aside>

------------------

STEP 6. Refactor your code

------------------

>"Whenever I have to think to understand what the code is doing, I ask myself if I can refactor the code to make that understanding more immediately apparent."
> -- <cite>Martin Fowler, Refactoring: Improving the Design of Existing Code</cite>

------------------

<span class='deemphasized-title'>Refactor your code</span>

Always leave the code in a better state than when you first found it.

<aside class="notes">
Your code isn't going to be perfect the first time

Just like in writing, your code will get better as you revise it.

You wouldn’t expect a first draft to be perfect.

each time you look at your code:
* do my variable/function names make sense?
* do I know what this function is doing?
* can I turn things into functions?
* can I generalize this function?

There is some tradeoff between tinkering with your code and getting things done

Also don’t throw everything out and re-write from scratch unless you can absolutely help it
* "When you throw away code and start from scratch, you are throwing away all that knowledge. All those collected bug fixes.”
If tempted by this tutorial to do this to your existing codebase, don't
<aside>

------------------

STEP 7. Always search for well-maintained software libraries that do what you need.

------------------

Don't rewrite functions that are already implemented as part of the core language.

------------------

Use other software libraries if they are well-maintained

<aside class="notes">
Why:
* because more users mean less bugs
* better tested

Little tricky: still need to take time to vet the code to make sure it does what you think it does
<aside>

------------------

<span class='deemphasized-title'>How to write good code???</span>

Exercise in managing complexity:

* break problems down into smaller components
* eliminate unnecessary dependencies
* keep track of what you did (be organized)

------------------

Summary:

1. Write small well-defined, well-named functions
2. Use good function and variable names
3. Document your functions
4. Test your code
5. Refactor your code
6. Use version control
7. Always search for well-maintained software libraries that do what you need.

------------------

<span class='deemphasized-title'>break problems down into smaller components</span>

1. Write small well-defined, well-named functions
2. <span class='dim'>Use good function and variable names</span>
3. <span class='dim'>Document your functions</span>
4. <span class='dim'>Test your code</span>
5. Refactor your code
6. <span class='dim'>Use version control</span>
7. Always search for well-maintained software libraries that do what you need.

------------------

<span class='deemphasized-title'>keep track of what you did (be organized)</span>

1. <span class='dim'>Write small well-defined, well-named functions</span>
2. Use good function and variable names
3. Document your functions
4. Test your code
5. <span class='dim'>Refactor your code</span>
6. Use version control
7. <span class='dim'>Always search for well-maintained software libraries that do what you need.</span>

------------------

Conclusion: Writing good code takes work

------------------

We have a scientific obligation to ensure the correctness of our programs.

<aside class='notes'>
I think it is a mistake to think that only "programmers" working for companies need to bother with writing good code.

You are a programmer dealing with complex programs.

Need to put the same amount of effort as performing the experiment or writing the paper.
</aside>

------------------

Exercises

+  Go to [https://github.com/edeno/Better-Science-Code](https://github.com/edeno/Better-Science-Code)

+  Copy either [exercises.py](https://raw.githubusercontent.com/edeno/Better-Science-Code/master/exercises/exercises.py) or  [exercises.m](https://raw.githubusercontent.com/edeno/Better-Science-Code/master/exercises/exercises.m)

+  Work on for 30 minutes (either solo or in groups).

+  Code Review: We will discuss what people came up with

------------------

Exercise Objectives

------------------

Bonus: Data Management

------------------

Put different projects in different folders/repositories

------------------

Use relative paths

------------------

Separate the data from the code

------------------

Processed Data should be separated from Raw Data to avoid accidentally changing the data

------------------

Tidy Data:

* Each variable forms a column.
* Each observation forms a row.
* Each type of observational unit forms a table
* flat is better than nested

------------------

If original data is not in a good form, convert it to a good form (but don’t overwrite the original data)

------------------

Don’t hand-edit data files.

------------------

All aspects of data cleaning should be in scripts

------------------

File naming:

+  Don't use spaces in file names
+  Use leading zeros (001 vs. 1)
