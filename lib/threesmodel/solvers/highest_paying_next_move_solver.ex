defmodule HighestPayingNextMoveSolver do
  import SolverBase, only: :functions

  def solve(times) do
    run_many(times, fn(board) ->
      {direction, _} = Threesmodelex.possible_folds(board)
        |> Enum.map(fn(direction) -> {direction, GameBoardFolder.fold(board, direction)} end)
        |> Enum.map(fn({dir, b}) -> {dir, GameScorer.score_for(b)} end)
        |> Enum.max_by(fn({dir, score}) -> score end)
      Threesmodelex.fold(board, direction)
    end)
  end

end
