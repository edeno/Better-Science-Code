% Better Science Code
% Eric Denovellis


------------------

Presentation: [http://edeno.github.io/Better-Science-Code](http://edeno.github.io/Better-Science-Code)

Repository: [https://github.com/edeno/Better-Science-Code](https://github.com/edeno/Better-Science-Code)

# Why should you care about producing good code

# 1) Doing good science!

We want code that works (**it does what you say it does**) and is reproducible (**you can get to the same result every time using the same data and code**):

* don’t want to have to retract papers because the code had bugs
* Following good coding practices reduce the chance of making mistakes
* Good code allows you to detect and fix mistakes quicker

# It’s too easy to make mistakes

> As the complexity of a software program increases, the likelihood of undiscovered bugs quickly reaches certainty”
> -- <cite>Poldrack et al. 2017</cite>

**We are writing complex code**

<aside class="notes">
Good code should reduce your anxiety about making mistakes
</aside>


# 2) Want to remember what the code does months later
> The single biggest reason you should write nice code is so that your future self can understand it.
> -- <cite>Greg Wilson</cite>

> "All code has at least one collaborator and that is future you."
> -- <cite>Hadley Wickham</cite>


# 3) Want to be able to share it with other people
* particularly important with statistical methods
    * what’s the point of coming up with a method if other people can’t easily use it or verify that it works
* increase the impact of your paper if other people can use your method
* if neuroscience is increasingly relying on larger teams of people working together, those teams need to be able to share code

<aside class="notes">
Example: Michael Shadlen vs. Jonathan Pillow debate about the dynamics neurons during perceptual decision making tasks (Ramping diffusion to bound model vs. stepping model)

    * Pillow lab released several papers arguing for stepping model with code available on Github

    * Shadlen lab recently countered with a paper arguing against the stepping model using the Pillow lab code
</aside>

# 4) Avoid introducing new errors

Don’t necessarily want to spend time reproducing old code

Could introduce new or different errors

# 5) Can serve as a resume for future employers

# How do write good code?

Exercise in how to manage complexity:

* break problems down into smaller components
* eliminate unnecessary dependencies
* keep track of what you did (be organized)

# Goals: Want to form good habits

* don’t be overwhelmed and not do any of these things
* don’t beat yourself up if you don’t do all these things all the time
* just try to remember them and incorporate them gradually into your process
* it will slow your coding process initially, but you will gain precision, readability
* some of these will require more inertia (such as version control)

# 1) Decompose programs into small, well-defined functions

# Bad
```python

```

# Better
```python

```

# Side-by-Side
```python

```

```python

```

<aside class="notes">
Biggest mistake I see in other people’s code
</aside>

# 1) Decompose programs into small, well-defined functions

* try to keep functions to less than 60 lines (small)
* try to keep what the function does as simple as possible (well-defined)
    * functions should be “atomic"
    * a function should do one "thing"
* Be ruthless about eliminating duplication of code
    * turn duplicated code into functions
    * that way fixing a bug in your function, fixes it for every time the function is used instead of every separate instance

<aside class="notes">
Think about if you came back to the function later, how long would it take you to understand what it does?
    * should be able to explain what it does in one sentence
</aside>

# Small, well-defined functions are more maintainable

* breaks hard problems down into smaller problems
* limits the scope of your code
* makes it easier to debug
* separation of concerns

# Small, well-defined functions are more composable

* can reuse function in other programs
* can pass functions to other functions (function composition) and other functional programming techniques
* makes you more efficient because you don’t have to rewrite code
* makes you more precise because you can focus on fixing bugs for one function, not many similar functions

# Small, well-defined functions are more readable
* encapsulate ideas in functions

> “Programs are meant to be read by humans and only incidentally for computers to execute”
> -- <cite>Donald Knuth</cite>

# 2) Use good variable/function names to clarify what things do

# Bad
```python

```

# Better
```python

```

# Side-by-Side
```python

```

```python

```

* People have been taught to use comments in their code
* Modern practice is to use commenting sparingly within the body of the code
* You don’t need comments if the variable or function already tells you what it does (self-documenting)
* Use the naming conventions of your language of choice (snake_case or camelCase) and be consistent
* Use comments to document what the functions does at the beginning of the function (will come back to this)
* Makes it easier to read
* When it is difficult to come up with a meaningful name for the function (It is probably doing too much)

# 3) Document your functions

# Bad
```python

```

# Better
```python

```

# Side-by-Side
```python

```

```python

```
* easy thing: brief sentence describing the function without using the name of the function (this is the most important)
    * second line of defense in remembering what a function does
* more complicated thing:
    * additional detail about what the function does or method it implements
    * description of the parameters (type, shape)
    * description of the outputs (type, shape)
    * examples if you can
* The more important the function, the more it should be documented
* if using python, use the numpy format
* if using matlab, use the matlab format
* documentation often longer than the code itself

# 4) Test your code
* make sure your code works like you think it does
* Think about how your code can fail
* small, well-defined, well-named functions are easy to test!
* unit tests
    * unit tests test a small component of your code (usually a small function) and makes sure it works like you think it works
        * isolate small components of program and make sure they are correct
        * doesn’t ensure that combinations of these functions work (integration testing)
    * unit tests prevent regression of your code
        * if you change your code, you want to know what still works and what has broken
    * use unit tests to define the requirements of your code
        * ensure that your function is well-defined
        * some people even write unit tests before writing a function
        * also a form of documentation: examples for how you think your code should work
    * you can use programs called "test runners” to run a group of unit tests automatically
        * matlab, python have built- in unit test programs
            * matlab: https://www.mathworks.com/help/matlab/matlab-unit-test-framework.html
            * python: https://docs.python.org/3.4/library/unittest.html
            * if you use python, pytest is a helpful extension: http://doc.pytest.org/en/latest/
            * R: testthat package — works well with RStudio IDE
        * there are also libraries available that will work with your version control system to run these tests everytime you commit a new piece of code (“continuous integration”)
    * This all seems complicated but in the process of developing code, you should be writing tests to make sure it works. This process just formalizes the writing of tests and allows you to run them at a later time, ensuring peace of mind.
* yields more predictable code
    * in order to write a test, you have to know what the function does
    * people can look at your tests to understand your code (form of documentation)
* if the number of test cases is uncomfortably large, start looking for smaller units to test.
    * your function is probably too complex
* After reproducing the bug, and before fixing it, you should write a test case that fails, thus illustrating the bug.

# Use version control
* what is version control?
    * tracks change in your code over time
        * dropbox is a form of this (but not very sophisticated)
        * git is the most popular (some time is needed to learn this, but social/collaborative/popularity make it worth it)
    * stores the whole history of your project
        * git helps you back up your work
        * reduces code clutter
            * no more code_v1.m, code_v2.m
            * which version of code was I using???
            * which version of code worked???
            * how is this different from other code I wrote???
    * git lets you time travel
        * because you have snapshots of your code, you can go back to previous versions of your code
    * experiment with different versions of code (branches)
    * makes it easier to work with others
        * standardized way of not unintentionally overwriting each others code
        * easy to share code (GitHub, Bitbucket, etc)
        * makes it easier to document issues with code or data
* commit early and often
    * when you get a piece of code working, commit it (take a snapshot)
    * Leave a short informative commit message (document what the commit is)
    * don’t comment out code, just remove it, you can get back
    * reduce your anxiety
        * want to be able to get back to code that works
* I personally use GitHub Desktop
    * easy to use user interface

# Refactor your code
* your code doesn’t have to be perfect the first time
* Just like in writing, your code will get better as you revise it. You wouldn’t expect a first draft to be perfect.
* each time you look at your code:
    * do my variable/function names make sense?
    * do I know what this function is doing?
    * can I turn things into functions?
    * can I generalize this function?
* there is some tradeoff between tinkering with your code and getting things done
* also don’t throw everything out and re-write from scratch unless you can absolutely help it
    * "When you throw away code and start from scratch, you are throwing away all that knowledge. All those collected bug fixes.”
    * if tempted by this tutorial to do this to your existing codebase, don't


# Always search for well-maintained software libraries that do what you need.


# Summary:
* Use good function and variable names
* Write small well-defined, well-named functions
* Document your functions
* Test your code
* Refactor your code
* Use version control
* Use linters to enforce coding standards
* Always search for well-maintained software libraries that do what you need.

# Bonus: Data Management

* Put different projects in different folders/repositories
* Use relative paths
* Separate the data from the code
* Processed Data should be separated from Raw Data to avoid accidentally changing the data
    * want your analysis to be reproducible
* Tidy Data:
    * Each variable forms a column.
    * Each observation forms a row.
    * Each type of observational unit forms a table
    * flat is better than nested
* If original data is not in a good form, convert it to a good form (but don’t overwrite the original data)
* Don’t hand-edit data files.
* All aspects of data cleaning should be in scripts
