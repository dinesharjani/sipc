# 1D/2D Packaging Problem Solver

![Cover image.](https://github.com/the7thgoldrunner/sipc/blob/master/cover-image.png)

## Descriptiom

This is a University assignment for solving both the 1D (Bin) and 2D (Strip) packaging problems. It is written entirely on Swift 3 and it targets MacOS 10.12.

## Project Goal

The goal here is to both experiment with Swift 3, write some software for the Mac, and to try to make a tool to visualize 1D and 2D packaging problems. If you need to write algorithms for solving these kinds of problems, I hope this project can serve as a starting stone for you. It's not perfect, but feel free to fork or even submit your own pull requests. 

## Features

* Solves both BPP and SPP problems.
* Allows for easy experimentation with a choice from multiple algorithms, maximum time setting algorithm to run and some simple statistics.
* Supports parallel execution of the algorithms via GCD.
* Easy visualization of the best-found solution for both types of problems.
* Easy to extend with new algorithms by extending the `HeuristicAlgorithm` class and adding an entry in the `Algorithms` enum.

## Future work / improvements

* There's clearly the need for a `Solution` class. Right now everything is moved as an `[Int]` array and the fact that the `Problem` class handles all the evaluation screems for a `Solution` class.
* `Problem` class should get rid of the `throw Exception`; I implemented this early on and it's become more of a hassle than a utility.
* Enable rotation of `Rectangle`(s); I didn't want to experiment with rotations, but I suspect others might find a need for this.
* We need to open up the posibility of using different packing algorithms, allowing the same flexibility that we have for algorithm (meta-heuristic) selection.

## Closing comments

Nothing more to say. Feel free to copy/edit/source this code as you see fit.
