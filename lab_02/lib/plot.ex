defmodule RungeKutta.Plot do
  def init_plot_collection() do
    {[], []}
  end

  def plot({params, plots}, xs, ys, title \\ "plot") do
    #many graphics on one plot version
    #ind = Enum.count(params) + 1
    #params = [["-", :title, title, :with, :lines, :ls, ind] | params]
    params = [[[:set, :title, title], [:plot, "-", :with, :lines], ~w(set grid)a] | params]
      plots = [Stream.zip(xs, ys) |> Stream.map(&Tuple.to_list/1) |> Enum.drop(2) | plots]
    {params, plots}
  end

  def show_all({params, plots}) do
    Stream.zip(params, plots)
    |> Enum.map(fn {param, plot} ->
      try do
        Gnuplot.plot(
          param,
          [plot]
        )
      rescue
        _e in MatchError -> IO.puts("GNUPlot throws errors again:(")
      end
    end)
    #many graphics on one plot version
    #try do
      #Gnuplot.plot([
        #Gnuplot.plots(params)
      #],
        #plots
      #)
    #rescue
      #_e in MatchError -> IO.puts("adsfjkl;")
    #end
  end
end
