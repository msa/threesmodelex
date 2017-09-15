defmodule GameScorer do

  @doc """

  ## Examples

      iex> GameScorer.score_for([[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]])
      0

      iex> GameScorer.score_for([[1,2,2,1],[1,2,2,1],[1,2,2,1],[1,2,2,1]])
      0

      iex> GameScorer.score_for([[24,24,24,24],[24,24,24,24],[24,24,24,24],[24,24,24,24]])
      1296

      iex> GameScorer.score_for([[3,6,12,24],[48,96,192,384],[768,1536,3072,6144],[12288,24576,0,0]])
      7174452

  """

  def score_for(game) do
    cell_scores = %{0 => 0, 1 => 0, 2 => 0, 3 => 3, 6 => 9, 12 => 27, 24 => 81, 48 => 243, 96 => 729, 192 => 2187, 384 => 6561, 768 => 19683, 1536 => 59049, 3072 => 177147, 6144 => 531441, 12288 => 1594323, 24576 => 4782969}
    flat_game = List.flatten(game)
    scores = Enum.map(flat_game, fn(cell_value) -> cell_scores[cell_value] end)
    Enum.sum(scores)
  end

end
