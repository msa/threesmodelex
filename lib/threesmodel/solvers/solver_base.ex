defmodule SolverBase do

  def run(fun) do
    game = Threesmodelex.start_new_game
    solve(game, Threesmodelex.is_game_over?(game), fun)
  end

  def solve(board, false, fun) do
    folded_board = fun.(board)
    solve(folded_board, Threesmodelex.is_game_over?(folded_board), fun)
  end

  def solve(board, true, _) do
    [{:score, Threesmodelex.score_for_board(board)},{:board, board}]
  end

  def run_many(times, fun) do
    1..times
      |> pmap(fn(_) -> run(fun) end)
      |> Enum.max_by(fn([{:score, score}, _]) -> score end)
  end

  def pmap(collection, func) do
    collection
      |> Enum.map(&(Task.async(fn -> func.(&1) end)))
      |> Enum.map(fn(task) -> Task.await(task, 100000) end)
  end

end
