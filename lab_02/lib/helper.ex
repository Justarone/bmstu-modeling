defmodule RungeKutta.Helper do
  @round_precision 10
  def float_range_generator(from, to, step \\ 1) do
    float_range_map(from, to + step / 2, step, [], fn n, _lst ->
      Float.round(n / 1, @round_precision)
    end)
    |> Enum.reverse()
  end

  def float_range_map(from, to, step, lst, func) do
    if from > to do
      lst
    else
      float_range_map(from + step, to, step, [func.(from, lst) | lst], func)
    end
  end
end
