defmodule Threesmodel.KnowledgeRecorder do
  use GenServer
  alias Threesmodel.GameBoardFolder, as: GameBoardFolder

  @moduledoc """
  Documentation for Knowledge Recorder.
  Saves knowledge records to file
  """
  @doc """
  Initiate with the given file_logger with file name  .
  """
  def start_link() do
    GenServer.start_link(__MODULE__, %{}, name: :recorder)
  end

  def construct_knowledge_record(game_id, board, move) do
    List.flatten(board) ++
      [
        move,
        GameBoardFolder.can_fold_down?(board),
        GameBoardFolder.can_fold_up?(board),
        GameBoardFolder.can_fold_left?(board),
        GameBoardFolder.can_fold_right?(board),
        game_id,
        Threesmodel.GameScorer.score_for(board)
      ]
  end

  def add_to_knowledge(game_id, logtext) do
    GenServer.cast(:recorder, {:log, game_id, logtext})
  end

  def write() do
    GenServer.cast(:recorder, :write)
  end

  def add_to_knowledge(game_id, board, move) do
    add_to_knowledge(game_id, construct_knowledge_record(game_id, board, move))
  end

  def init(logfile) do
    # -----------logfile
    {:ok, logfile}
  end

  def handle_cast({:log, game_id, logtext}, state) do
    {:noreply, Map.put(state, game_id, [logtext | Map.get(state, game_id, [])])}
  end

  def handle_cast(:write, state) do
    knowledge =
      state
      |> Enum.reduce([], fn {_, v = [h|_]}, acc ->
        if List.last(h) > 50000 do
           acc ++ v
        else
          acc
        end
      end)
      |> Enum.map(&inspect/1)
      |> Enum.map(&String.slice(&1, 1, String.length(&1) - 2))
      |> Enum.join("\n")

    File.write("knowledge_log.csv", knowledge, [:append])
    {:noreply, %{}}
  end
end
