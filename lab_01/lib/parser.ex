defmodule Picard.Parser do
  def read_input do
    IO.gets("Введите максимальный X и шаг через пробел: ")
    |> String.trim()
    |> String.split()
    |> Enum.map(&(Float.parse(&1) |> elem(0)))
  end
end
