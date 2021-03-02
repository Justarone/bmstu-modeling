defmodule Picard.PicardSolver do
  alias Picard.Polynom
  @x_degree 2
  @x_coeff 1
  @y_degree 2

  def f(x, y), do: :math.pow(@x_coeff * x, @x_degree) + :math.pow(y, @y_degree)

  def generate_picard_vals_with_names(precision_order, xlist) do
    generate_picard_values(precision_order, xlist)
    |> Enum.with_index(1)
    |> Enum.map(fn ({vals, index}) -> ["Picard #{index} precision order" | vals] end)

  end

  def generate_picard_values(precision_order, xlist) do
     picard_solvers_list(precision_order)
     |> Enum.map(&Polynom.values_list(&1, xlist))
  end

  def picard_solvers_list(precision_order) do
    Enum.reverse(picard_solvers(%{}, precision_order, []))
  end

  defp picard_solvers(polynom_y, precision_order, lst) do
    case precision_order do
      0 ->
        lst

      _ ->
        polynom_y = new_picard_solver(polynom_y)
        picard_solvers(polynom_y, precision_order - 1, [polynom_y | lst])
    end
  end

  defp new_picard_solver(polynom_y) do
    Polynom.sum(%{@x_degree => @x_coeff}, Polynom.pow(polynom_y, @y_degree))
    |> Polynom.integral()
  end
end

