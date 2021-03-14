defmodule RungeKutta.InterpolatedFuncs do
  import RungeKutta.Integral, only: [trapezoid: 4]
  @step 0.05

  @r 0.35
  @lp 12
  @tw 2000

  @m_I [
    {0.5, 6730},
    {1, 6790},
    {5, 7150},
    {10, 7270},
    {50, 8010},
    {200, 9185},
    {400, 10010},
    {800, 11140},
    {1200, 12010}
  ]
  @t0_I [
    {0.5, 0.5},
    {1, 0.55},
    {5, 1.7},
    {10, 3},
    {50, 11},
    {200, 32},
    {400, 40},
    {800, 41},
    {1200, 39}
  ]
  @sigma_T [
    {4000, 0.031},
    {5000, 0.27},
    {6000, 2.05},
    {7000, 6.06},
    {8000, 12.0},
    {9000, 19.9},
    {10000, 29.6},
    {11000, 29.6},
    {12000, 54.1},
    {13000, 67.7},
    {14000, 81.5}
  ]

  def m(i) do
    linear_interpolation(@m_I, i)
  end

  def t0(i) do
    linear_interpolation(@t0_I, i)
  end

  def sigma(i, z) do
    t0_val = t0(i)
    m_val = m(i)
    t = t0_val + (@tw - t0_val) * :math.pow(z, m_val)
    linear_interpolation(@sigma_T, t)
  end

  def rp(i) do
    @lp / (2 * :math.pi() * @r * @r * trapezoid(0, 1, @step, fn z -> sigma(i, z) * z end))
  end

  def linear_interpolation(table, arg) do
    {{x1, y1}, {x2, y2}} = find_closest_pair(table, arg)
    y1 + (y2 - y1) / (x2 - x1) * (arg - x1)
  end

  def find_closest_pair(table, arg) do
    table
    |> Stream.zip(Stream.drop(table, 1))
    |> Enum.reduce_while(nil, fn {{x1, _}, _} = pair, _acc ->
      cond do
        x1 >= arg -> {:halt, pair}
        true -> {:cont, pair}
      end
    end)
  end
end
