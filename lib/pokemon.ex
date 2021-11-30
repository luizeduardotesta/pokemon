defmodule Pokemon do
  alias Pokemon.{Player, Game}
  alias Pokemon.Game.{Actions, Status}

  @computer_name "Robocop"
  @computer_moves [:move_avg, :move_rng, :move_heal]
  @computer_moves2 [:move_avg, :move_rng, :move_heal, :move_heal]

  def create_player(name, move_rng, move_avg, move_heal) do
    Player.build(name, move_rng, move_avg, move_heal)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:punch, :kick, :heal)
    |> Game.start(player)

    Status.print_round_message(Game.info())
  end

  def make_move(move) do
    Game.info()
    |> Map.get(:status)
    |> handle_status(move)

    move
    |> Actions.fetch_move()
    |> do_move()

    computer_move(Game.info())
  end

  defp handle_status(:game_over, _move), do: Status.print_round_message(Game.info())

  defp handle_status(_other, move) do
    move
    |> Actions.fetch_move()
    |> do_move()

    computer_move(Game.info())
  end

  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)

  defp do_move({:ok, move}) do
    case move do
      :move_heal -> Actions.heal()
      move -> Actions.attack(move)
    end

    Status.print_round_message(Game.info())
  end

  defp computer_move(%{turn: :computer, status: :continue, computer: %{life: life}}) do
    move = {:ok, Enum.random(@computer_moves)}

    move2 = {:ok, Enum.random(@computer_moves2)}
    move = if life < 40, do: move2 , else: move
    do_move(move)
  end

  defp computer_move(_), do: :ok
end