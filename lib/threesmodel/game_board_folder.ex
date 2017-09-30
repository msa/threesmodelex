defmodule GameBoardFolder do

  @doc """

  ## Examples

      iex> GameBoardFolder.can_fold_left?([[1,2,3,3],[1,1,1,1],[1,1,1,1],[1,1,1,1]])
      true

      iex> GameBoardFolder.can_fold_left?([[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1]])
      false

      iex> GameBoardFolder.can_fold_left?([[1,2,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1]])
      true
  """

  def can_fold_left?(board) do
    can_fold?(board)
  end

  @doc """

      iex> GameBoardFolder.can_fold_right?([[1,2,3,3],[1,1,1,1],[1,1,1,1],[1,1,1,1]])
      true

      iex> GameBoardFolder.can_fold_right?([[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1]])
      false

      iex> GameBoardFolder.can_fold_right?([[1,2,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1]])
      true
  """

  def can_fold_right?(board) do
    rotated_board = GameBoardRotator.rotate_clockwise(board, 2)
    can_fold?(rotated_board)
  end

  @doc """

  ## Examples

      iex> GameBoardFolder.can_fold_up?([[1,1,3,3],[1,1,1,1],[1,1,1,1],[1,1,1,1]])
      false

      iex> GameBoardFolder.can_fold_up?([[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1]])
      false

      iex> GameBoardFolder.can_fold_up?([[1,2,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1]])
      true
  """

  def can_fold_up?(board) do
    rotated_board = GameBoardRotator.rotate_clockwise(board, 3)
    can_fold?(rotated_board)
  end


  @doc """

  ## Examples

      iex> GameBoardFolder.can_fold_down?([[1,1,3,3],[1,1,1,1],[1,1,1,1],[1,1,1,1]])
      false

      iex> GameBoardFolder.can_fold_down?([[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1]])
      false

      iex> GameBoardFolder.can_fold_down?([[0,0,0,0],[1,1,1,1],[1,1,1,1],[1,1,1,1]])
      false

      iex> GameBoardFolder.can_fold_down?([[1,1,1,0],[1,1,1,0],[1,1,1,0],[1,1,1,0]])
      false

      iex> GameBoardFolder.can_fold_down?([[1,1,1,1],[1,1,1,1],[0,0,0,0],[1,1,1,1]])
      true

      iex> GameBoardFolder.can_fold_down?([[1,2,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1]])
      true
  """

  def can_fold_down?(board) do
    GameBoardRotator.rotate_clockwise(board, 1) |> can_fold?()
  end

  defp can_fold?(board) do
    Enum.any?(board, fn(line) -> LineFolder.can_fold?(line) end)
  end

  @doc """

  ## Examples

      iex> GameBoardFolder.fold_left([[1,1,3,3],[1,1,1,1],[1,1,1,1],[1,1,1,1]])
      [[1,1,6,0],[1,1,1,1],[1,1,1,1],[1,1,1,1]]

  """
  def fold_left(board) do
    rotate_fold_rotate(board, 0, 0)
  end

  @doc """

  ## Examples

      iex> GameBoardFolder.fold_right([[1,1,3,3],[1,1,1,1],[1,1,1,1],[1,1,1,1]])
      [[0,1,1,6],[1,1,1,1],[1,1,1,1],[1,1,1,1]]

  """
  def fold_right(board) do
    rotate_fold_rotate(board, 2, 2)
  end

  @doc """

  ## Examples

      iex> GameBoardFolder.fold_down([[1,1,3,3],[1,2,3,3],[1,1,1,1],[1,1,1,1]])
      [[1,0,0,0],[1,1,6,6],[1,3,1,1],[1,1,1,1]]

  """
  def fold_down(board) do
    rotate_fold_rotate(board, 1, 3)
  end

  @doc """

  ## Examples

      iex> GameBoardFolder.fold_up([[1,1,3,3],[1,2,3,3],[1,1,1,1],[1,1,1,1]])
      [[1,3,6,6],[1,1,1,1],[1,1,1,1],[1,0,0,0]]

  """
  def fold_up(board) do
    rotate_fold_rotate(board, 3, 1)
  end

  def rotate_fold_rotate(board, first_rotation, second_rotation) do
    GameBoardRotator.rotate_clockwise(board, first_rotation)
      |> Enum.map(fn(line) -> LineFolder.fold(line) end)
      |> GameBoardRotator.rotate_clockwise(second_rotation)
  end

  def fold(board, :up) do
    fold_up(board)
  end

  def fold(board, :down) do
    fold_down(board)
  end

  def fold(board, :left) do
    fold_left(board)
  end

  def fold(board, :right) do
    fold_right(board)
  end

end
