defmodule Picard.Polynomial do
  @const_value 0

  def integral(polynom, const_value \\ @const_value) do
    for {degree, coeff} <- polynom,
        do: {degree + 1, coeff / (degree + 1)},
        into:
          %{}
          |> Map.put(0, const_value)
          |> clean
  end

  def clean(polynom), do: :maps.filter(fn d, c -> d >= 0 and c != 0 end, polynom)

  def sum(pol1, pol2), do: Map.merge(pol1, pol2, fn _k, v1, v2 -> v1 + v2 end)

  def pow(polynom, deg) do
    _pow(polynom, polynom, deg)
  end

  defp _pow(result, polynomial, deg) do
    cond do
      deg <= 1 ->
        result

      true ->
        _pow(mult(result, polynomial), polynomial, deg - 1)
    end
  end

  def mult(pol_1, pol_2) when is_map(pol_1) do
    pol_1
    |> Enum.flat_map(fn {d1, c1} -> Enum.map(pol_2, fn {d2, c2} -> {d1 + d2, c1 * c2} end) end)
    |> Enum.reduce(%{}, fn {d, c}, acc -> Map.update(acc, d, c, fn ec -> ec + c end) end)
  end

  def mult(number, pol) when is_number(number) do
    Enum.reduce(pol, %{}, fn {deg, coeff}, acc -> Map.put(acc, deg, coeff * number) end)
  end

  def value(polynom, arg) do
    Enum.reduce(polynom, 0.0, fn {deg, coeff}, acc -> coeff * :math.pow(arg, deg) + acc end)
  end

  def values_list(polynom, list) do
    Enum.map(list, &value(polynom, &1))
  end
end
