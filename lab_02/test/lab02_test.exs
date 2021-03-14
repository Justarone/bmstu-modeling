defmodule Lab02Test do
  use ExUnit.Case
  doctest Lab02

  test "greets the world" do
    assert Lab02.hello() == :world
  end
end
