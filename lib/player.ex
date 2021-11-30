defmodule Pokemon.Player do
  @required_keys [:life, :moves, :name]
  @max_life 100

  @enforce_keys @required_keys
  defstruct @required_keys

  def build(name, move_rng, move_avg, move_heal) do
    %Pokemon.Player{
      life: @max_life,
      moves: %{
        move_avg: move_avg,
        move_heal: move_heal,
        move_rng: move_rng
      },
      name: name
    }
  end
end
