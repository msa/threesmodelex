defmodule CandidateExtractor do

  @doc """

  ## Examples

      iex> CandidateExtractor.fold_left_candidates([[1,2,3,3],[1,1,1,1],[1,1,1,1],[1,1,1,1]])
      [0]

      iex> CandidateExtractor.fold_left_candidates([[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1]])
      []

      iex> CandidateExtractor.fold_left_candidates([[1,1,1,1],[1,1,2,1],[1,1,1,1],[1,1,1,1]])
      [1]

      iex> CandidateExtractor.fold_left_candidates([[1,1,1,1],[1,1,1,1],[1,1,2,1],[1,1,1,1]])
      [2]

      iex> CandidateExtractor.fold_left_candidates([[1,1,1,1],[1,1,1,1],[1,1,1,1],[2,1,1,1]])
      [3]

      iex> CandidateExtractor.fold_left_candidates([[2,1,1,1],[1,2,1,1],[1,1,2,1],[1,1,1,2]])
      [0, 1, 2, 3]
  """

  def fold_left_candidates(board) do
    extract_candidates(board)
  end

  @doc """

  ## Examples

      iex> CandidateExtractor.fold_right_candidates([[1,2,3,3],[1,1,1,1],[1,1,1,1],[1,1,1,1]])
      [3]

      iex> CandidateExtractor.fold_right_candidates([[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1]])
      []

      iex> CandidateExtractor.fold_right_candidates([[1,1,1,1],[1,1,2,1],[1,1,1,1],[1,1,1,1]])
      [2]

      iex> CandidateExtractor.fold_right_candidates([[1,1,1,1],[1,1,1,1],[1,1,2,1],[1,1,1,1]])
      [1]

      iex> CandidateExtractor.fold_right_candidates([[1,1,1,1],[1,1,1,1],[1,1,1,1],[2,1,1,1]])
      [0]

      iex> CandidateExtractor.fold_right_candidates([[2,1,1,1],[1,2,1,1],[1,1,2,1],[1,1,1,2]])
      [0, 1, 2, 3]
  """

  def fold_right_candidates(board) do
    extract_candidates(GameBoardRotator.rotate_clockwise(board, 2))
  end

  @doc """

  ## Examples

      iex> CandidateExtractor.fold_up_candidates([[1,2,3,3],[1,1,1,1],[1,1,1,1],[1,1,1,1]])
      [2]

      iex> CandidateExtractor.fold_up_candidates([[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1]])
      []

      iex> CandidateExtractor.fold_up_candidates([[1,1,1,1],[1,1,2,1],[1,1,1,1],[1,1,1,1]])
      [1]

      iex> CandidateExtractor.fold_up_candidates([[1,1,1,1],[1,1,1,1],[1,1,2,1],[1,1,1,1]])
      [1]

      iex> CandidateExtractor.fold_up_candidates([[1,1,1,1],[1,1,1,1],[1,1,1,1],[2,1,1,1]])
      [3]

      iex> CandidateExtractor.fold_up_candidates([[2,1,1,1],[1,2,1,1],[1,1,2,1],[1,1,1,2]])
      [0, 1, 2, 3]
  """
  def fold_up_candidates(board) do
    extract_candidates(GameBoardRotator.rotate_clockwise(board, 3))
  end

  @doc """

  ## Examples

      iex> CandidateExtractor.fold_down_candidates([[1,2,3,3],[1,1,1,1],[1,1,1,1],[1,1,1,1]])
      [1]

      iex> CandidateExtractor.fold_down_candidates([[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1]])
      []

      iex> CandidateExtractor.fold_down_candidates([[1,1,1,1],[1,1,2,1],[1,1,1,1],[1,1,1,1]])
      [2]

      iex> CandidateExtractor.fold_down_candidates([[1,1,1,1],[1,1,1,1],[1,1,2,1],[1,1,1,1]])
      [2]

      iex> CandidateExtractor.fold_down_candidates([[1,1,1,1],[1,1,1,1],[1,1,1,1],[2,1,1,1]])
      [0]

      iex> CandidateExtractor.fold_down_candidates([[2,1,1,1],[1,2,1,1],[1,1,2,1],[1,1,1,2]])
      [0, 1, 2, 3]
  """
  def fold_down_candidates(board) do
    extract_candidates(GameBoardRotator.rotate_clockwise(board, 1))
  end

  def fold_candidates(board, :left) do
    fold_left_candidates(board)
  end

  def fold_candidates(board, :right) do
    fold_right_candidates(board)
  end

  def fold_candidates(board, :up) do
    fold_up_candidates(board)
  end

  def fold_candidates(board, :down) do
    fold_down_candidates(board)
  end

  def extract_candidates([a, b, c, d]) do
    candidates = %{0 => LineFolder.can_fold?(a),
      1 => LineFolder.can_fold?(b),
      2 => LineFolder.can_fold?(c),
      3 => LineFolder.can_fold?(d)}
     cand_map = Enum.filter(candidates, fn {_, v} -> v == true end)
     Enum.map(cand_map, fn {k, _} -> k end)
  end
end
