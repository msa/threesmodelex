# Threesmodelex

Ok, this is an elixir port of my ruby implementation of the game of threes.
It is not an official, endorsed implementation, but rather my own interpretation with game rules derived from my own experience of playing it for far too many hours.

The purpose for this implementation is to allow for automatic solver creation.
Implement a solver (have a sneak peak at my reference solver RandomDirectionSolver) and test it. Currently the only output is the score and the end state board for the best game of the run. I plan to add a histogram of the highest cell value for each game at a later time. Thus making solver comparisons more relevant.

If you have the several cores in your beloved computer they, obviously, will all be used during the solver test run.

## Running my solver

I typically use iex -S mix and then start the solver (RandomDirectionSolver.solve(5000) in my case) for the use case of trying out my solver. It will run my solver 5000 (times/games) and provide me with the score and board for the best game.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `threesmodelex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:threesmodelex, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/threesmodelex](https://hexdocs.pm/threesmodelex).
