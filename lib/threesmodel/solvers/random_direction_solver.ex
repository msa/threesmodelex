defmodule Threesmodel.Solvers.RandomDirectionSolver do
  import Threesmodel.Solvers.SolverBase, only: :functions

  def solve(times) do
    run_many(times, fn(board) ->
      Threesmodelex.fold(board, Enum.random(Threesmodelex.possible_folds(board))) end)
  end

end
