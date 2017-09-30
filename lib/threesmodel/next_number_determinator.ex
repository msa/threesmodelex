defmodule NextNumberDeterminator do

  @moduledoc """
    Determines the value of the next cell to be introduced on the board
  """

  @doc """
  Highest_cell_on_board.

  ## Examples

      iex> NextNumberDeterminator.highest_cell_on_board([[0,0,0,0],[0,0,0,0],[0,0,48,0],[0,0,0,0]])
      48

      iex> NextNumberDeterminator.highest_cell_on_board([[48,0,0,0],[0,0,0,0],[0,0,48,0],[0,0,0,0]])
      48

      iex> NextNumberDeterminator.highest_cell_on_board([[1,2,3,6],[12,24,48,96],[192,384,768,1536],[0,0,0,0]])
      1536
  """
  def highest_cell_on_board([line1, line2, line3, line4]) do
    Enum.max(line1 ++ line2 ++ line3 ++ line4)
  end

  @doc """
  High candidates.

  ## Examples

      iex> NextNumberDeterminator.high_candidates([[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]])
      []

      iex> NextNumberDeterminator.high_candidates([[48,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]])
      [6,12]

      iex> NextNumberDeterminator.high_candidates([[1,2,3,6],[12,24,48,96],[192,384,0,0],[0,0,0,0]])
      [6,12,24,48,96]

      iex> NextNumberDeterminator.high_candidates([[1,2,3,6],[12,24,48,96],[192,384,768,1536],[0,0,0,0]])
      [6,12,24,48,96,192,384]

      iex> NextNumberDeterminator.high_candidates([[1,2,3,6],[12,24,48,96],[192,384,768,1536],[12288,0,0,0]])
      [6,12,24,48,96,192,384,768,1536,3072]
  """
  def high_candidates(board) do
    Enum.filter([6,12,24,48,96,192,384,768,1536,3072,6144,12288], fn(x) -> x < (highest_cell_on_board(board)/2) end )
  end

  def next_number(board) do
    Enum.random([1,2,3] ++ high_candidates(board))
  end
end
