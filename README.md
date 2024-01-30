# odin-connect_four

2 player Connect Four built for the Odin Project.

While I usually keep my README's to a minimum I will document a few things in this one as it has easily been the most challenging for me so far. My journey went something like this:
- Try to implement testing in my existing Tic-Tac-Toe program.
- Find that this was very complex and difficult as the code was very hard to test (and I don't know how to use rspec). Hate TDD.
- Revisit the Odin Project lesson and watch Sandi Metz's presentation about what is actually worth testing which was super helpful.
- Code most of this Connect Four solution using TDD and found it fantastic to be able to:
    - Go straight to the core challenge of the code (the pattern matching) without having to build an interface first, and be super focussed on that.
    - Have modular and reusable code emerge from TDD.
    - Focus on testing only the behaviour Sandi Metz recommended as this made me feel like I wasn't wasting my time.
    - Have most of the code written and working before I ever had to run it in a terminal.
    - TDD is pretty good?
- Rush through the last section without testing because "this is the easy part", only to find that the integration between classes was broken (e.g. board expects 0-6 index rows, player inputs rows 1-7!) along with numerous other bugs.
- Return to testing and retrospectively write tests to fix these bugs - so good to be able to e.g. immediately simulate the winning condition through testing, rather than having to run the whole thing again to test.
- Refactor the winner_search method using TDD in a way I never could have without testing (still has too high ABC for Rubocop though)
- Love TDD.

