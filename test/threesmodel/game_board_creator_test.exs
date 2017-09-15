defmodule GameBoardCreatorTest do
  use ExUnit.Case
  doctest GameBoardCreator

  test "creates a board with 16 cells" do
    [line1, line2, line3, line4] = GameBoardCreator.create_game_board()
    assert (length(line1 ++ line2 ++ line3 ++ line4) == 16)
  end

  test "creates a board with zeros, ones, twos and threes" do
    [line1, line2, line3, line4] = Enum.uniq(GameBoardCreator.create_game_board())
    Enum.each(line1 ++ line2 ++ line3 ++ line4, fn(x) -> assert(Enum.member?(0..3, x)) end)
  end

end
