defmodule Threesmodel.Solvers.SameOrderOfDirectionSolver do
  import Threesmodel.Solvers.SolverBase, only: :functions

  def solve(times) do
    run_many(times, fn(board) ->
      Threesmodelex.fold_right(board)
        |> Threesmodelex.fold_up()
        |> Threesmodelex.fold_left()
        |> Threesmodelex.fold_down()
     end)
  end

end
