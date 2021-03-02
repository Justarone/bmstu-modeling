defmodule Lab01Test do
  use ExUnit.Case
  doctest Lab01

  test "greets the world" do
    assert Lab01.hello() == :world
  end
end
