# aoclib

`aoclib` is a Swift library offering some of the basic functionality available
in other languages, notably Python, that is relevant to solving
Advent-of-Code style programming puzzles, but is not currently exposed in a
convenient way by the Swift standard library.

It is very much a work in progress; I will likely push more and more code
up here as the 2021 AoC event progresses, sometimes new utilities that I
wrote in response to the day's puzzle, sometimes generally useful code that
I anticipate being of potential value in upcoming puzzles.

As a rule, `aoclib` will not contain any code specific to a particular
Advent of Code puzzle. I wouldn't consider using `aoclib` for your own
Advent of Code solutions to be "cheating" in any way—merely making the use
of Swift more competitive with other languages better suited to small,
lightweight, vaguely algorithm-centric programming.

The library is set up to be built as a dynamic library (just run `swift build`
at the top level). You can then invoke the Swift REPL (or execute a single
Swift file) with

    swift -I swiftaoc/.build/debug -L swiftaoc/.build/debug -laoclib

Happy Hacking!
