defmodule RecursiveTestingSolver do
  import SolverBase, only: :functions

  def solve(times) do
    run_many(times, fn(board) ->
      [move, _] = RecursiveTestingSolver.recursive_play(3, board, 0)
      Threesmodelex.fold(board, move)
    end)
  end

  def recursive_play(0, _, score) do
    [nil, score]
  end

  def recursive_play(depth, board, score) do
    folds = Threesmodelex.possible_folds(board)
    scored_moves = Enum.map(folds, fn(fold) ->
      folded_board = GameBoardFolder.fold(board, fold)
      [_, next_score] = recursive_play(depth - 1, folded_board, score)
      [fold, Threesmodelex.score_for_board(folded_board) + next_score]
    end)
    Enum.max_by(scored_moves,fn([_, score]) -> score end)
  end
end
