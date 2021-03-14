defmodule RungeKutta.Integral do
  import RungeKutta.Helper, only: [float_range_map: 5]

  def trapezoid(from, to, step, func) do
    float_range_map(from, to + step / 2, step, [], fn val, _acc -> func.(val) end)
    |> Stream.chunk_every(2, 1, :discard)
    |> Enum.reduce(0, fn [a, b], acc -> acc + step * (a + b) / 2 end)
  end

  def simpson(from, to, step, func) do
    n = Float.round((to - from) / step)

    float_range_map(from, to + step / 4, step / 2, [], fn val, _acc -> func.(val) end)
    |> Enum.reverse()
    |> (fn vals -> (to - from) / 6 / n * count_all_sums(vals) end).()
  end

  defp count_all_sums(vals) do
    all = Enum.reduce(vals, &Kernel.+/2)
    odds = Stream.drop(vals, 1) |> Stream.take_every(2) |> Enum.reduce(&Kernel.+/2)
    vals = Stream.drop(vals, 2) |> Enum.reverse()
    evens = Stream.drop(vals, 2) |> Stream.take_every(2) |> Enum.reduce(&Kernel.+/2)
    all + odds + 3 * evens
  end
end
