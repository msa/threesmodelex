defmodule Threesmodel.Solvers.SolverBase do
  alias Threesmodel.NextNumberDeterminator, as: NextNumberDeterminator

  def run(fun) do
    game = Threesmodelex.start_new_game
    solve(game, Threesmodelex.is_game_over?(game), fun)
  end

  def solve(board, false, fun) do
    b = fun.(board)
    solve(b, Threesmodelex.is_game_over?(b), fun)
  end

  def solve(board, true, _) do
    send :stats, {:high_cell, NextNumberDeterminator.highest_cell_on_board(board)}
    [{:score, Threesmodelex.score_for_board(board)},{:board, board}]
  end

  def run_many(times, fun) do
    {:ok, pid} = Task.start_link(fn -> collect(%{3 => 0, 6 => 0, 12 => 0, 24 => 0, 48 => 0, 96 => 0, 192 => 0, 384 => 0, 768 => 0, 1536 => 0, 3072 => 0, 6144 => 0, 12288 => 0, 24576 => 0}) end)
    Process.register(pid, :stats)
    best_game = 1..times
      |> pmap(fn(_) -> run(fun) end)
      |> Enum.max_by(fn([{:score, score}, _]) -> score end)
    IO.puts("*****   BEST GAME   *****")
    IO.inspect(best_game)
    IO.puts("*****   HISTOGRAM   *****")
    send :stats, {:do_end}
  end

  def pmap(collection, func) do
    collection
      |> Enum.map(&(Task.async(fn -> func.(&1) end)))
      |> Enum.map(fn(task) -> Task.await(task, 500000) end)
  end

  def collect(state) do
    receive do
      {:high_cell, value} -> collect(Enum.map(state, fn({key, val}) -> if key == value do {key, val + 1} else {key, val} end end))
      {:do_end} ->
        IO.inspect(state)
      _ ->
        collect(state)
    end
  end
end
