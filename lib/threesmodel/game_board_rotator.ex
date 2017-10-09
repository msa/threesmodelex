defmodule Threesmodel.GameBoardRotator do

  def rotate_clockwise(board, 0), do: board

  @doc """
  ## Examples
      iex> Threesmodel.GameBoardRotator.rotate_clockwise([[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]], 1)
      [[13,9,5,1],[14,10,6,2],[15,11,7,3],[16,12,8,4]]

      iex> Threesmodel.GameBoardRotator.rotate_clockwise([[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]], 2)
      [[16,15,14,13],[12,11,10,9],[8,7,6,5],[4,3,2,1]]

      iex> Threesmodel.GameBoardRotator.rotate_clockwise([[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]], 3)
      [[ 4, 8,12,16],[ 3, 7,11,15],[ 2, 6,10,14],[ 1, 5, 9,13]]

      iex> Threesmodel.GameBoardRotator.rotate_clockwise([[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]], 4)
      [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]]
  """

  def rotate_clockwise(board, times) do
    rotate_clockwise(rotate(board), times - 1)
  end

  @doc """
  ## Examples
      iex> Threesmodel.GameBoardRotator.rotate([[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]])
      [[13,9,5,1],[14,10,6,2],[15,11,7,3],[16,12,8,4]]
  """
  def rotate([[a, b, c, d], [e, f, g, h], [i, j, k, l], [m, n, o, p]]) do
    [[m, i, e, a], [n, j, f, b], [o, k, g, c], [p, l, h, d]]
  end
end
