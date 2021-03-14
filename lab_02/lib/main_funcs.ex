defmodule RungeKutta.MainFuncs do
  @ck 268.0e-6
  @rk 0.25
  @lk 187.0e-6
  import RungeKutta.InterpolatedFuncs, only: [rp: 1]

  def f(_x, u, v) do
    (v - (@rk + rp(u)) * u) / @lk
  end

  def f_const(_x, u, v, c) do
    (v - c * u) / @lk
  end

  def phi(_x, u, _v) do
    -u / @ck
  end
end
