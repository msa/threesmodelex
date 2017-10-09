defmodule NextNumberInserterTest do
  use ExUnit.Case
  doctest Threesmodel.NextNumberInserter

  alias Threesmodel.NextNumberInserter, as: NextNumberInserter

  test "can insert for left folds" do
    board = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    expected = [[0,0,0,6],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    assert (NextNumberInserter.insert_on_left_fold(board, 0, 6) == expected)
  end

  test "can insert for right folds" do
    board = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    expected = [[0,0,0,0],[6,0,0,0],[0,0,0,0],[0,0,0,0]]
    assert (NextNumberInserter.insert_on_right_fold(board, 2, 6) == expected)
  end

  test "can insert for down folds" do
    board = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    expected = [[0,6,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    assert (NextNumberInserter.insert_on_down_fold(board, 1, 6) == expected)
  end

  test "can insert for up folds" do
    board = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    expected = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[6,0,0,0]]
    assert (NextNumberInserter.insert_on_up_fold(board, 3, 6) == expected)
  end

end
