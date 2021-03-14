defmodule RungeKutta.Runners do
  import RungeKutta.Helper
  import RungeKutta.Solver

  defp run_simple_graphs(from, to, step) do
    xs = float_range_generator(from, to, step)
    {ys, zs} = Enum.unzip(generate_iu(from, to, step, &RungeKutta.MainFuncs.f/3))
    rpns = generate_rp(from, to, step)
    t0s = generate_t0(from, to, step)
    plots = Plot.init_plot_collection()
    plots = Plot.plot(plots, xs, ys, "I")
    plots = Plot.plot(plots, xs, zs, "U")
    plots = Plot.plot(plots, xs, rpns, "Rp")
    # yn * zn
    plots = Plot.plot(plots, xs, t0s, "T0")
    Plot.show_all(plots)
  end

  defp run_const_resistance(from, to, step, c) do
    xs = float_range_generator(from, to, step)

    {ys, zs} =
      Enum.unzip(generate_iu(from, to, step, &RungeKutta.MainFuncs.f_const(&1, &2, &3, c)))

    plots = Plot.init_plot_collection()
    plots = Plot.plot(plots, xs, ys, "I (R = #{c})")
    plots = Plot.plot(plots, xs, zs, "U (R = #{c})")
    Plot.show_all(plots)
  end
end
