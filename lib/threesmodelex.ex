defmodule Threesmodelex do
  alias Threesmodel.GameBoardCreator, as: GameBoardCreator
  alias Threesmodel.GameBoardFolder, as: GameBoardFolder
  alias Threesmodel.CandidateExtractor, as: CandidateExtractor
  alias Threesmodel.NextNumberDeterminator, as: NextNumberDeterminator
  alias Threesmodel.NextNumberInserter, as: NextNumberInserter
  alias Threesmodel.GameScorer, as: GameScorer

  @moduledoc """
  Documentation for Threesmodelex.
  """

  @doc """

  ## Examples
  iex> board = Threesmodelex.start_new_game
  iex> Threesmodelex.is_game_over?(board)
  false

  iex> board = Threesmodelex.start_new_game
  iex> Threesmodelex.is_game_over?(board)
  iex> start_score = Threesmodelex.score_for_board(board)
  iex> score = Threesmodelex.score_for_board(Threesmodelex.fold_left(Threesmodelex.fold_right(Threesmodelex.fold_up(Threesmodelex.fold_down(board)))))
  iex> start_score < score
  true
  """

  def start_new_game do
    GameBoardCreator.create_game_board()
  end

  @doc """

  ## Examples
  iex> b = Threesmodelex.fold([[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]], :left)
  iex> b == [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
  true
  """
  def fold(board, direction) do
    fold(board, direction, CandidateExtractor.fold_candidates(board, direction))
  end

  def fold(board, _, []) do
    board
  end

  def fold(board, direction, candidates) do
    position = Enum.random(candidates)
    next_number = NextNumberDeterminator.next_number(board)
    GameBoardFolder.fold(board, direction)
      |> NextNumberInserter.insert_on_fold(direction, position, next_number)
  end

  def fold_left(board) do
    fold(board, :left)
  end

  def fold_right(board) do
    fold(board, :right)
  end

  def fold_down(board) do
    fold(board, :down)
  end

  def fold_up(board) do
    fold(board, :up)
  end

  @doc """

  ## Examples
  iex> Threesmodelex.is_game_over?([[0,0,0,1],[0,0,0,0],[0,0,0,0],[0,0,0,0]])
  false

  iex> Threesmodelex.is_game_over?([[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1]])
  true
  """
  def is_game_over?(board) do
    possible_folds(board) == []
  end

  def score_for_board(board) do
    GameScorer.score_for(board)
  end

  @doc """

  ## Examples
  iex> Threesmodelex.possible_folds([[0,0,0,1],[0,0,0,0],[0,0,0,0],[0,0,0,0]])
  [:left, :down]
  """

  def possible_folds(board) do
    [{:left, GameBoardFolder.can_fold_left?(board)},
     {:right, GameBoardFolder.can_fold_right?(board)},
     {:up, GameBoardFolder.can_fold_up?(board)},
     {:down, GameBoardFolder.can_fold_down?(board)}]
      |> Enum.filter(fn({_, outcome}) -> outcome == true end)
      |> Enum.map(fn({direction, _}) -> direction end)
  end

end
