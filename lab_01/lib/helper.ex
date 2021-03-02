defmodule Picard.Helper do
  @round_precision 5
  def float_range_generator(from, to, step \\ 1) do
    float_range_map(from, to, step, [], fn (n, _lst) -> Float.round(n / 1, @round_precision) end)
    |> Enum.reverse
  end

  def float_range_map(from, to, step, lst, func) do
    if from > to do
      lst
    else
      float_range_map(from + step, to, step, [func.(from, lst) | lst], func)
    end
  end

  def pretty_print(lst) do
    lst
    |> Enum.zip
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.map(&1, fn (elem) ->
      cond do
        is_binary(elem) -> :io_lib.format("~20s", [elem])
        true -> :io_lib.format("~20g", [Float.round(elem / 1, @round_precision)])
      end
    end))
    |> Enum.map(&Enum.join(&1, " | "))
    |> Enum.join("\n")
    |> IO.puts
  end
end
