defmodule Pokemon.GameTest do
  use ExUnit.Case

  alias Pokemon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Red", :chute, :soco, :cura)
      computer = Player.build("Blue", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current state of the game" do
      player = Player.build("Red", :chute, :soco, :cura)
      computer = Player.build("Blue", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rng: :chute},
          name: "Blue"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rng: :chute},
          name: "Red"
        },
          status: :started,
          turn: :player
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build("Red", :chute, :soco, :cura)
      computer = Player.build("Blue", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rng: :chute},
          name: "Blue"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rng: :chute},
          name: "Red"
        },
          status: :started,
          turn: :player
      }

      assert expected_response == Game.info()

      new_state = %{
        computer: %Player{
          life: 85,
          moves: %{move_avg: :soco, move_heal: :cura, move_rng: :chute},
          name: "Blue"
        },
        player: %Player{
          life: 50,
          moves: %{move_avg: :soco, move_heal: :cura, move_rng: :chute},
          name: "Red"
        },
          status: :started,
          turn: :player
      }

      Game.update(new_state)

      assert expected_response = %{new_state | turn: :computer, status: :continue}

      assert expected_response == Game.info()
    end
  end
end
