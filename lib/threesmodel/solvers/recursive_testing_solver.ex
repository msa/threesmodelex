defmodule Threesmodel.Solvers.RecursiveTestingSolver do
  import Threesmodel.Solvers.SolverBase, only: :functions
  alias Threesmodel.GameBoardFolder, as: GameBoardFolder

  def solve(times) do
    {:ok, pid} = Threesmodel.KnowledgeRecorder.start_link()
    run_many(times, fn(board) ->
      [move, _] = recursive_play(3, board, 0)
      Threesmodel.KnowledgeRecorder.add_to_knowledge(pid, board, move)
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
