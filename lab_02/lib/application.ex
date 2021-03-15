defmodule RungeKutta.Application do
  use Application
  import RungeKutta.Runners

  def start(_, _) do
    run()
    {:ok, self()}
  end

  def run() do
    [from, to, step] =
      IO.gets("Input boundaries and step using space as separator: ")
      |> String.trim()
      |> String.split()
      |> Enum.map(fn str_float ->
        {num, _} = Float.parse(str_float)
        num
      end)

    run_simple_graphs(from, to, step)
    run_const_resistance(from, to, step, 0)
    run_const_resistance(from, to, step, 200)
  end
end
