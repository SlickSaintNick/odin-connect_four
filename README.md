# odin-connect_four

2 player Connect Four built for the Odin Project.

While I usually keep my README's to a minimum I will document a few things in this one as it has easily been the most challenging for me so far, and the lesson that has taken the longest by a factor of 2 or 3.

My journey went something like this:
- Do all of the resources and exercises in the lesson.
- Try to implement testing in my existing Tic-Tac-Toe program.
- Find that this was very complex and difficult as the code was very hard to test (and I don't know how to use rspec). Hate TDD.
- Revisit the Odin Project lesson and watch Sandi Metz's presentation about what is actually worth testing which was super helpful.
- Code most of this Connect Four solution using TDD and found it fantastic to be able to:
    - Go straight to the core challenge of the code (the pattern matching) without having to build an interface first, and be super focussed on that.
    - Focus on testing only the behaviour Sandi Metz recommended as this made me feel like I wasn't wasting my time. Why tie myself to an internal implementation of something that has no effect on anything else in my code? So don't test it = much happier.
    - Have most of the code written and working before I ever had to run it in a terminal.
    - TDD is pretty good?
- Rush through the last section without testing because "this is the easy part", only to find that the integration between classes was broken (e.g. board expects 0-6 index rows, player inputs rows 1-7!) along with numerous other bugs.
- Return to testing and retrospectively write tests to fix these bugs - so good to be able to e.g. immediately simulate the winning condition through testing, rather than having to run the whole thing again to test.
- Refactor the winner_search method using TDD in a way I never could have without testing (still has too high ABC for Rubocop though)
- Love TDD.

The key testing patterns I used:

```rb
expect(object).to eql(expectation)

expect { block }. to change { block }.from(before).to(after)

# To suppress puts:
$stdout = StringIO.new

# To simulate successive inputs:
allow(object).to receive(:method).and_return(1, 2, 3)
expect(object.method).to eq(5)
expect(object.method).to eq(6)
expect(object.method).to eq(7)

# To test a particular string is returned:
return_string = object.method
expected_string = <<~HEREDOC
  What I Expect
  Over Multiple Lines
HEREDOC

expect(return_string).to eql(expected_string)

# To simulate a return value from another object.
let(:double_object) { double('object') }

before do
  allow(double_object).to receive(:method).and_return(desired_return_value)
end

it 'text' do
  expect(double_object).to receive(:method).once
end

# To test a method with a do loop
before do
  allow(object).to receive(:loop).and_yield
end

it 'text' do
  object.method_with_do_loop
end

# To access variables in other classes that are not public
variable = object.instance_variable_get(:@variable)

# or, although not used here
variable = object.instance_variable_set(:@variable, desired_value)

# To test if an instance variable is changed
initial_value = object.instance_variable_get(:@variable)

object.method

expect(object.instance_variable_get(:@variable)).to eq(changed_value)
expect(object.instance_variable_get(:@variable)).not_to eq(initial_value)

# To set the return value of a method
allow(object).to receive(:method) { return_value }
```

No matter what I tried I couldn't get rspec to automatically suppress the clear_screen method in ConnectFour, so I simply have a parameter "testing" that can be set to "true" on the clear_screen method to disable it.