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
      GenServer.start_link(__MODULE__, "knowledge_logs", [])
    end

    def construct_knowledge_record(board, move) do
      inspect(List.flatten(board)) <> ", " <> inspect(move)
       |> Kernel.<>(", " <> inspect(GameBoardFolder.can_fold_down?(board)))
       |> Kernel.<>(", " <> inspect(GameBoardFolder.can_fold_up?(board)))
       |> Kernel.<>(", " <> inspect(GameBoardFolder.can_fold_left?(board)))
       |> Kernel.<>(", " <> inspect(GameBoardFolder.can_fold_right?(board)))
    end

    def add_to_knowledge(pid, logtext) do
      GenServer.cast(pid,{:log,logtext})
    end

    def add_to_knowledge(pid, board, move) do
      add_to_knowledge(pid, construct_knowledge_record(board, move))
    end

    def init(logfile) do
      {:ok, logfile} # -----------logfile
    end

    def handle_cast({:log, logtext}, file_name) do
      File.chmod!(file_name,0o755)
      {:ok, file} = File.open file_name, [:append]
      IO.binwrite file, logtext <> "\n"
      File.close file
      {:noreply,file_name}
    end

end
