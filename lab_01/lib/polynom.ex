defmodule Picard.Polynom do
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
    for {degree, coeff} <- polynom, do: {degree * deg, :math.pow(coeff, deg)}, into: %{}
  end

  def value(polynom, arg) do
    Enum.reduce(polynom, 0.0, fn ({deg, coeff}, acc) -> coeff * :math.pow(arg, deg) + acc end)
  end

  def values_list(polynom, list) do
    Enum.map(list, &value(polynom, &1))
  end
end

