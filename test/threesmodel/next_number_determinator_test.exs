defmodule NextNumberDeterminatorTest do
  use ExUnit.Case
  doctest NextNumberDeterminator

  test "an empty board can only get new cells with 1, 2 or 3" do
      assert (NextNumberDeterminator.next_number([[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]) < 6)
  end

  test "an board with a high number allows for more values" do
      assert (NextNumberDeterminator.next_number([[0,0,0,0],[0,0,768,0],[0,0,0,0],[0,0,0,0]]) < 384)
  end

end
