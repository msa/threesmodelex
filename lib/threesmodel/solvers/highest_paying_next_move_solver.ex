defmodule Threesmodel.Solvers.HighestPayingNextMoveSolver do
  import Threesmodel.Solvers.SolverBase, only: :functions
  alias Threesmodel.GameBoardFolder, as: GameBoardFolder
  alias Threesmodel.GameScorer, as: GameScorer

  def solve(times) do
    run_many(times, fn(board) ->
      {direction, _} = Threesmodelex.possible_folds(board)
        |> Enum.map(fn(direction) -> {direction, GameBoardFolder.fold(board, direction)} end)
        |> Enum.map(fn({dir, b}) -> {dir, GameScorer.score_for(b)} end)
        |> Enum.max_by(fn({_, score}) -> score end)
      Threesmodelex.fold(board, direction)
    end)
  end

end
