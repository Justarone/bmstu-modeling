defmodule Picard.Application do
  @precision_order 4

  use Application
  import Picard.OtherSolvers
  import Picard.PicardSolver

  def start(_, _) do
    run()
    {:ok, self()}
  end

  def run() do
    case Picard.Parser.read_input() do
      [xmax, step] ->
        Picard.Helper.float_range_generator(0, xmax, step)
        |> (fn (xlist) -> { xlist, generate_picard_vals_with_names(@precision_order, xlist) } end).()
        |> (fn ({xs, pvals}) -> [["X" | xs] | pvals ++ generate_other_vals_with_names(xmax, step)] end).()
        |> Picard.Helper.pretty_print

      _ -> IO.puts "Wrong input data"
    end
  end
end
