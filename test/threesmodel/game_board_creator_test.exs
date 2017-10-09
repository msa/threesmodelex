defmodule GameBoardCreatorTest do
  use ExUnit.Case
  doctest Threesmodel.GameBoardCreator
  alias Threesmodel.GameBoardCreator, as: GameBoardCreator

  test "creates a board with 16 cells" do
    [line1, line2, line3, line4] = GameBoardCreator.create_game_board()
    assert (length(line1 ++ line2 ++ line3 ++ line4) == 16)
  end

  test "creates a board with zeros, ones, twos and threes" do
    values = Enum.uniq(List.flatten(GameBoardCreator.create_game_board()))
    Enum.each(values, fn(x) -> assert(Enum.member?(0..3, x)) end)
  end

end
