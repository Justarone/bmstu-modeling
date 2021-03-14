defmodule RungeKutta.Solver do
  @t0 0
  @u0 1400
  @i0 0.5
  import RungeKutta.Helper, only: [float_range_map: 5]
  import RungeKutta.InterpolatedFuncs, only: [t0: 1, rp: 1]
  import RungeKutta.MainFuncs

  def generate_t0(from, to, step) do
    float_range_map(from, to, step, [], fn cur, _lst -> t0(cur) end)
    |> Enum.reverse()
  end

  def generate_iu(from, to, step, f) do
    float_range_map(from, to, step, [{@i0, @u0}], fn xn, lst ->
      {yn, zn} = hd(lst)

      k1 = step * f.(xn, yn, zn)
      p1 = step * phi(xn, yn, zn)
      k2 = step * f.(xn + step / 2, yn + k1 / 2, zn + p1 / 2)
      p2 = step * phi(xn + step / 2, yn + k1 / 2, zn + p1 / 2)
      k3 = step * f.(xn + step / 2, yn + k2 / 2, zn + p2 / 2)
      p3 = step * phi(xn + step / 2, yn + k2 / 2, zn + p2 / 2)
      k4 = step * f.(xn + step, yn + k3, zn + k3)
      p4 = step * phi(xn + step, yn + k3, zn + k3)

      {yn + (k1 + 2 * k2 + 2 * k3 + k4) / 6, zn + (p1 + 2 * p2 + 2 * p3 + p4) / 6}
    end)
    |> Enum.reverse()
  end

  def generate_rp(from, to, step) do
    float_range_map(from, to, step, [], fn cur, _lst -> rp(cur) end)
    |> Enum.reverse()
  end
end
