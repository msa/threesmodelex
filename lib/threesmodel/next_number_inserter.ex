defmodule Threesmodel.NextNumberInserter do
  alias Threesmodel.GameBoardRotator, as: GameBoardRotator

  def insert(board, position, number_to_insert, first_rotation, second_rotation) do
    GameBoardRotator.rotate_clockwise(board, first_rotation)
    |> List.update_at(position, &List.replace_at(&1, 3, number_to_insert))
    |> GameBoardRotator.rotate_clockwise(second_rotation)
  end

  def insert_on_left_fold(board, position, number_to_insert) do
    insert(board, position, number_to_insert, 0, 0)
  end

  def insert_on_right_fold(board, position, number_to_insert) do
    insert(board, position, number_to_insert, 2, 2)
  end

  def insert_on_down_fold(board, position, number_to_insert) do
    insert(board, position, number_to_insert, 1, 3)
  end

  def insert_on_up_fold(board, position, number_to_insert) do
    insert(board, position, number_to_insert, 3, 1)
  end

  def insert_on_fold(board, :left, position, number_to_insert) do
    insert_on_left_fold(board, position, number_to_insert)
  end

  def insert_on_fold(board, :right, position, number_to_insert) do
    insert_on_right_fold(board, position, number_to_insert)
  end

  def insert_on_fold(board, :up, position, number_to_insert) do
    insert_on_up_fold(board, position, number_to_insert)
  end

  def insert_on_fold(board, :down, position, number_to_insert) do
    insert_on_down_fold(board, position, number_to_insert)
  end
end
