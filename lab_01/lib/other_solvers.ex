defmodule Picard.OtherSolvers do
  @alpha 1
  import Picard.Helper, only: [float_range_map: 5]
  import Picard.PicardSolver, only: [f: 2]

  def generate_other_vals_with_names(from \\ 0, to, step) do
    [["Runge-Kutta method" | generate_runge_kutta_values(from, to, step, @alpha)],
      ["Euler method" | generate_euler_values(from, to, step)]]
  end

  def generate_runge_kutta_values(from, to, step, alpha \\ 1) do
    rk_func = fn (xn, ys) -> 
      yn = hd(ys)
      k1 = f(xn, yn)
      k2 = f(xn + step / 2 / alpha, yn + step / 2 / alpha * k1)
      yn + step * ((1 - alpha) * k1 + alpha * k2)
    end
    float_range_map(from, to, step, [0], rk_func)
    |> Enum.reverse
  end

  def generate_euler_values(from, to, step) do
    float_range_map(from, to, step, [0], fn (xn, ys) -> hd(ys) + f(xn, hd(ys)) end)
    |> Enum.reverse
  end
end

