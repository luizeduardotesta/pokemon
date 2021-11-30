defmodule PokemonTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias Pokemon.Player

  describe "create_player/4" do
    test "returns a player" do
      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rng: :chute},
        name: "Red"
      }

      assert expected_response == Pokemon.create_player("Red", :chute, :soco, :cura)
    end
  end

  describe "start_game/1" do
    test "when the game starts, returns a message" do
      player = Player.build("Red", :chute, :soco, :cura)

      messages =
        capture_io(fn ->
          assert Pokemon.start_game(player) == :ok
        end)

      assert messages =~ "The game is Started!!"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("Red", :chute, :soco, :cura)

      capture_io(fn ->
        Pokemon.start_game(player)
      end)

      :ok
    end

    test "when the move is valid, do the move and the computer makes a move" do
      messages = capture_io(fn ->
        Pokemon.make_move(:chute)
      end)

        assert messages =~ "The Player attacked the computer"
        assert messages =~ "It's computer turn"
        assert messages =~ "It's player turn"
        assert messages =~ "status: :continue"
      end

    test "when the move is invalid, returns a error message" do
      messages = capture_io(fn ->
        Pokemon.make_move(:wrong)
      end)

      assert messages =~ "Invalid move: wrong"
    end

    test "when computer life < 40, return " do

    end
  end
end
