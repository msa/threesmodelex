defmodule Threesmodel.GameBoardCreator do

  def create_game_board() do
    positions = random_positions(9)
    empty_board = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    board = add_positions(positions, empty_board)
    create_matrix(board)
  end

  def add_positions(positions, board) do
    add_position(positions, board)
  end

  def add_position([], board), do: board

  def add_position([position | positions], board) do
    add_position(positions, List.insert_at(List.delete_at(board, position), position, Enum.random(1..3)))
  end

  def random_positions(number_of_positions) do
    Enum.take(Enum.shuffle(0..15), number_of_positions)
  end

  def create_matrix([a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p]) do
    [[a, b, c, d], [e, f, g, h], [i, j, k, l], [m, n, o, p]]
  end
end
