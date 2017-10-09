defmodule Threesmodel.LineFolder do
  @moduledoc """
  The LineFolder folds a single line according to the folding rules of the threes game.

  """

  @doc """
  Fold.

  ## Examples

      iex> Threesmodel.LineFolder.fold([0,0,0,0])
      [0,0,0,0]

      iex> Threesmodel.LineFolder.fold([1,1,0,0])
      [1,1,0,0]

      iex> Threesmodel.LineFolder.fold([2,2,2,0])
      [2,2,2,0]

      iex> Threesmodel.LineFolder.fold([3,2,2,0])
      [3,2,2,0]

      iex> Threesmodel.LineFolder.fold([2,2,0,0])
      [2,2,0,0]

      iex> Threesmodel.LineFolder.fold([2,2,2,0])
      [2,2,2,0]

      iex> Threesmodel.LineFolder.fold([0,1,2,0])
      [1,2,0,0]

      iex> Threesmodel.LineFolder.fold([0,0,1,2])
      [0,1,2,0]

      iex> Threesmodel.LineFolder.fold([1,2,0,0])
      [3,0,0,0]

      iex> Threesmodel.LineFolder.fold([3,0,1,2])
      [3,1,2,0]

      iex> Threesmodel.LineFolder.fold([3,1,0,2])
      [3,1,2,0]

      iex> Threesmodel.LineFolder.fold([3,2,1,0])
      [3,3,0,0]

      iex> Threesmodel.LineFolder.fold([3,3,0,0])
      [6,0,0,0]

      iex> Threesmodel.LineFolder.fold([12,6,6,0])
      [12,12,0,0]

      iex> Threesmodel.LineFolder.fold([12,12,3,3])
      [24,3,3,0]

      iex> Threesmodel.LineFolder.fold([3,3,3,3])
      [6,3,3,0]

      iex> Threesmodel.LineFolder.fold([3,1,1,3])
      [3,1,1,3]

      iex> Threesmodel.LineFolder.fold([1,3,3,1])
      [1,6,1,0]

      iex> Threesmodel.LineFolder.fold([1,2,1,2])
      [3,1,2,0]

      iex> Threesmodel.LineFolder.fold([1,2,1,2])
      [3,1,2,0]

      iex> Threesmodel.LineFolder.fold([1,2,0,3])
      [3,0,3,0]

      iex> Threesmodel.LineFolder.fold([3,1,1,1])
      [3,1,1,1]

      iex> Threesmodel.LineFolder.fold([3,6,2,2])
      [3,6,2,2]

  """
  def fold([0, i, j, k]), do: [i, j, k, 0]
  def fold([i, 0, j, k]), do: [i, j, k, 0]

  def fold([1, 1, 2, 1]), do: [1, 3, 1, 0]
  def fold([1, 1, 1, 2]), do: [1, 1, 3, 0]
  def fold([1, 1, 0, 0]), do: [1, 1, 0, 0]
  def fold([2, 1, 1, a]), do: [3, 1, a, 0]
  def fold([i, 2, 2, a]) when i != 1, do: [i, 2, 2, a]
  def fold([a, 1, 1, b]) when b != 2, do: [a, 1, 1, b]
  def fold([1, 1, a, b]) when a != b, do: [1, 1, a, b]
  def fold([1, 1, a, a]) when a > 2, do: [1, 1, a + a, 0]
  def fold([1, 1, 1, a]), do: [1, 1, 1, a]
  def fold([1, 1, 1, 1]), do: [1, 1, 1, 1]
  def fold([2, 2, 0, 2]), do: [2, 2, 2, 0]
  def fold([2, 2, 0, a]), do: [2, 2, a, 0]
  def fold([2, 2, a, b]) when a != 1, do: [2, 2, a, b]
  def fold([2, 2, 2, a]), do: [2, 2, 2, a]
  def fold([1, 2, i, j]), do: [3, i, j, 0]
  def fold([2, 1, i, j]), do: [3, i, j, 0]

  def fold([i, 1, 2, j]), do: [i, 3, j, 0]
  def fold([i, 2, 1, j]), do: [i, 3, j, 0]

  def fold([i, 1, 1, i]), do: [i, 1, 1, i]
  def fold([i, 2, 2, i]), do: [i, 2, 2, i]
  def fold([i, j, 2, 2]) when j != 1, do: [i, j, 2, 2]

  def fold([i, j, 1, 2]), do: [i, j, 3, 0]
  def fold([i, j, 2, 1]), do: [i, j, 3, 0]

  def fold([i, i, j, k]), do: [i + i, j, k, 0]
  def fold([k, i, i, j]), do: [k, i + i, j, 0]
  def fold([k, i, j, j]), do: [k, i, j + j, 0]
  def fold([i, j, 0, k]), do: [i, j, k, 0]
  def fold([i, j, k, l]), do: [i, j, k, l]

  @doc """
  Fold.

  ## Examples

      iex> Threesmodel.LineFolder.can_fold?([0,0,0,0])
      false

      iex> Threesmodel.LineFolder.can_fold?([1,0,0,0])
      false

      iex> Threesmodel.LineFolder.can_fold?([1,1,0,0])
      false

      iex> Threesmodel.LineFolder.can_fold?([1,1,1,0])
      false

      iex> Threesmodel.LineFolder.can_fold?([1,1,1,3])
      false

      iex> Threesmodel.LineFolder.can_fold?([3,1,1,1])
      false

      iex> Threesmodel.LineFolder.can_fold?([1,1,1,1])
      false

      iex> Threesmodel.LineFolder.can_fold?([2,0,0,0])
      false

      iex> Threesmodel.LineFolder.can_fold?([2,2,0,0])
      false

      iex> Threesmodel.LineFolder.can_fold?([2,2,2,0])
      false

      iex> Threesmodel.LineFolder.can_fold?([2,2,2,2])
      false

      iex> Threesmodel.LineFolder.can_fold?([3,6,12,6])
      false

      iex> Threesmodel.LineFolder.can_fold?([1,1,3,3])
      true

      iex> Threesmodel.LineFolder.can_fold?([0,0,0,1])
      true
  """
  def can_fold?(line) do
    line != fold(line)
  end
end
